require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "User gets created" do

    user_params = {
      name: "New User",
      email: "newuser@amp.com",
      username: "newuser",
      password: "password",
      password_confirmation: "password"
    }

    assert_difference 'User.count' do
      post sign_up_path(params: user_params)
      assert_response :redirect
    end
  end
end
