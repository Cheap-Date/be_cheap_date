class CreateDates < ActiveRecord::Migration[7.1]
  def change
    create_table :dates do |t|
      t.string :title
      t.integer :location_zip
      t.string :start_time
      t.string :end_time
      t.boolean :first_date

      t.timestamps
    end
  end
end
