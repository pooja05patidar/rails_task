# frozen_string_literal: true

# ability.rb
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    assign_owner_permissions(user) if user.owner?
    assign_customer_permissions(user) if user.customer?
    assign_admin_permissions(user) if user.admin?
    assign_default_permissions
  end

  private

  def assign_owner_permissions(user)
    return unless user.present?

    can :manage, MenuItem
    can :create, Review
    can :deactivate, Restaurant, user: user
    can :manage, Restaurant, user_id: user.id
  end

  def assign_customer_permissions(user)
    return unless user.present?

    can %i[read create], Review
    can %i[read manage], Order, user_id: user.id
    can :show, Order
    can :home, Restaurant
    can %i[read manage], MenuItem
    can [:manage], CartItem
    can [:manage], Cart, user_id: user.id
  end

  def assign_admin_permissions
    can :manage, :all
  end

  def assign_default_permissions
    can :read, Restaurant
  end
end
