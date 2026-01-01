
# rubocop:disable all
namespace :images do
  desc "Compress images for existing records"
  task compress: :environment do
    batch_size = 10
    CategoryItem.find_in_batches(batch_size: batch_size) do |batch|
      batch.each do |sub_category|
        if sub_category.image.attached?
          compressed_image_tempfile = nil
          begin
            compressed_image_tempfile = ImageCompressionService.compress(sub_category.image.download)
            sub_category.compressed_image.attach(
              io: compressed_image_tempfile,
              filename: "compressed_#{sub_category.image.filename.to_s}",
              content_type: 'image/jpeg'
            )
            sub_category.save!
            puts "Compressed image for SubCategory ID: #{sub_category.id}"
          rescue StandardError => e
            puts "Failed to compress image for SubCategory ID: #{sub_category.id} - #{e.message}"
          ensure
            compressed_image_tempfile&.close
            compressed_image_tempfile&.unlink
          end
        end
      end
    end
  end

  desc "delete images for existing records"
  task delete_non_compressed_image: :environment do
    batch_size = 10
    CategoryItem.find_in_batches(batch_size: batch_size) do |batch|
      batch.each do |sub_category|
        sub_category.image.destroy if sub_category.image.present?
        puts "Image delete for category item #{sub_category.id}" if sub_category.image.present?
      end
    end
  end
end
# rubocop:enable all
