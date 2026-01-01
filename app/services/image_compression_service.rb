require 'tempfile'

class ImageCompressionService
  def self.compress(image_data)
    input_tempfile = nil
    output_tempfile = nil

    begin
      input_tempfile = Tempfile.new(['input', '.jpg'], binmode: true)
      output_tempfile = Tempfile.new(['compressed', '.jpg'], binmode: true)

      input_tempfile.write(image_data)
      input_tempfile.rewind

      config = ImageConfig::COMPRESSION
      ImageProcessing::MiniMagick
        .source(input_tempfile)
        .resize_to_limit(config[:max_dimension], config[:max_dimension])
        .strip
        .quality(config[:quality])
        .convert(config[:format])
        .call(destination: output_tempfile.path)

      output_tempfile.rewind
      output_tempfile
    rescue StandardError => e
      output_tempfile&.close
      output_tempfile&.unlink
      raise e
    ensure
      input_tempfile&.close
      input_tempfile&.unlink
    end
  end
end
