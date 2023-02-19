# frozen_string_literal: true

class AddIndexToReservations < ActiveRecord::Migration[7.0]
  def change
    add_index :reservations, :code, unique: true
  end
end
