ActiveAdmin.register Friend do
  permit_params :name, :name_en, :description, :description_en, :is_authorised, :image

  index do
    selectable_column
    id_column
    column :description
    column :is_authorised
    actions
  end

  filter :description

  form do |f|
    f.inputs do
      f.input :description
      f.input :is_authorised
      f.input :image, as: :file
    end
    f.actions
  end
end
