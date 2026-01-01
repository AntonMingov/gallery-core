class Contact < ApplicationRecord
  validates :first_name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :message, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at email first_name id id_value last_name message updated_at]
  end
end
