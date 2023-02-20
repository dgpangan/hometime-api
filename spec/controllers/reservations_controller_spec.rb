# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReservationsController, type: :controller do
  describe 'POST #create' do
    context 'with valid params' do
      context 'using payload 1' do
        let(:guest_attributes) do
          {
            first_name: 'Wayne',
            last_name: 'Woodbridge',
            phone: '639123456789',
            email: 'wayne_woodbridge@bnb.com'
          }
        end

        let(:reservation_attributes) do
          {
            code: 'YYY12345678',
            date_start: '2021-04-14'.to_date,
            date_end: '2021-04-18'.to_date,
            number_adults: 2,
            number_children: 2,
            number_infants: 0,
            amount_payout: 4200.0,
            amount_security: 500.0,
            currency: 'AUD',
            status: 'accepted'
          }
        end

        before do
          post :create, body: file_fixture('payload-1.json').read
        end

        specify { expect(response).to have_http_status(:ok) }
        specify { expect(JSON.parse(response.body)['success']).to be_truthy }

        it 'creates the guest' do
          guest = Guest.last

          guest_attributes.each do |key, value|
            expect(guest[key]).to eq(value)
          end
        end

        it 'creates the reservation' do
          reservation = Reservation.last

          reservation_attributes.each do |key, value|
            expect(reservation[key]).to eq(value)
          end
        end
      end

      context 'using payload 2' do
        let(:guest_attributes) do
          {
            first_name: 'Wayne',
            last_name: 'Woodbridge',
            phone: "---\n- '639123456789'\n- '639123456789'\n",
            email: 'wayne_woodbridge@bnb.com'
          }
        end

        let(:reservation_attributes) do
          {
            code: 'XXX12345678',
            date_start: '2021-03-12'.to_date,
            date_end: '2021-03-16'.to_date,
            number_adults: 2,
            number_children: 2,
            number_infants: 0,
            amount_payout: 3800.0,
            amount_security: 500.0,
            currency: 'AUD',
            status: 'accepted'
          }
        end

        before do
          post :create, body: file_fixture('payload-2.json').read
        end

        specify { expect(response).to have_http_status(:ok) }
        specify { expect(JSON.parse(response.body)['success']).to be_truthy }

        it 'creates the guest' do
          guest = Guest.last

          guest_attributes.each do |key, value|
            expect(guest[key]).to eq(value)
          end
        end

        it 'creates the reservation' do
          reservation = Reservation.last

          reservation_attributes.each do |key, value|
            expect(reservation[key]).to eq(value)
          end
        end
      end
    end

    context 'with invalid guest params' do
      before do
        post :create, body: file_fixture('invalid-guest-data.json').read
      end

      specify { expect(response).to have_http_status(:ok) }
      specify { expect(JSON.parse(response.body)['success']).to be_falsey }
    end

    context 'with invalid reservation params' do
      before do
        post :create, body: file_fixture('invalid-reservation-data.json').read
      end

      specify { expect(response).to have_http_status(:ok) }
      specify { expect(JSON.parse(response.body)['success']).to be_falsey }
    end
  end
end
