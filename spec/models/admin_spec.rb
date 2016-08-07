require 'rails_helper'

describe Admin do

  let(:admin){ described_class.new }

  context '#validate_then_save' do
    it 'returns false if the email is not a valid email' do
      result = admin.validate_then_save(email: 'test@email', password: 'password', password_confirmation: 'password')
      expect(result).to be_falsey
      expect(admin.custom_errors).to include('You must use a valid email address')
    end
    it 'returns false if the email address is already taken' do
      Admin.create(email: 'test@email.com', password_hash: 'dummyhash')
      result = admin.validate_then_save(email: 'test@email.com', password: 'password', password_confirmation: 'password')
      expect(result).to be_falsey
      expect(admin.custom_errors).to include('The email address is already taken')
    end
    it 'returns false if the password does not match the password confirmation' do
      result = admin.validate_then_save(email: 'test@email.com', password: 'password', password_confirmation: 'wrongpassword')
      expect(result).to be_falsey
      expect(admin.custom_errors).to include('The password confirmation does not match the password')
    end
    it 'returns false if the password is empty' do
      result = admin.validate_then_save(email: 'test@email.com', password: '', password_confirmation: '')
      expect(result).to be_falsey
      expect(admin.custom_errors).to include('You must choose a password')
    end
    it 'hashes the password if the email and password are valid' do
      expect(BCrypt::Password).to receive(:create).with('testpassword')
      admin.validate_then_save(email: 'test@email.com', password: 'testpassword', password_confirmation: 'testpassword')
    end
    it 'saves the admin with their hashed password if the email and password are valid' do
      allow(BCrypt::Password).to receive(:create).with('testpassword').and_return('hashedpassword')
      admin.validate_then_save(email: 'test@email.com', password: 'testpassword', password_confirmation: 'testpassword')
      expect(Admin.all.count).to eq 1
      expect(Admin.last.password_hash).to eq 'hashedpassword'
    end
  end
  
end