# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      if user.role == 'manager'
        can :manage, Writer
        can :manage, Team
        can :manage, Task
        can :manage, PublishingPlatform
        can :manage, Invoice
      end
      if  user.role == 'writer'
        can :read, Task
        can :read, Writer
        can :read, Invoice
      end
      can :manage, TaskSubmission
      can :manage, TaskComment
      can :manage, TaskPublication
    end


  end
end
