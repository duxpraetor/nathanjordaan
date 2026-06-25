require "test_helper"

class BulletsControllerTest < ActionDispatch::IntegrationTest
  test "should redirect new when not authenticated" do
    get new_entry_bullet_url(entry_id: entries(:shipshape).id)
    assert_redirected_to new_session_url
  end

  test "should redirect create when not authenticated" do
    post entry_bullets_url(entry_id: entries(:shipshape).id), params: { bullet: { description: "Hacked" } }
    assert_redirected_to new_session_url
  end

  test "should redirect edit when not authenticated" do
    get edit_bullet_url(bullets(:shipshape_bullet_1))
    assert_redirected_to new_session_url
  end

  test "should redirect update when not authenticated" do
    patch bullet_url(bullets(:shipshape_bullet_1)), params: { bullet: { description: "Hacked" } }
    assert_redirected_to new_session_url
  end

  test "should redirect destroy when not authenticated" do
    delete bullet_url(bullets(:shipshape_bullet_1))
    assert_redirected_to new_session_url
  end

  test "should create bullet for own entry" do
    sign_in_as users(:owner)
    assert_difference "Bullet.count", 1 do
      post entry_bullets_url(entry_id: entries(:shipshape).id), params: { bullet: { description: "New achievement", display_order: 3 } }
    end
    assert_redirected_to edit_cv_url
    assert_equal "New achievement", entries(:shipshape).bullets.last.description
  end

  test "should not create bullet for other user's entry" do
    sign_in_as users(:one)
    assert_no_difference "Bullet.count" do
      post entry_bullets_url(entry_id: entries(:shipshape).id), params: { bullet: { description: "Hacked" } }
    end
    assert_response :not_found
  end

  test "should update own bullet" do
    sign_in_as users(:owner)
    patch bullet_url(bullets(:shipshape_bullet_1)), params: { bullet: { description: "Updated achievement" } }
    assert_redirected_to edit_cv_url
    assert_equal "Updated achievement", bullets(:shipshape_bullet_1).reload.description
  end

  test "should not update other user's bullet" do
    sign_in_as users(:one)
    patch bullet_url(bullets(:shipshape_bullet_1)), params: { bullet: { description: "Hacked" } }
    assert_response :not_found
    assert_equal "Redesign and rewrite of a Transport Management (TMS) Android app", bullets(:shipshape_bullet_1).reload.description
  end

  test "should destroy own bullet" do
    sign_in_as users(:owner)
    assert_difference "Bullet.count", -1 do
      delete bullet_url(bullets(:shipshape_bullet_1))
    end
    assert_redirected_to edit_cv_url
  end

  test "should not destroy other user's bullet" do
    sign_in_as users(:one)
    assert_no_difference "Bullet.count" do
      delete bullet_url(bullets(:shipshape_bullet_1))
    end
    assert_response :not_found
  end
end
