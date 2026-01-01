class MetaImage < ApplicationRecord
  include ImageValidatable

  has_one_attached :image, dependent: :destroy
end
