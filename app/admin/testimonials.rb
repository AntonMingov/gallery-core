ActiveAdmin.register Testimonial do
  permit_params :title, :title_en, :description, :description_en, :image, :is_authorised

  form do |f|
    f.inputs "Testimonial Details" do
      f.input :title, label: "Заглавие (BG)"
      f.input :title_en, label: "Заглавие (EN)"
      f.input :description, as: :text, label: "Описание (BG)"
      f.input :description_en, as: :text, label: "Описание (EN)"
      f.input :image, as: :file
      f.input :is_authorised
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :title
    column :title_en
    column :description
    column :description_en
    column :image
    column :is_authorised
    column :created_at
    actions
  end

  filter :title
  filter :is_authorised
  filter :created_at
end
