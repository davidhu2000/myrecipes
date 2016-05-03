require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  def setup
    @chef = Chef.new(name: "John", email: "john@example.com")
  end
  
  test "chef should be valid" do
    assert @chef.valid?
  end
  
  test "chef name should be present" do
    @chef.name = ""
    assert_not @chef.valid?
  end
  
  test "chef name > 3" do
    @chef.name = "aa"
    assert_not @chef.valid?
  end
  
  test "chef name < 40" do
    @chef.name = "a" * 41
    assert_not @chef.valid?
  end
  
  test "email should be present" do
    @chef.email = ""
    assert_not @chef.valid?
  end
  
  test "email length should be within bounds" do
    @chef.email = "a" * 101 + "@example.com"
    assert_not @chef.valid?
  end
  
  #create duplicate copy of chef and save chef to database, so dup_chef should not be saved and return an error
  test "email should unique" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end
  
  test "email validation should accept valid address" do
    valid_addresses = %w[user@eee.com R_Tdd-ds@ee.hello.org user@example.com first.last@a.eu]
    valid_addresses.each {|email|
      @chef.email = email
      assert @chef.valid?, "#{email.inspect} should be valid"
    }
  end
  
  test "email validation should reject invalid address" do
    invalid_address = %w[user@example user_at_3@exampl,com 1234$qiest.each diie@err+era.com]
    invalid_address.each {|email|
      @chef.email = email
      assert_not @chef.valid?, "#{email.inspect} should be invalid"
    }
    
  end
end