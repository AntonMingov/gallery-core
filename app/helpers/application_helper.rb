module ApplicationHelper
  def horizontal_or_vertical_img(image)
    return false unless image.attached?

    begin
      image.open do |file|
        img = MiniMagick::Image.open(file.path)
        img.height > img.width
      end
    rescue StandardError => e
      Rails.logger.error "Error checking image orientation: #{e.message}"
      false
    end
  end

  def landscape_image(image)
    return false unless image.attached?

    width, height = get_image_dimensions(image)
    width > height
  end

  def get_image_dimensions(image)
    return [0, 0] unless image.attached?

    @image_dimensions_cache ||= {}
    cache_key = "#{image.blob_id}_#{image.blob.updated_at.to_i}"

    @image_dimensions_cache[cache_key] ||= begin
      image.open do |file|
        img = MiniMagick::Image.open(file.path)
        [img.width, img.height]
      end
    end
  end

  def get_image_width(image)
    get_image_dimensions(image).first
  end

  def get_image_height(image)
    get_image_dimensions(image).last
  end

  def meta_title_for(title, site)
    return site if title.blank?

    title.include?(site) ? title : "#{title} — #{site}"
  end

  def resolve_og_meta_image
    meta_image = MetaImage.first

    if meta_image.present? && meta_image.image.attached?
      rails_blob_url(meta_image.image)
    else
      'N/A'
    end
  end
end
