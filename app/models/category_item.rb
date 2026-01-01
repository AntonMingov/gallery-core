class CategoryItem < ApplicationRecord
  has_one_attached :image
  has_one_attached :compressed_image

  # Variant for grid thumbnails (WebP ~1200px, q=85)
  def variant_webp_grid
    return image unless image.attached?

    config = ImageConfig::GRID_VARIANT
    image.variant(
      resize_to_limit: [config[:max_dimension], config[:max_dimension]],
      saver: { quality: config[:quality] },
      format: config[:format].to_sym
    )
  end

  after_commit :enqueue_compression_if_needed, on: [:create, :update]

  private

  def enqueue_compression_if_needed
    return unless image.attached?

    return unless previous_changes.key?("image_attachment") || !compressed_image.attached?

    CompressImageJob.perform_later(id)
  end
end
