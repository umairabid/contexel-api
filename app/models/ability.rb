# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present? and user.role == 'manager'
      can :manage, Writer
      can :manage, Team
      can :manage, Task
    end

    if user.present? and user.role == 'writer'
      can :read, Task
      can :read, Writer
    end
  end
end
