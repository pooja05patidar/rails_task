class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new
    if user.owner?
      can :manage, Restaurant, user_id: user.id
      can :manage, :all
    elsif user.customer?
      can :read, Restaurant
      can :manage, Order
      can :read, Menu
      can :manage , CartItem
      can :manage, Cart, user_id: user.id
    elsif user.admin?
      can :manage, :all
    else
      can :read, Restaurant
    end
  end
end
