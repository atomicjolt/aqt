admin = CreateAdminService.create_admin
puts "CREATED ADMIN USER: " << admin.email

# Add an LTI Application
applications = [{
  name: "LTI Admin",
  description: "LTI tool administration",
  client_application_name: "lti_admin_app",
  canvas_api_permissions: "",
}, {
  name: "LTI Starter App",
  description: "LTI Starter App by Atomic Jolt",
  client_application_name: "app",
  # List Canvas API methods the app is allowed to use. A full list of constants can be found in canvas_urls
  canvas_api_permissions: "LIST_ACCOUNTS",
}]

application_instances = [{
  application: "LTI Admin",
  lti_key: "lti-admin-tool",
  lti_consumer_uri: "https://atomicjolt.instructure.com",
  domain: Rails.application.secrets.application_url
}, {
  application: "LTI Starter App",
  lti_key: Rails.application.secrets.default_lti_key,
  lti_secret: Rails.application.secrets.default_lti_secret,
  lti_consumer_uri: "https://atomicjolt.instructure.com",
  # This is only required if the app needs API access and doesn't want each user to do the oauth dance
  canvas_token: Rails.application.secrets.canvas_token,
  # Each application instance can have it's own custom domain. Typically, this is not needed
  # as the application will use the oauth_consumer_key from the LTI launch to partition different
  # application instances. However, if Canvas is launching the LTI tool based on url then you will
  # need a different domain for that tool since Canvas uses the domain to find the LTI tool among
  # all installed LTI tools. If two tools share the same domain then the tool discovered by Canvas
  # to do the LTI launch will be indeterminate
  domain: "admin.#{ENV['APP_URL']}"
}]

applications.each do |attrs|
  if application = Application.find_by(name: attrs[:name])
    application.update_attributes!(attrs)
  else
    Application.create!(attrs)
  end
end

application_instances.each do |attrs|
  application = Application.find_by(name: attrs.delete(:application))
  attrs = attrs.merge(application_id: application.id)
  if application_instance = ApplicationInstance.find_by(lti_key: attrs[:lti_key])
    # Don't change production lti keys or set keys to nil
    attrs.delete(:lti_secret) if attrs[:lti_secret].blank? || Rails.env.production?

    application_instance.update_attributes!(attrs)
  else
    ApplicationInstance.create!(attrs)
  end
end

Lti::Utils.lti_configs
