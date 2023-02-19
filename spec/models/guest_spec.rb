# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Guest, type: :model do
  describe 'associations' do
    it { should have_many(:reservations) }
  end

  describe 'validations' do
    it 'is valid with attributes' do
      expect(Guest.new(first_name: Faker::Name.first_name,
                       last_name: Faker::Name.last_name,
                       phone: Faker::PhoneNumber.phone_number)).to be_valid
    end

    it 'is not valid without a first name' do
      expect(Guest.new(first_name: nil)).not_to be_valid
    end

    it 'is not valid without a last name' do
    end

    it 'is not valid without a phone' do
    end

    it 'is not valid without an email' do
    end

    it 'is invalid if email is invalid' do
    end
  end
end
