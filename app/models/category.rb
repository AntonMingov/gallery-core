class Category < ApplicationRecord
  include ImageValidatable

  has_one_attached :image, dependent: :destroy
  has_many :category_items, dependent: :destroy

  accepts_nested_attributes_for :category_items, allow_destroy: true

  scope :authorised, -> { where(is_authorised: true) }

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at name updated_at image is_authorised title]
  end
end
