require "test_helper"

class EntriesControllerTest < ActionDispatch::IntegrationTest
  test "should redirect new when not authenticated" do
    get new_section_entry_url(section_id: sections(:work).id)
    assert_redirected_to new_session_url
  end

  test "should redirect create when not authenticated" do
    post section_entries_url(section_id: sections(:work).id), params: { entry: { title: "Hacked" } }
    assert_redirected_to new_session_url
  end

  test "should redirect edit when not authenticated" do
    get edit_entry_url(entries(:shipshape))
    assert_redirected_to new_session_url
  end

  test "should redirect update when not authenticated" do
    patch entry_url(entries(:shipshape)), params: { entry: { title: "Hacked" } }
    assert_redirected_to new_session_url
  end

  test "should redirect destroy when not authenticated" do
    delete entry_url(entries(:shipshape))
    assert_redirected_to new_session_url
  end

  test "should create entry for own section" do
    sign_in_as users(:owner)
    assert_difference "Entry.count", 1 do
      post section_entries_url(section_id: sections(:work).id), params: { entry: { title: "New Job", date_text: "2025", display_order: 3 } }
    end
    assert_redirected_to edit_cv_url
    assert_equal "New Job", sections(:work).entries.last.title
  end

  test "should redirect non-owner from create entry" do
    sign_in_as users(:one)
    assert_no_difference "Entry.count" do
      post section_entries_url(section_id: sections(:work).id), params: { entry: { title: "Hacked" } }
    end
    assert_redirected_to cv_index_url
  end

  test "should update own entry" do
    sign_in_as users(:owner)
    patch entry_url(entries(:shipshape)), params: { entry: { title: "Updated Job" } }
    assert_redirected_to edit_cv_url
    assert_equal "Updated Job", entries(:shipshape).reload.title
  end

  test "should redirect non-owner from update entry" do
    sign_in_as users(:one)
    patch entry_url(entries(:shipshape)), params: { entry: { title: "Hacked" } }
    assert_redirected_to cv_index_url
    assert_equal "ShipShape Software", entries(:shipshape).reload.title
  end

  test "should destroy own entry" do
    sign_in_as users(:owner)
    assert_difference "Entry.count", -1 do
      delete entry_url(entries(:shipshape))
    end
    assert_redirected_to edit_cv_url
  end

  test "should redirect non-owner from destroy entry" do
    sign_in_as users(:one)
    assert_no_difference "Entry.count" do
      delete entry_url(entries(:shipshape))
    end
    assert_redirected_to cv_index_url
  end
end
