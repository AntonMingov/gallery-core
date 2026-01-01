ActiveAdmin.register MetaImage do
  permit_params :image

  index do
    id_column
    column :image
  end

  filter :name

  show do
    attributes_table do
      row :image do |category|
        image_tag category.image, size: horizontal_or_vertical_img(category.image) ? '400x500' : '500x300' if category.image.present?
      end
    end
    active_admin_comments
  end

  form do |f|
    if f.object.image.present?
      f.input :image, as: :file, hint: image_tag(f.object.image, size: horizontal_or_vertical_img(f.object.image) ? '400x500' : '500x300')
    else
      f.input :image, as: :file
    end

    f.actions
  end
end
