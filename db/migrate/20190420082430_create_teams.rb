class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.text :description, null: true
      t.references :manager, index: true, null: false, foreign_key: true
      t.timestamps
    end
  end
end
