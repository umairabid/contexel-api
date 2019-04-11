class CreateUser < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, null: false, index: { unique: true }
      t.string :name, null: false
      t.string :password, null: false
      t.string :access_token, null: false
      t.integer :role, null: false, length: 2
      t.timestamp
    end
  end
end
