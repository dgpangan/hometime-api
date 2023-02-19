# frozen_string_literal: true

class AddGuestToReservations < ActiveRecord::Migration[7.0]
  def change
    add_reference :reservations, :guest, null: false, foreign_key: true
  end
end
