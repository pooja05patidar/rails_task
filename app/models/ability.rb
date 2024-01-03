# class Ability
#   include CanCan::Ability
#   def initialize(user)
#     user ||= User.new
#     if user.owner?
#       can :manage, Restaurant
#     elsif user.customer?
#       can :read, Restaurant
#     elsif user.admin?
#       can :manage, :all
#     else
#       can :read, :all
#     end
#   end
# end
