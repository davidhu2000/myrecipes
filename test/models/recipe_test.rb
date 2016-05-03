require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  def setup
    @recipe = Recipe.new(name: "chicken parm", summary: "best dish ever", description: "put chicken in oven, then wait")
  end
  
  test "recipe should be valid" do
    assert @recipe.valid?
  end
  
  test "name should be present" do
    @recipe.name = " "
    assert_not @recipe.valid?
  end
  
  test "name length < 100 characters" do
    @recipe.name = "a" * 101
    assert_not @recipe.valid?
  end
  
  test "name length > 5 characters" do
    @recipe.name = "a" * 4
    assert_not @recipe.valid?
  end
  
  test "summary should be present" do
    @recipe.summary = ""
    assert_not @recipe.valid?
  end
  
  test "summary length > 10 characters" do
    @recipe.summary = "a" * 9
    assert_not @recipe.valid?
  end
  
  test "summary length < 150 characters" do 
    @recipe.summary = "a" * 151
    assert_not @recipe.valid?
  end
  
  test "description should be present" do
    @recipe.description = ""
    assert_not @recipe.valid?
  end
  
  test "description length > 20 characters" do 
    @recipe.description = "a" * 19
    assert_not @recipe.valid?
  end
  
  test "description length < 500 characters" do
    @recipe.description = "a" * 501
    assert_not @recipe.valid?
  end
  
end