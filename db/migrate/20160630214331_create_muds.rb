class CreateMuds < ActiveRecord::Migration
  def change
    create_table :muds do |t|
      t.string :name
      t.string :url
      t.boolean :verified, default: false

      t.timestamps null: false
    end
    add_index :muds, :name
  end
end
