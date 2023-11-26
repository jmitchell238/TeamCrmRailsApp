class ChangeUserRolesFromIntegerToStringArray < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :roles, :string, array: true, default: []
  end
end
