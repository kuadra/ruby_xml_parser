require "test/unit"
require './src/lib/xml-hash-converter.rb'

class ParserTest < Test::Unit::TestCase
  def setup
    @converter = XmlHashConverter.new()
  end

  def test_conversion
    xml = "<invio id=\"1\"><FirstName>Mario</FirstName><LastName>Rossi</LastName><ContactNo>434334344334</ContactNo><AttachmentName>cartolina_vacanze.pdf</AttachmentName><Address><City>ROMA RM</City><Street>Via Viale</Street><Zip>00165</Zip><Country>Italy</Country></Address></invio>"
    doc = @converter.convert_from_xml(xml)
    assert_equal("1", doc[:invio][:id], "Conversion fails")
  end

  def test_empty_path
    assert_raise(RuntimeError.new("Input path is empty")) {@converter.convert_from_file("")}
  end

  def test_path
    assert_raise(IOError) {@converter.convert_from_file("#@!è")}
  end

  def teardown
    @converter = nil
  end
end
