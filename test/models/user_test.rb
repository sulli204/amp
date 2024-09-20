require "test_helper"

# rails test test/models/user_test.rb
class UserTest < ActiveSupport::TestCase
  test "user has unique fields" do
    user = User.create(user_params)

    assert_predicate user, :valid?
  end

  private

  def user_params
    {
      name: "Pat Sul",
      email: "patsul@gmail.com",
      profile_page: "patsul",
      password: "password",
      password_confirmation: "password"
    }
  end
end
