class Friend < ApplicationRecord
  include ImageValidatable

  has_one_attached :image, dependent: :destroy

  scope :authorised, -> { where(is_authorised: true) }

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at description updated_at image is_authorised]
  end
end
