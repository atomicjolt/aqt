class Ability
  include CanCan::Ability

  def initialize(user, context_id = nil)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

    user ||= User.new # guest user (not logged in)

    basic(user)
    canvas_oauth_user(user) if user.role?("canvas_oauth_user", context_id)
    admin(user) if user.admin?
  end

  def basic(user)
    can :manage, User, id: user.id
    can :manage, LtiLaunch
  end

  def canvas_oauth_user(_user); end

  def admin(_user)
    can :manage, :all
  end

end
