require "test_helper"

# rails test test/controllers/users_controller_test.rb
class UsersControllerTest < ActionDispatch::IntegrationTest
  test "User gets created" do
    user_params = {
      user: {
        name: "New User",
        email: "newuser@amp.com",
        username: "newuser",
        profile_page: "new_user",
        password: "password",
        password_confirmation: "password"
      }
    }

    assert_difference 'User.count' do
      post users_path(params: user_params)
      assert_response :redirect
    end
  end

  test "User with mismatched passwords does not create" do
    user_params = {
      user: {
        name: "New User",
        email: "newuser@amp.com",
        username: "newuser",
        password: "password",
        password_confirmation: "NOTpassword"
      }
    }

    post users_path(user_params)
    assert_response :unprocessable_entity
  end
end
