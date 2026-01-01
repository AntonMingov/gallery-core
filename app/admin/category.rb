ActiveAdmin.register Category do # rubocop:disable Metrics/BlockLength
  permit_params :name, :name_en, :description, :description_en, :is_authorised, :image,
                category_items_attributes: [:id, :title, :title_en, :image, :_destroy]

  index do
    selectable_column
    id_column
    column :name
    column :is_authorised
    actions
  end

  filter :name

  show do
    attributes_table do
      row :name
      row :name_en
      row :is_authorised
      row :image do |category|
        if category.image.present?
          image_tag category.image, size: horizontal_or_vertical_img(category.image) ? '400x500' : '500x300'
        end
      end
      row :description
      row :description_en
      row :created_at
      row :updated_at
    end

    panel "Category Items" do
      table_for category.category_items do
        column "Заглавие (BG)", :title
        column "Заглавие (EN)", :title_en
        column :image do |item|
          if item.image.present?
            image_tag item.image, size: horizontal_or_vertical_img(item.image) ? '400x500' : '500x300'
          end
        end
      end
    end

    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :name, label: "Име (BG)"
      f.input :name_en, label: "Име (EN)"
      f.input :description, label: "Описание (BG)"
      f.input :description_en, label: "Описание (EN)"

      if f.object.image.present?
        f.input :image, as: :file, hint: image_tag(f.object.image, size: horizontal_or_vertical_img(f.object.image) ? '400x500' : '500x300')
      else
        f.input :image, as: :file
      end

      f.input :is_authorised
    end

    f.has_many :category_items, new_record: 'Add Category Item', remove_record: 'Remove Category Item', allow_destroy: true do |a|
      a.input :title, label: "Заглавие (BG)"
      a.input :title_en, label: "Заглавие (EN)"

      image = a.object.compressed_image.attached? ? a.object.compressed_image : a.object.image

      if image.attached?
        image_url = Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true)

        a.input :image, as: :file, hint: image_tag(image_url, style: 'max-width: 200px; display: block;') +
                                         content_tag(:div, image.filename.to_s, style: 'font-size: 12px; color: #888; margin-top: 5px;')
      else
        a.input :image, as: :file
      end
    end
    f.actions
  end
end
