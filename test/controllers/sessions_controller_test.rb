require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def setup
    @user = users(:Faris)
  end
  test "should get new" do
    get :new
    assert_response :success
  end

end
