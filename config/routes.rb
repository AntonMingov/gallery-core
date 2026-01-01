Rails.application.routes.draw do
  get '/', to: redirect('/bg')

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  mount ActiveStorageDB::Engine => '/active_storage_db'
  
  direct :rails_service_blob do |blob|
    route_for(:active_storage_db_file, blob.key)
  end

  scope "(:locale)", locale: /en|bg/ do
    resources :friends
    resources :contacts, only: [:create]

    root "home#index"
    get '/categories/:id', to: 'categories#sub_category', as: 'sub_category'
  end

  get '/en/index.html', to: redirect('/')
  get '/portrait.html', to: redirect('/categories/68')
  get '/en/:slug.html', to: redirect { |params, _req|
    case params[:slug]
    when 'portraits' then '/categories/68'
    else '/'
    end
  }
end
