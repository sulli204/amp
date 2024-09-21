require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "login fails on bad password" do
    auth_params = {
      authenticity_token: "token",
      email: "bad@email.com",
      password: "don'texist"
    }

    post login_path(auth_params)
    assert_response :unprocessable_entity
  end

  test "login works on created user" do
    user_params = {
      user: {
        name: "New User",
        email: "newuser@pubmus.com",
        username: "newuser",
        profile_page: "new_user",
        password: "password",
        password_confirmation: "password"
      }
    }

    auth_params = {
      email: "newuser@pubmus.com",
      password: "password"
    }

    assert_difference 'User.count' do
      post users_path(params: user_params)
      assert_response :redirect
    end

    delete logout_path
    assert_redirected_to root_path

    post login_path(auth_params)
    assert_redirected_to root_path
  end
end
