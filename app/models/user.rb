# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_secure_token

  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }
end
