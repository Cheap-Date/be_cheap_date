class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :location
      t.string :description
      t.string :time_start
      t.string :time_end
      t.boolean :is_free
      t.string :category
      t.float :cost
      t.float :cost_max
      t.string :event_site_url

      t.timestamps
    end
  end
end
