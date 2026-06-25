require "test_helper"

class ContactsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contact = contacts(:one)
  end

  # Public actions
  test "should get new without authentication" do
    get new_contact_url
    assert_response :success
  end

  test "should create contact without authentication" do
    assert_difference("Contact.count") do
      post contacts_url, params: { contact: { company_name: @contact.company_name, email: @contact.email, full_name: @contact.full_name, message: @contact.message, subtitle: "" } }
    end

    assert_redirected_to thank_you_contacts_url
  end

  # Authentication required
  test "should redirect index when not authenticated" do
    get contacts_url
    assert_redirected_to new_session_url
  end

  test "should redirect show when not authenticated" do
    get contact_url(@contact)
    assert_redirected_to new_session_url
  end

  test "should redirect edit when not authenticated" do
    get edit_contact_url(@contact)
    assert_redirected_to new_session_url
  end

  test "should redirect update when not authenticated" do
    patch contact_url(@contact), params: { contact: { full_name: "Hacker" } }
    assert_redirected_to new_session_url
  end

  test "should redirect destroy when not authenticated" do
    assert_no_difference("Contact.count") do
      delete contact_url(@contact)
    end
    assert_redirected_to new_session_url
  end

  # Owner access
  test "should get index for owner" do
    sign_in_as users(:owner)
    get contacts_url
    assert_response :success
  end

  test "should show contact for owner" do
    sign_in_as users(:owner)
    get contact_url(@contact)
    assert_response :success
  end

  test "should get edit for owner" do
    sign_in_as users(:owner)
    get edit_contact_url(@contact)
    assert_response :success
  end

  test "should update contact for owner" do
    sign_in_as users(:owner)
    patch contact_url(@contact), params: { contact: { full_name: "Updated Name" } }
    assert_redirected_to contact_url(@contact)
    assert_equal "Updated Name", @contact.reload.full_name
  end

  test "should destroy contact for owner" do
    sign_in_as users(:owner)
    assert_difference("Contact.count", -1) do
      delete contact_url(@contact)
    end
    assert_redirected_to contacts_url
  end

  # Non-owner access
  test "should redirect index for non-owner" do
    sign_in_as users(:one)
    get contacts_url
    assert_redirected_to root_url
  end

  test "should redirect show for non-owner" do
    sign_in_as users(:one)
    get contact_url(@contact)
    assert_redirected_to root_url
  end
end
