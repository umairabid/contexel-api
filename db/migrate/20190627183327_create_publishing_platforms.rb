class CreatePublishingPlatforms < ActiveRecord::Migration[5.2]
  def change
    create_table :publishing_platforms do |t|
      t.integer :name, null: false, index: {unique: true}
      t.string :url, null: false
      t.string :username
      t.string :password_digest
      t.string :token
      t.references :manager, {index: true, null: false, foreign_key: true}
      t.timestamps
    end
  end
end
