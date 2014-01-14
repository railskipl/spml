class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user
    if user.is_admin?
      can :manage, :all
    else
      can :read, :all
    end
  end

end