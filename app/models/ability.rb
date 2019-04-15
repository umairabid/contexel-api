# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present? and user.role == 'manager'
      can :manage, Writer
    end
  end
end
