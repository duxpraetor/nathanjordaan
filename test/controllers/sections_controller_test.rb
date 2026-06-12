require "test_helper"

class SectionsControllerTest < ActionDispatch::IntegrationTest
  test "should redirect new when not authenticated" do
    get new_cv_section_url(cv_id: cvs(:owner_cv).id)
    assert_redirected_to new_session_url
  end

  test "should redirect create when not authenticated" do
    post cv_sections_url(cv_id: cvs(:owner_cv).id), params: { section: { title: "Hobbies", display_order: 4 } }
    assert_redirected_to new_session_url
  end

  test "should redirect edit when not authenticated" do
    get edit_section_url(sections(:work))
    assert_redirected_to new_session_url
  end

  test "should redirect update when not authenticated" do
    patch section_url(sections(:work)), params: { section: { title: "Hacked" } }
    assert_redirected_to new_session_url
  end

  test "should redirect destroy when not authenticated" do
    delete section_url(sections(:work))
    assert_redirected_to new_session_url
  end

  test "should create section for owner" do
    sign_in_as users(:owner)
    assert_difference "Section.count", 1 do
      post cv_sections_url(cv_id: cvs(:owner_cv).id), params: { section: { title: "Publications", display_order: 4 } }
    end
    assert_redirected_to edit_cv_url
    assert_equal "Publications", cvs(:owner_cv).sections.last.title
  end

  test "should redirect non-owner from create section" do
    sign_in_as users(:one)
    assert_no_difference "Section.count" do
      post cv_sections_url, params: { section: { title: "My Section", display_order: 1 } }
    end
    assert_redirected_to cv_index_url
  end

  test "should update own section" do
    sign_in_as users(:owner)
    patch section_url(sections(:work)), params: { section: { title: "Employment" } }
    assert_redirected_to edit_cv_url
    assert_equal "Employment", sections(:work).reload.title
  end

  test "should redirect non-owner from update section" do
    sign_in_as users(:one)
    patch section_url(sections(:work)), params: { section: { title: "Hacked" } }
    assert_redirected_to cv_index_url
    assert_equal "Work experience", sections(:work).reload.title
  end

  test "should destroy own section" do
    sign_in_as users(:owner)
    assert_difference "Section.count", -1 do
      delete section_url(sections(:work))
    end
    assert_redirected_to edit_cv_url
  end

  test "should redirect non-owner from destroy section" do
    sign_in_as users(:one)
    assert_no_difference "Section.count" do
      delete section_url(sections(:work))
    end
    assert_redirected_to cv_index_url
  end
end
