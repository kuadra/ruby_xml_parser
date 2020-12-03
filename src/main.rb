require './src/lib/xml-hash-converter.rb'

converter = XmlHashConverter.new()
converter.write_file(converter.convert("./hr_test_1.xml"))