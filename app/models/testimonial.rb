class Testimonial < ApplicationRecord
  include ImageValidatable

  has_one_attached :image, dependent: :destroy

  validates :title, :description, presence: true

  scope :authorised, -> { where(is_authorised: true) }

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at description id id_value is_authorised title updated_at image]
  end
end
