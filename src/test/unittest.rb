require "test/unit"
require './src/main/fooMain.rb'

class TestFoo < Test::Unit::TestCase
  def setup
    @foo = Foo.new()
  end

  def test_add
    assert_equal("asd", @foo.hello("asd"), "Should have added correctly")
  end

  def test_zio
    assert_equal("kkk", @foo.hello("kkk"), "N'si capitu n'cazzo")
  end

  def teardown
    @foo = nil
  end
end
