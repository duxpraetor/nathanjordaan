require "test_helper"

class CvsControllerTest < ActionDispatch::IntegrationTest
  # Public pages
  test "should get index without authentication" do
    get cv_index_url
    assert_response :success
    assert_select "h1", "Nathan Jordaan"
  end

  test "should get pdf without authentication" do
    get cv_pdf_url
    assert_response :success
    assert_equal "application/pdf", response.content_type
  end

  # Authentication required
  test "should redirect edit when not authenticated" do
    get edit_cv_url
    assert_redirected_to new_session_url
  end

  test "should redirect update when not authenticated" do
    patch cv_url, params: { cv: { name: "Hacker" } }
    assert_redirected_to new_session_url
  end

  # Authenticated owner
  test "should get edit for owner" do
    sign_in_as users(:owner)
    get edit_cv_url
    assert_response :success
    assert_select "h1", "Edit your CV"
  end

  test "should update cv for owner" do
    sign_in_as users(:owner)
    patch cv_url, params: { cv: { name: "Updated Name", summary: "Updated summary." } }
    assert_redirected_to edit_cv_url
    assert_equal "Updated Name", users(:owner).cv.reload.name
  end

  # Other authenticated users
  test "should create cv for new user on edit" do
    sign_in_as users(:two)
    assert_nil users(:two).cv
    get edit_cv_url
    assert_response :success
    assert users(:two).reload.cv.present?
  end

  test "should update own cv only" do
    sign_in_as users(:one)
    patch cv_url, params: { cv: { name: "Hacker" } }
    assert_redirected_to edit_cv_url
    assert_equal "Hacker", users(:one).cv.reload.name
    assert_equal "Nathan Jordaan", users(:owner).cv.reload.name
  end
end
