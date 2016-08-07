class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.string :email
      t.date :date_of_birth

      t.timestamps null: false
    end
    add_index :attendees, [:email, :date_of_birth]
  end
end
