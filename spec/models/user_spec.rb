require 'rails_helper'

describe User do

    before :each do
      @user = User.create(first_name: 'Christian', last_name: 'Bale', email: 'batman@example.com')
    end

    it 'requires a first name' do
      @user.update_attributes(first_name: nil)
      expect(@user.errors.any?).to eq(true)
    end

    it 'requires a last name' do
      @user.update_attributes(last_name: nil)
      expect(@user.errors.any?).to eq(true)
    end

    it 'requires a email' do
      @user.update_attributes(email: nil)
      expect(@user.errors.any?).to eq(true)
    end

    it 'vaidates the uniqueness of email' do
      @user2 = User.create(first_name: 'Austin', last_name: 'Adams', email: 'test@example.com')
      expect(@user2.errors.any?).to eq(false)
    end

  end
