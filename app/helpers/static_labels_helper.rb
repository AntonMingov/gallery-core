module StaticLabelsHelper
  def static(key, scope = 'common')
    sanitize find_or_create_static(key, scope).value.gsub(/(?:\n\r?|\r\n?)/, '<br>')
  end

  def find_or_create_static(key, scope)
    scope = scope || 'common'
    static_label = StaticLabel.find_by(key:, scope:)

    if static_label.nil? && (Rails.env.development? || Rails.env.test?)
      static_label = StaticLabel.create_with(value: key).find_or_create_by(key:, scope:)
    end

    static_label || StaticLabel.new(key:, scope:, value: key)
  end
end