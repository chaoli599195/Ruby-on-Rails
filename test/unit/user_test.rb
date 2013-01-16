require 'test_helper'

class UserTest < ActiveSupport::TestCase



    test "user" do
      user = User.new
      assert user.invalid?
      assert user.errors[:name].any?
      assert user.errors[:password].any?
      end

end
