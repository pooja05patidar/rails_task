# frozen_string_literal: true

# ability.rb
class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new
    if user.owner?
      return unless user.present?

      can :manage, MenuItem
      can :deactivate, Restaurant, user: user
      can :manage, Restaurant, user_id: user.id
      # can :manage, :all
    elsif user.customer?
      can :create, Review
      can :read, Restaurant
      can :manage, Order
      can :read, MenuItem
      can :manage, CartItem
      can :manage, Cart, user_id: user.id
    elsif user.admin?
      can :manage, :all
    else
      can :read, Restaurant
    end
  end
end
