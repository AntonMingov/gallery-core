require "test_helper"

class ContactTest < ActiveSupport::TestCase
  test "valid contact with all required fields" do
    contact = Contact.new(
      first_name: "John",
      email: "john@example.com",
      message: "Test message"
    )
    assert contact.valid?
  end

  test "requires first_name" do
    contact = Contact.new(
      email: "john@example.com",
      message: "Test message"
    )
    assert_not contact.valid?
    assert_includes contact.errors[:first_name], "can't be blank"
  end

  test "requires email" do
    contact = Contact.new(
      first_name: "John",
      message: "Test message"
    )
    assert_not contact.valid?
    assert_includes contact.errors[:email], "can't be blank"
  end

  test "requires message" do
    contact = Contact.new(
      first_name: "John",
      email: "john@example.com"
    )
    assert_not contact.valid?
    assert_includes contact.errors[:message], "can't be blank"
  end

  test "validates email format" do
    contact = Contact.new(
      first_name: "John",
      email: "invalid-email",
      message: "Test message"
    )
    assert_not contact.valid?
    assert_includes contact.errors[:email], "is invalid"
  end

  test "accepts valid email formats" do
    valid_emails = ["user@example.com", "test.user@domain.co.uk", "user+tag@example.org"]
    
    valid_emails.each do |email|
      contact = Contact.new(
        first_name: "John",
        email: email,
        message: "Test message"
      )
      assert contact.valid?, "#{email} should be valid"
    end
  end

  test "last_name is optional" do
    contact = Contact.new(
      first_name: "John",
      email: "john@example.com",
      message: "Test message"
    )
    assert contact.valid?
  end
end
