# frozen_string_literal: true

class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.string :code
      t.date :date_start
      t.date :date_end
      t.integer :number_adults
      t.integer :number_children
      t.integer :number_infants
      t.float :amount_payout
      t.float :amount_security
      t.string :currency
      t.string :status

      t.timestamps
    end
  end
end
