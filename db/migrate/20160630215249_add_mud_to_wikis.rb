class AddMudToWikis < ActiveRecord::Migration
  def change
    add_column :wikis, :mud_id, :integer
    add_index :wikis, :mud_id
  end
end
