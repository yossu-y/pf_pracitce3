class AddColumnGroups < ActiveRecord::Migration[6.1]
  def change
    add_column :groups, :content, :string
  end
end
