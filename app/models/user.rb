class User < ApplicationRecord
  has_secure_password
  has_many :templates, dependent: :destroy
  has_many :generated_projects, dependent: :destroy
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, if: -> { password_digest.nil? || password.present? }
end
