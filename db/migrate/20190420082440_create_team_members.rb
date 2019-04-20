class CreateTeamMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :team_members do |t|
      t.references :team, index: true, null: false, foreign_key: true
      t.references :writer, index: true, null: false, foreign_key: true
      t.timestamps
    end
  end
end
