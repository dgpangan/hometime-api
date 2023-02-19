# frozen_string_literal: true

class ReservationsController < ApplicationController
  def create
    keys = {
      reservation_code: { model: 'reservation', property: 'code' },
      start_date: { model: 'reservation', property: 'date_start' },
      end_date: { model: 'reservation', property: 'date_end' },
      adults: { model: 'reservation', property: 'number_adults' },
      children: { model: 'reservation', property: 'number_children' },
      infants: { model: 'reservation', property: 'number_infants' },
      status: { model: 'reservation', property: 'status' },
      first_name: { model: 'guest', property: 'first_name' },
      last_name: { model: 'guest', property: 'last_name' },
      phone: { model: 'guest', property: 'phone' },
      email: { model: 'guest', property: 'email' },
      currency: { model: 'reservation', property: 'currency' },
      payout_price: { model: 'reservation', property: 'amount_payout' },
      security_price: { model: 'reservation', property: 'amount_security' },
      code: { model: 'reservation', property: 'code' },
      expected_payout_amount: { model: 'reservation', property: 'amount_payout' },
      number_of_adults: { model: 'reservation', property: 'number_adults' },
      number_of_children: { model: 'reservation', property: 'number_children' },
      number_of_infants: { model: 'reservation', property: 'number_infants' },
      guest_email: { model: 'guest', property: 'email' },
      guest_first_name: { model: 'guest', property: 'first_name' },
      guest_last_name: { model: 'guest', property: 'last_name' },
      guest_phone_numbers: { model: 'guest', property: 'phone' },
      listing_security_price_accurate: { model: 'reservation', property: 'amount_security' },
      host_currency: { model: 'reservation', property: 'currency'        },
      status_type: { model: 'reservation', property: 'status' }
    }

    data = JSON.parse(request.raw_post).smash
    guest = Hash.new
    reservation = Hash.new

    data.each do |key, value|
      record = keys[key.to_sym]
      next if record.blank?

      reservation[record[:property]] = value if record[:model] == 'reservation'
      guest[record[:property]] = value if record[:model] == 'guest'
    end

    render json: { reservation:, guest: }
  end
end
