class ChangeUserRoleToRoles < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :role
    add_column :users, :roles, :integer, array: true, default: []
  end
end
