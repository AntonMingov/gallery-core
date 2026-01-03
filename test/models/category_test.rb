require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  test "valid category with name" do
    category = Category.new(name: "Test Category")
    assert category.valid?
  end

  test "has many category_items" do
    category = Category.create!(name: "Test Category")
    item1 = category.category_items.create!(title: "Item 1")
    item2 = category.category_items.create!(title: "Item 2")

    assert_equal 2, category.category_items.count
    assert_includes category.category_items, item1
    assert_includes category.category_items, item2
  end

  test "destroys associated category_items when destroyed" do
    category = Category.create!(name: "Test Category")
    category.category_items.create!(title: "Item 1")
    
    assert_difference "CategoryItem.count", -1 do
      category.destroy
    end
  end

  test "authorised scope returns only authorised categories" do
    authorised = Category.create!(name: "Authorised", is_authorised: true)
    unauthorised = Category.create!(name: "Unauthorised", is_authorised: false)

    authorised_categories = Category.authorised

    assert_includes authorised_categories, authorised
    assert_not_includes authorised_categories, unauthorised
  end

  test "accepts nested attributes for category_items" do
    category = Category.new(
      name: "Test Category",
      category_items_attributes: [
        { title: "Item 1" },
        { title: "Item 2" }
      ]
    )
    
    assert category.valid?
    category.save!
    assert_equal 2, category.category_items.count
  end

  test "has image attachment" do
    category = Category.new(name: "Test Category")
    assert category.respond_to?(:image)
  end
end

