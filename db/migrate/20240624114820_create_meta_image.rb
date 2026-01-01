class CreateMetaImage < ActiveRecord::Migration[7.1]
  def change
    create_table :meta_images, &:timestamps
  end
end
