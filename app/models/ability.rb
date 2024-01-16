class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new
    if user.owner?
      can :manage, Restaurant
      can :manage, :all
    elsif user.customer?
      can :read, Restaurant
      can :manage, Order
      can :manage, Menu
      can :manage , CartItem
      can :manage, Cart
    elsif user.admin?
      can :manage, :all
    else
      can :read, Restaurant
    end
  end
end
