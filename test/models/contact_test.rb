require "test_helper"

class ContactTest < ActiveSupport::TestCase
  test "invalid without email" do
    contact = Contact.new(full_name: "Ada", email: "", message: "Hello world")
    assert_not contact.valid?
    assert_includes contact.errors[:email], "can't be blank"
  end

  test "invalid with malformed email" do
    contact = Contact.new(full_name: "Ada", email: "not-an-email", message: "Hello world")
    assert_not contact.valid?
  end

  test "valid with good email" do
    contact = Contact.new(full_name: "Ada", email: "ada@example.com", message: "Hello world")
    assert contact.valid?
  end

  test "email normalised to stripped downcase" do
    contact = Contact.new(full_name: "Ada", email: " ADA@EXAMPLE.COM ", message: "Hello world")
    assert contact.valid?
    assert "ada@example.com" == contact.email
  end

  test "invalid without full name" do
    contact = Contact.new(full_name: "", email: "ada@example.com", message: "Hello world")
    assert_not contact.valid?
  end

  test "invalid without message" do
    contact = Contact.new(full_name: "Ada", email: "ada@example.com", message: "")
    assert_not contact.valid?
  end
end
