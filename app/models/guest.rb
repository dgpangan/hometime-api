# frozen_string_literal: true

class Guest < ApplicationRecord
  has_many :reservations

  validates :first_name,
            :last_name,
            :phone,
            :email, presence: true

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
