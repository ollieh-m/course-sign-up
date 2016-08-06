class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.text :description
      t.date :start
      t.date :end

      t.timestamps null: false
    end
    add_index :courses, :name
    add_index :courses, :start
    add_index :courses, :end
  end
end
