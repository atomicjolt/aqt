class ApplicationController < ActionController::Base

  include ::Api
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_rollbar_scope

  helper_method :current_application_instance,
                :current_bundle_instance,
                :current_canvas_course,
                :canvas_url,
                :targeted_app_instance,
                :current_user_roles

  # BEGIN - faked from canvas
  attr_accessor :active_tab

  def require_context
    @context = Course.find(params[:course_id])
  end

  # obviously this will need to be addressed
  def authorized_action(_object, _actor, _rights)
    true
  end

  def tab_enabled?(_id, _opts = {})
    true
  end

  def setup_master_course_restrictions(_objects, _course, _user_can_edit: false)
    :master
  end

  def feature_enabled?(_feature)
    false
  end

  def external_tools_display_hashes(_type, _context=@context, _custom_settings=[], tools_ids: nil)
    []
  end

  def conditional_release_js_env(_assignment = nil, includes: []); end

  def log_asset_access(_asset, _asset_category, _asset_group=nil, _level=nil, _membership_type=nil, overwrite:true, context: nil)
  end

  def rce_js_env
  end
  # END - faked from canvas

  # BEGIN - real from canvas

  def css_bundles
    @css_bundles ||= []
  end
  helper_method :css_bundles

  def css_bundle(*args)
    opts = (args.last.is_a?(Hash) ? args.pop : {})
    Array(args).flatten.each do |bundle|
      css_bundles << [bundle, opts[:plugin]] unless css_bundles.include? [bundle, opts[:plugin]]
    end
    nil
  end
  helper_method :css_bundle

  def js_bundles; @js_bundles ||= []; end
  helper_method :js_bundles

  # Use this method to place a bundle on the page, note that the end goal here
  # is to only ever include one bundle per page load, so use this with care and
  # ensure that the bundle you are requiring isn't simply a dependency of some
  # other bundle.
  #
  # Bundles are defined in app/coffeescripts/bundles/<bundle>.coffee
  #
  # usage: js_bundle :gradebook
  #
  # Only allows multiple arguments to support old usage of jammit_js
  #
  # Optional :plugin named parameter allows you to specify a plugin which
  # contains the bundle. Example:
  #
  # js_bundle :gradebook, :plugin => :my_feature
  #
  # will look for the bundle in
  # /plugins/my_feature/(optimized|javascripts)/compiled/bundles/ rather than
  # /(optimized|javascripts)/compiled/bundles/
  def js_bundle(*args)
    opts = (args.last.is_a?(Hash) ? args.pop : {})
    Array(args).flatten.each do |bundle|
      js_bundles << [bundle, opts[:plugin], false] unless js_bundles.include? [bundle, opts[:plugin], false]
    end
    nil
  end
  helper_method :js_bundle

  def add_body_class(*args)
    @body_classes ||= []
    raise "call add_body_class for #{args} in the controller when using streaming templates" if @streaming_template && (args - @body_classes).any?
    @body_classes += args
  end
  helper_method :add_body_class

  def body_classes; @body_classes ||= []; end
  helper_method :body_classes

  ##
  # Sends data from rails to JavaScript
  #
  # The data you send will eventually make its way into the view by simply
  # calling `to_json` on the data.
  #
  # It won't allow you to overwrite a key that has already been set
  #
  # Please use *ALL_CAPS* for keys since these are considered constants
  # Also, please don't name it stuff from JavaScript's Object.prototype
  # like `hasOwnProperty`, `constructor`, `__defineProperty__` etc.
  #
  # This method is available in controllers and views
  #
  # example:
  #
  #     # ruby
  #     js_env :FOO_BAR => [1,2,3], :COURSE => @course
  #
  #     # coffeescript
  #     require ['ENV'], (ENV) ->
  #       ENV.FOO_BAR #> [1,2,3]
  #
  def js_env(hash = {}, overwrite = false)
    return {} unless request.format.html? || request.format == "*/*" || @include_js_env

    # disabling for now - will enable as things are needed
    return @js_env || @js_env = hash

    if hash.present? && @js_env_has_been_rendered
      add_to_js_env(hash, @js_env_data_we_need_to_render_later, overwrite)
      return
    end

    # set some defaults
    unless @js_env
      benchmark("init @js_env") do
        editor_css = [
          active_brand_config_url('css'),
          view_context.stylesheet_path(css_url_for('what_gets_loaded_inside_the_tinymce_editor'))
        ]

        editor_hc_css = [
          active_brand_config_url('css', { force_high_contrast: true }),
          view_context.stylesheet_path(css_url_for('what_gets_loaded_inside_the_tinymce_editor', false, { force_high_contrast: true }))
        ]

        # Cisco doesn't want to load lato extended. see LS-1559
        if (Setting.get('disable_lato_extended', 'false') == 'false')
          editor_css << view_context.stylesheet_path(css_url_for('lato_extended'))
          editor_hc_css << view_context.stylesheet_path(css_url_for('lato_extended'))
        else
          editor_css << view_context.stylesheet_path(css_url_for('lato'))
          editor_hc_css << view_context.stylesheet_path(css_url_for('lato'))
        end

        @js_env_data_we_need_to_render_later = {}
        @js_env = {
          ASSET_HOST: Canvas::Cdn.add_brotli_to_host_if_supported(request),
          active_brand_config_json_url: active_brand_config_url('json'),
          url_to_what_gets_loaded_inside_the_tinymce_editor_css: editor_css,
          url_for_high_contrast_tinymce_editor_css: editor_hc_css,
          current_user_id: @current_user.try(:id),
          current_user_roles: @current_user.try(:roles, @domain_root_account),
          current_user_types: @current_user.try{|u| u.account_users.map{|t| t.readable_type }},
          current_user_disabled_inbox: @current_user.try(:disabled_inbox?),
          files_domain: HostUrl.file_host(@domain_root_account || Account.default, request.host_with_port),
          DOMAIN_ROOT_ACCOUNT_ID: @domain_root_account.try(:global_id),
          k12: k12?,
          use_responsive_layout: use_responsive_layout?,
          use_rce_enhancements: (@context.is_a?(User) ? @domain_root_account : @context).try(:feature_enabled?, :rce_enhancements),
          rce_auto_save: @context.try(:feature_enabled?, :rce_auto_save),
          help_link_name: help_link_name,
          help_link_icon: help_link_icon,
          use_high_contrast: @current_user.try(:prefers_high_contrast?),
          disable_celebrations: @current_user.try(:prefers_no_celebrations?),
          disable_keyboard_shortcuts: @current_user.try(:prefers_no_keyboard_shortcuts?),
          LTI_LAUNCH_FRAME_ALLOWANCES: Lti::Launch.iframe_allowances(request.user_agent),
          DEEP_LINKING_POST_MESSAGE_ORIGIN: request.base_url,
          DEEP_LINKING_LOGGING: Setting.get('deep_linking_logging', nil),
          SETTINGS: {
            open_registration: @domain_root_account.try(:open_registration?),
            collapse_global_nav: @current_user.try(:collapse_global_nav?),
            show_feedback_link: show_feedback_link?
          },
        }

        @js_env[:flashAlertTimeout] = 1.day.in_milliseconds if @current_user.try(:prefers_no_toast_timeout?)
        @js_env[:KILL_JOY] = @domain_root_account.kill_joy? if @domain_root_account&.kill_joy?

        cached_features = cached_js_env_account_features
        @js_env[:DIRECT_SHARE_ENABLED] = cached_features.delete(:direct_share) && !@context.is_a?(Group) && @current_user&.can_content_share?
        @js_env[:FEATURES] = cached_features.merge(
          canvas_k6_theme: @context.try(:feature_enabled?, :canvas_k6_theme)
        )
        @js_env[:current_user] = @current_user ? Rails.cache.fetch(['user_display_json', @current_user].cache_key, :expires_in => 1.hour) { user_display_json(@current_user, :profile, [:avatar_is_fallback]) } : {}
        @js_env[:page_view_update_url] = page_view_path(@page_view.id, page_view_token: @page_view.token) if @page_view
        @js_env[:IS_LARGE_ROSTER] = true if !@js_env[:IS_LARGE_ROSTER] && @context.respond_to?(:large_roster?) && @context.large_roster?
        @js_env[:context_asset_string] = @context.try(:asset_string) if !@js_env[:context_asset_string]
        @js_env[:ping_url] = polymorphic_url([:api_v1, @context, :ping]) if @context.is_a?(Course)
        @js_env[:TIMEZONE] = Time.zone.tzinfo.identifier if !@js_env[:TIMEZONE]
        @js_env[:CONTEXT_TIMEZONE] = @context.time_zone.tzinfo.identifier if !@js_env[:CONTEXT_TIMEZONE] && @context.respond_to?(:time_zone) && @context.time_zone.present?
        unless @js_env[:LOCALE]
          I18n.set_locale_with_localizer
          @js_env[:LOCALE] = I18n.locale.to_s
          @js_env[:BIGEASY_LOCALE] = I18n.bigeasy_locale
          @js_env[:FULLCALENDAR_LOCALE] = I18n.fullcalendar_locale
          @js_env[:MOMENT_LOCALE] = I18n.moment_locale
        end

        @js_env[:lolcalize] = true if ENV['LOLCALIZE']
        @js_env[:rce_auto_save_max_age_ms] = Setting.get('rce_auto_save_max_age_ms', 1.day.to_i * 1000).to_i if @js_env[:rce_auto_save]
      end
    end

    add_to_js_env(hash, @js_env, overwrite)

    @js_env
  end
  helper_method :js_env

  def render_js_env
    res = StringifyIds.recursively_stringify_ids(js_env.clone).to_json
    @js_env_has_been_rendered = true
    res
  end
  helper_method :render_js_env

  # used to generate context-specific urls without having to
  # check which type of context it is everywhere
  def named_context_url(context, name, *opts)
    # disabling for now
    if false # context.is_a?(UserProfile)
      name = name.to_s.sub(/context/, "profile")
    else
      klass = context.class.base_class
      name = name.to_s.sub(/context/, klass.name.underscore)
      opts.unshift(context)
    end
    opts.push({}) unless opts[-1].is_a?(Hash)
    include_host = opts[-1].delete(:include_host)
    unless include_host
      # rubocop:disable Style/RescueModifier
      opts[-1][:host] = context.host_name rescue nil
      # rubocop:enable Style/RescueModifier
      opts[-1][:only_path] = true unless name.end_with?("_path")
    end
    self.send name, *opts
  end
  # END - real from canvas

  protected

  def after_invite_path_for(_inviter, _invitee)
    users_path
  end

  def after_accept_path_for(_resource)
    admin_root_path
  end

  def render_error(status, message, json_options = {})
    respond_to do |format|
      format.html { render template: "errors/#{status}", layout: "errors", status: status }
      format.json do
        render json: {
          message: message,
        }.merge(json_options), status: status
      end
    end
  end

  def invalid_request(message)
    render_error 400, message
  end

  def user_not_authorized(message = "")
    render_error 401, message
  end

  def record_exception(exception)
    Rollbar.error(exception) if current_application_instance.rollbar_enabled?
    Rails.logger.error "Unexpected exception during execution"
    Rails.logger.error "#{exception.class.name} (#{exception.message}):"
    Rails.logger.error "  #{exception.backtrace.join("\n  ")}"
  end

  # NOTE: Exceptions are specified in order of most general at the top with more specific at the bottom

  # Exceptions defined in order of increasing specificity.
  rescue_from Exception, with: :internal_error
  def internal_error(exception)
    record_exception(exception)
    render_error 500, "Internal error: #{exception.message}"
  end

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  def not_found
    render_error 404, "Unable to find the requested record"
  end

  rescue_from CanCan::AccessDenied, with: :permission_denied
  def permission_denied(exception = nil)
    message = exception.present? ? exception.message : "Permission denied"
    render_error 403, message
  end

  # Handle other Canvas related exceptions
  rescue_from LMS::Canvas::CanvasException, with: :handle_canvas_exception
  def handle_canvas_exception(exception)
    record_exception(exception)
    render_error 500, "Error while accessing Canvas: #{exception.message}.", { exception: exception }
  end

  # Raised when a new token cannot be retrieved using the refresh token
  rescue_from LMS::Canvas::RefreshTokenFailedException, with: :handle_canvas_token_expired

  # Raised if a refresh token or its options are not available
  rescue_from LMS::Canvas::RefreshTokenRequired, with: :handle_canvas_token_expired
  def handle_canvas_token_expired(exception)
    # Auth has gone bad. Remove it and request that the user do OAuth
    user = nil
    if auth = Authentication.find_by(id: exception.auth&.id)
      user = auth.user
      auth.destroy
    end
    json_options = {}
    if current_application_instance.oauth_precedence.include?("user") || # The application allows for user tokens
        current_user == user # User owns the authentication. We can ask them to refresh
      json_options = {
        canvas_authorization_required: true,
      }
    end
    render_error 401, "Canvas API Token has expired.", json_options
  end

  # Raised when no Canvas token is available
  rescue_from Exceptions::CanvasApiTokenRequired, with: :handle_canvas_token_required
  def handle_canvas_token_required(exception)
    json_options = {
      exception: exception,
      canvas_authorization_required: true,
    }
    render_error 401, "Unable to find valid Canvas API Token.", json_options
  end

  rescue_from LMS::Canvas::InvalidAPIRequestFailedException, with: :handle_invalid_canvas_api_request
  def handle_invalid_canvas_api_request(exception)
    json_options = {
      exception: exception,
      backtrace: exception.backtrace,
    }
    render_error 500, "An error occured when calling the Canvas API: #{exception.message}", json_options
  end

  def set_rollbar_scope
    if !current_application_instance.rollbar_enabled?
      Rollbar.configure { |config| config.enabled = false }
    end
    Rollbar.scope!(
      tenant: Apartment::Tenant.current,
    )
  end

  # **********************************************
  # Paging methods
  #
  def setup_will_paginate
    @page = (params[:page] || 1).to_i
    @page = 1 if @page < 1
    @per_page = (params[:per_page] || (Rails.env.test? ? 1 : 40)).to_i
  end

  def canvas_url
    @canvas_url ||= session[:canvas_url] ||
      custom_canvas_api_domain ||
      current_application_instance&.site&.url ||
      current_bundle_instance&.site&.url
  end

  def custom_canvas_api_domain
    if params[:custom_canvas_api_domain].present?
      "https://#{params[:custom_canvas_api_domain]}"
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def current_application_instance
    @current_application_instance ||=
      LtiAdvantage::Authorization.application_instance_from_token(request.params["id_token"]) ||
      ApplicationInstance.find_by(lti_key: Lti::Request.oauth_consumer_key(request)) ||
      ApplicationInstance.find_by(domain: request.host_with_port) ||
      ApplicationInstance.find_by(id: params[:application_instance_id])
  end

  def current_canvas_course
    lms_course_id = params[:custom_canvas_course_id] || params[:lms_course_id]
    @canvas_course ||= CanvasCourse.find_by(lms_course_id: lms_course_id)
  end

  def current_application
    Application.find_by(key: request.subdomains.first)
  end

  def current_bundle_instance
    @current_bundle ||= BundleInstance.
      where(id_token: params[:bundle_instance_token]).
      or(BundleInstance.where(id: params[:bundle_instance_id])).
      first
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, params[:context_id])
  end

  def current_user_roles(context_id: nil)
    current_user.nil_or_context_roles(context_id).map(&:name)
  end

  def set_lti_launch_values
    @is_lti_launch = true
    @canvas_url = current_application_instance.site.url
    @app_name = current_application_instance.application.client_application_name
  end

  def set_lti_advantage_launch_values
    @lti_token = LtiAdvantage::Authorization.validate_token(
      current_application_instance,
      params[:id_token],
    )
    @lti_params = LtiAdvantage::Params.new(@lti_token)
    @lti_launch_config = JSON.parse(params[:lti_launch_config]) if params[:lti_launch_config]
    @is_deep_link = true if LtiAdvantage::Definitions.deep_link_launch?(@lti_token)
    @app_name = current_application_instance.application.client_application_name
    @title = current_application_instance.application.name
    @description = current_application_instance.application.description
  end

  def targeted_app_instance
    key = request.subdomains.first
    application = Application.find_by(key: key)
    return nil if current_bundle_instance.nil?
    current_bundle_instance.
      application_instances.
      find_by(application_id: application.id)
  end

end
