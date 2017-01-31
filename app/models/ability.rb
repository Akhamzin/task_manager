class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #user ||= User.new # guest user (not logged in)
      if user.has_role? :admin
        can :manage, :all
      else
        can :create, Task
        can :show, Task do |task|
          task.client == user
        end
        can :read, Task do |task|
          task.client.company_name == user.company_name
        end
        can :create, Comment
        # can :read, :all
      end
  end
end
