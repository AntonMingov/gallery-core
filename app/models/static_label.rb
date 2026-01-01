class StaticLabel < ApplicationRecord
  validates :key, presence: true, uniqueness: { scope: :scope } # rubocop:disable Rails/UniqueValidationWithoutIndex
  scope :active, -> { where(is_archived: false) }

  def self.ransackable_attributes(_auth_object = nil)
    %w[archived created_at id key scope updated_at value]
  end
end