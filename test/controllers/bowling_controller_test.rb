require "test_helper"

class BowlingControllerTest < ActionDispatch::IntegrationTest
  test "should get averages" do
    get bowling_averages_url
    assert_response :success
  end

  test "should get wickets" do
    get bowling_wickets_url
    assert_response :success
  end

  test "should get five_for" do
    get bowling_five_for_url
    assert_response :success
  end
end
