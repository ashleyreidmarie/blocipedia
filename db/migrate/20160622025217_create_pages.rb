class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.text :body
      t.references :wiki, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
