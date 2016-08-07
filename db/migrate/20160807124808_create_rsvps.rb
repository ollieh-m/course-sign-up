class CreateRsvps < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
      t.references :attendee, index: true, foreign_key: true
      t.references :course, index: true, foreign_key: true
      t.string :status

      t.timestamps null: false
    end
    add_index :rsvps, :status
  end
end
