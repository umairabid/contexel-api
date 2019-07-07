class Team < ApplicationRecord
  belongs_to :manager

  def writers
    []
  end
end

