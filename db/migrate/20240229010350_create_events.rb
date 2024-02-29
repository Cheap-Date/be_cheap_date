class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.text :location
      t.text :description
      t.string :category
      t.decimal :cost
      t.decimal :cost_max
      t.boolean :is_free
      t.string :url
      t.references :meetup, null: false, foreign_key: true

      t.timestamps
    end
  end
end
