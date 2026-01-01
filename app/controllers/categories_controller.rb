# frozen_string_literal: true

class CategoriesController < ApplicationController
  ITEMS_PER_PAGE = 24

  before_action :set_category, only: [:sub_category]

  def sub_category
    @per_page = ITEMS_PER_PAGE
    @page = params[:page].to_i
    @page = 1 if @page <= 0

    @category_items = fetch_category_items(@category, @page, @per_page)
    @has_more = category_items_count(@category) > (@page * @per_page)

    if params[:partial].to_s == '1'
      response.set_header('X-Has-More', @has_more.to_s)
      render partial: 'categories/category_items', locals: { items: @category_items }
      return
    end
  end

  private

  def set_category
    @category = Category.includes(category_items: [image_attachment: :blob])
                        .find(params[:id])
  end

  def fetch_category_items(category, page, per_page)
    return [] unless category

    category
      .category_items
      .with_attached_image
      .order(:id)
      .offset((page - 1) * per_page)
      .limit(per_page)
      .to_a
  end

  def category_items_count(category)
    return 0 unless category

    category.category_items.count
  end
end
