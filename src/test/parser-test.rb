require "test/unit"
require './src/lib/xml-hash-converter.rb'

class ParserTest < Test::Unit::TestCase
  def setup
    @converter = XmlHashConverter.new()
  end

  def test_add
    doc = @converter.convert("./hr_test_1.xml")
    assert_equal("9932", doc[:InvioPostale][:unique_id], "Conversion fails")
  end

  def test_empty
    assert_raise(RuntimeError.new("Input path is empty")) {@converter.convert("")}
  end

  def test_path
    assert_raise(RuntimeError) {@converter.convert("#@!è")}
  end

  def teardown
    @converter = nil
  end
end
