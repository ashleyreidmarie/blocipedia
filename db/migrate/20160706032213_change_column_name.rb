class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :muds, :verified, :approved
  end
end
