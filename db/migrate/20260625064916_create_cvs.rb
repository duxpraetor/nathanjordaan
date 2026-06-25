class CreateCvs < ActiveRecord::Migration[8.1]
  def change
    create_table :cvs do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :email
      t.text :summary
      t.string :github_url
      t.string :website_url

      t.timestamps
    end
  end
end
