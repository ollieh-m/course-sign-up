class AddConfirmationTokenHashToRsvp < ActiveRecord::Migration
  def change
    add_column :rsvps, :confirmation_token_hash, :string
  end
end
