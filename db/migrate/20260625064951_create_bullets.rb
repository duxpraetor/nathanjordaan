class CreateBullets < ActiveRecord::Migration[8.1]
  def change
    create_table :bullets do |t|
      t.references :entry, null: false, foreign_key: true
      t.text :description
      t.integer :display_order

      t.timestamps
    end
  end
end
