# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :guest

  validates :code,
            :date_start,
            :date_end,
            :number_adults,
            :number_children,
            :number_infants,
            :amount_payout,
            :amount_security,
            :currency,
            :status, presence: true
end
