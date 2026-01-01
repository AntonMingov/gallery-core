module ImageValidatable
  extend ActiveSupport::Concern

  MAX_IMAGE_SIZE = 10.megabytes
  ALLOWED_CONTENT_TYPES = %w[image/jpeg image/png image/gif image/webp].freeze

  included do
    validate :image_content_type
    validate :image_size
  end

  private

  def image_content_type
    return unless image.attached?
    return if image.content_type.in?(ALLOWED_CONTENT_TYPES)

    errors.add(:image, 'must be a JPEG, PNG, GIF, or WebP image')
  end

  def image_size
    return unless image.attached?
    return if image.byte_size.nil?
    return unless image.byte_size > MAX_IMAGE_SIZE

    errors.add(:image, "must be less than #{MAX_IMAGE_SIZE / 1.megabyte}MB")
  end
end

