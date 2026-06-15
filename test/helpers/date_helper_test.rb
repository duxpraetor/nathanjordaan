require "test_helper"

class DateHelperTest < ActionView::TestCase
  include DateHelper

  test "months_between with same month" do
    assert_equal 0, months_between(Date.new(2024, 1, 1), Date.new(2024, 1, 15))
  end

  test "months_between across months" do
    assert_equal 1, months_between(Date.new(2024, 1, 1), Date.new(2024, 2, 1))
  end

  test "months_between partial month" do
    assert_equal 0, months_between(Date.new(2024, 1, 15), Date.new(2024, 2, 10))
  end

  test "months_between across years" do
    assert_equal 14, months_between(Date.new(2023, 1, 1), Date.new(2024, 3, 1))
  end

  test "months_between with day rollback" do
    assert_equal 0, months_between(Date.new(2024, 1, 31), Date.new(2024, 2, 28))
  end

  test "months_between with nil first date" do
    assert_equal 0, months_between(nil, Date.new(2024, 1, 1))
  end

  test "months_between with nil second date" do
    assert_equal 0, months_between(Date.new(2024, 1, 1), nil)
  end

  test "months_between with both nil" do
    assert_equal 0, months_between(nil, nil)
  end

  test "years_between exact years" do
    assert_equal 2, years_between(Date.new(2022, 1, 1), Date.new(2024, 1, 1))
  end

  test "years_between partial year" do
    assert_equal 1, years_between(Date.new(2022, 6, 1), Date.new(2024, 1, 1))
  end

  test "years_between with nil" do
    assert_equal 0, years_between(nil, Date.new(2024, 1, 1))
  end
end
