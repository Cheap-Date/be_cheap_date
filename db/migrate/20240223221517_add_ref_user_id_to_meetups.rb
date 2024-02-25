class AddRefUserIdToMeetups < ActiveRecord::Migration[7.1]
  def change
    add_reference :meetups, :user, null: false, foreign_key: true
  end
end
