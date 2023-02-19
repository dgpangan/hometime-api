# frozen_string_literal: true

class ReservationsController < ApplicationController
  LOOKUP_ITEMS = YAML.load_file('lib/lookup.yml').deep_symbolize_keys

  def create
    data = parse_data(JSON.parse(request.raw_post).smash)

    guest = create_or_update_guest(data[:guest])

    unless guest.valid?
      render json: { success: false, errors: guest.errors }
      return
    end

    reservation = create_or_update_reservation(data[:reservation], guest.id)

    unless reservation.valid?
      render json: { success: false, errors: reservation.errors }
      return
    end

    render json: { success: true, guest:, reservation: }
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

  def create_or_update_guest(data)
    Guest.upsert(data)
    Guest.find_by(email: data[:email])
  end

  def create_or_update_reservation(data, guest_id)
    data[:guest_id] = guest_id
    Reservation.upsert(data)
    Reservation.find_by(code: data[:code])
  end
end
