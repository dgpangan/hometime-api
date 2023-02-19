# frozen_string_literal: true

class ReservationsController < ApplicationController
  LOOKUP_ITEMS = YAML.load_file('lib/lookup.yml').deep_symbolize_keys

  def create
    data = JSON.parse(request.raw_post).smash
    payload = parse_data(data)
    guest = create_guest(payload[:guest_data])
    reservation = create_reservation(guest, payload[:reservation_data])
    render json: { guest:, reservation: }
  end

  private

  def parse_data(data)
    guest_data = {}
    reservation_data = {}

    data.each do |key, value|
      record = LOOKUP_ITEMS[key.to_sym]
      next if record.blank?

      reservation_data[record[:property].to_sym] = value if record[:model] == 'reservation'
      guest_data[record[:property].to_sym] = value if record[:model] == 'guest'
    end

    { reservation_data:, guest_data: }
  end

  def create_guest(guest_data)
    Guest.find_or_create_by(email: guest_data[:email]) do |g|
      guest_data.each do |key, value|
        g[key] = value
      end
    end
  end

  def create_reservation(guest, reservation_data)
    guest.reservations.find_or_create_by(code: reservation_data[:code]) do |r|
      reservation_data.each do |key, value|
        r[key] = value
      end
    end
  end
end
