require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "User gets created" do
    user_params = {
      user: {
        name: "New User",
        email: "newuser@amp.com",
        username: "newuser",
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

  test "User cannot have existing email" do
    first_user_params = {
      user: {
        name: "New User 1",
        email: "newuser@amp.com",
        username: "newuser1",
        password: "password",
        password_confirmation: "password"
      }
    }

    second_user_params = {
      user: {
        name: "New User 2",
        email: "newuser@amp.com",
        username: "newuser2",
        password: "password",
        password_confirmation: "password"
      }
    }
    assert_difference 'User.count' do
      post users_path(first_user_params)
      assert_response :redirect
    end

    post users_path(second_user_params)
    assert_response :unprocessable_entity
  end
end
