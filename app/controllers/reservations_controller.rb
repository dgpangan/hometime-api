# frozen_string_literal: true

class ReservationsController < ApplicationController
  LOOKUP_ITEMS = YAML.load_file('lib/lookup.yml').deep_symbolize_keys

  def create
    data = parse_data(JSON.parse(request.raw_post).smash)
    Guest.upsert(data[:guest])
    guest = Guest.find_by(email: data[:guest][:email])
    data[:reservation][:guest_id] = guest.id
    Reservation.upsert(data[:reservation])
    reservation = Reservation.find_by(code: data[:reservation][:code])
    render json: { guest:, reservation: }
  end

  private

  def parse_data(data)
    guest = {}
    reservation = {}

    data.each do |key, value|
      record = LOOKUP_ITEMS[key.to_sym]
      next if record.blank?

      reservation[record[:property].to_sym] = value if record[:model] == 'reservation'
      guest[record[:property].to_sym] = value if record[:model] == 'guest'
    end

    reservation[:guest_id] = guest[:id]
    { reservation:, guest: }
  end
end
