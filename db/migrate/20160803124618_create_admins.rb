class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :email
      t.string :password_hash

      t.timestamps null: false
    end
    add_index :admins, :email
  end
end
