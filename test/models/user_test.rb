require "test_helper"

# rails test test/models/user_test.rb
class UserTest < ActiveSupport::TestCase
  test "user is created with valid fields" do
    user = User.create(user_params)
    assert_predicate user, :valid?
  end

  test "user will not be created without required fields" do
    user = User.create()
    assert_predicate user, :invalid?

    error_messages = user.errors.messages

    assert_includes error_messages[:password], "can't be blank"
    assert_includes error_messages[:name], "can't be blank"
    assert_includes error_messages[:username], "can't be blank"
    assert_includes error_messages[:email], "can't be blank"
    assert_includes error_messages[:profile_page], "can't be blank"
  end

  test "email and username must be a unique pair" do
    user_2_params = {
      name: "user_2",
      username: user_params[:username],
      email: user_params[:email],
      profile_page: "user_2",
      password: "password",
      password_confirmation: "password"
    }

    user_1 = User.create(user_params)
    assert_predicate user_1, :valid?

    user_2 = User.create(user_2_params)
    assert_predicate user_2, :invalid?

    error_messages = user_2.errors.messages
    assert_includes error_messages[:email], "has already been taken"
    assert_includes error_messages[:username], "has already been taken"

    user_2_params[:email] = "user_2@gmail.com"
    user_2 = assert_difference 'User.count', 1 do
      User.create(user_2_params)
    end

    # Same username, different email
    assert_includes user_2.username, user_1.username
    diff user_2.email, user_1.email

    assert_predicate user_2, :valid?
  end

  test "user will not be created with invalid fields" do
    invalid_params = {
      name: "invalid user",
      username: "invalidjoe",
      email: "newuser@gmail.com", # unique constraint
      profile_page: "new_user_1", # unique constraint
      password: "password",
      password_confirmation: "password"
    }

    user = User.create(user_params)
    assert_predicate user, :valid?

    non_valid_user = User.create(invalid_params)
    assert_predicate non_valid_user, :invalid?

    assert_includes non_valid_user.errors.messages[:email], "has already been taken"
    assert_includes non_valid_user.errors.messages[:profile_page], "has already been taken"
  end

  private

  def user_params
    {
      name: "new user",
      username: "newuser",
      email: "newuser@gmail.com",
      profile_page: "new_user_1",
      password: "password",
      password_confirmation: "password"
    }
  end
end

# rails test test/models/user_test.rb
