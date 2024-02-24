class CreateMeetups < ActiveRecord::Migration[7.1]
  def change
    create_table :meetups do |t|
      t.string :title
      t.string :location
      t.string :start_time
      t.string :end_time
      t.boolean :first_date

      t.timestamps
    end
  end
end
