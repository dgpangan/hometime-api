# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'associations' do
    it { should belong_to(:guest) }
  end

  describe 'validations' do
    it { should validate_presence_of(:code) }
    it { should validate_presence_of(:date_start) }
    it { should validate_presence_of(:date_end) }
    it { should validate_presence_of(:number_adults) }
    it { should validate_presence_of(:number_children) }
    it { should validate_presence_of(:number_infants) }
    it { should validate_presence_of(:amount_payout) }
    it { should validate_presence_of(:amount_security) }
    it { should validate_presence_of(:currency) }
    it { should validate_presence_of(:status) }
  end
end
