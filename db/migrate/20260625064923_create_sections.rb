class CreateSections < ActiveRecord::Migration[8.1]
  def change
    create_table :sections do |t|
      t.references :cv, null: false, foreign_key: true
      t.string :title
      t.integer :display_order

      t.timestamps
    end
  end
end
