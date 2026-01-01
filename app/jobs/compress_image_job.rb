class CompressImageJob < ApplicationJob
  queue_as :default

  retry_on StandardError, wait: :exponentially_longer, attempts: 3
  discard_on ActiveJob::DeserializationError

  def perform(category_item_id)
    item = CategoryItem.find_by(id: category_item_id)
    return unless valid_item?(item)

    compress_and_attach(item)
  rescue ActiveJob::DeserializationError => e
    Rails.logger.error "Image compression job discarded - record not found: #{category_item_id}"
    raise e
  rescue StandardError => e
    Rails.logger.error "Image compression failed for CategoryItem #{category_item_id}: #{e.message}"
    raise e
  end

  private

  def valid_item?(item)
    item&.image&.attached?
  end

  def compress_and_attach(item)
    file = nil
    begin
      file = ImageCompressionService.compress(item.image.download)
      item.compressed_image.attach(
        io: file,
        filename: "compressed_#{item.image.filename}",
        content_type: 'image/jpeg'
      )
    ensure
      if file
        file.close
        file.unlink
      end
    end
  end
end
