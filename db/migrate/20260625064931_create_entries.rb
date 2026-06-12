class CreateEntries < ActiveRecord::Migration[8.1]
  def change
    create_table :entries do |t|
      t.references :section, null: false, foreign_key: true
      t.string :title
      t.string :subtitle
      t.string :date_text
      t.date :start_date
      t.date :end_date
      t.string :meta
      t.text :blurb
      t.integer :display_order

      t.timestamps
    end
  end
end
