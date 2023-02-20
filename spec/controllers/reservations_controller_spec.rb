# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReservationsController, type: :controller do
  describe 'POST #create' do
    context 'with valid params' do
      context 'using payload 1' do
        let(:guest_attributes) do
          {
            first_name: "Wayne",
            last_name: "Woodbridge",
            phone: "639123456789",
            email: "wayne_woodbridge@bnb.com"
          }
        end
  
        let(:reservation_attributes) do
          {
            code: "YYY12345678",
            date_start: "2021-04-14".to_date,
            date_end: "2021-04-18".to_date,
            number_adults: 2,
            number_children: 2,
            number_infants: 0,
            amount_payout: 4200.0,
            amount_security: 500.0,
            currency: "AUD",
            status: "accepted"
          }
        end

        before do
          post :create, body: file_fixture("payload-1.json").read
        end

        subject { response }

        it { should have_http_status :ok }

        it 'creates the guest', skip_before: true do
          guest = Guest.last
          expect(guest.first_name).to eq(guest_attributes[:first_name])
          expect(guest.last_name).to eq(guest_attributes[:last_name])
          expect(guest.phone).to eq(guest_attributes[:phone])
          expect(guest.email).to eq(guest_attributes[:email])
        end

        it 'creates the reservation' do
          reservation = Reservation.last
          expect(reservation.code).to eq(reservation_attributes[:code])
          expect(reservation.date_start).to eq(reservation_attributes[:date_start])
          expect(reservation.date_end).to eq(reservation_attributes[:date_end])
          expect(reservation.number_adults).to eq(reservation_attributes[:number_adults])
          expect(reservation.number_children).to eq(reservation_attributes[:number_children])
          expect(reservation.number_infants).to eq(reservation_attributes[:number_infants])
          expect(reservation.amount_payout).to eq(reservation_attributes[:amount_payout])
          expect(reservation.currency).to eq(reservation_attributes[:currency])
          expect(reservation.status).to eq(reservation_attributes[:status])
        end
      end

      context 'using payload 2' do
        let(:guest_attributes) do
          {
            first_name: "Wayne",
            last_name: "Woodbridge",
            phone: "---\n- '639123456789'\n- '639123456789'\n",
            email: "wayne_woodbridge@bnb.com"
          }
        end
  
        let(:reservation_attributes) do
          {
            code: "XXX12345678",
            date_start: "2021-03-12".to_date,
            date_end: "2021-03-16".to_date,
            number_adults: 2,
            number_children: 2,
            number_infants: 0,
            amount_payout: 3800.0,
            amount_security: 500.0,
            currency: "AUD",
            status: "accepted"
          }
        end

        before do
          post :create, body: file_fixture("payload-2.json").read
        end

        subject { response }

        it { should have_http_status :ok }

        it 'creates the guest' do
          guest = Guest.last
          expect(guest.first_name).to eq(guest_attributes[:first_name])
          expect(guest.last_name).to eq(guest_attributes[:last_name])
          expect(guest.phone).to eq(guest_attributes[:phone])
          expect(guest.email).to eq(guest_attributes[:email])
        end

        it 'creates the reservation' do
          reservation = Reservation.last
          expect(reservation.code).to eq(reservation_attributes[:code])
          expect(reservation.date_start).to eq(reservation_attributes[:date_start])
          expect(reservation.date_end).to eq(reservation_attributes[:date_end])
          expect(reservation.number_adults).to eq(reservation_attributes[:number_adults])
          expect(reservation.number_children).to eq(reservation_attributes[:number_children])
          expect(reservation.number_infants).to eq(reservation_attributes[:number_infants])
          expect(reservation.amount_payout).to eq(reservation_attributes[:amount_payout])
          expect(reservation.currency).to eq(reservation_attributes[:currency])
          expect(reservation.status).to eq(reservation_attributes[:status])
        end
      end
    end

    context 'with invalid guest params' do

    end

    context 'with invalid reservation params' do

    end
  end
end