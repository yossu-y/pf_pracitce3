class CreateGroupUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :group_users do |t|
      
      t.integer :owner_id, null: false
      t.string :name, null: false
      t.text :introduction, null: false

      t.timestamps
    end
  end
end
