require './src/lib/xml-hash-converter.rb'

if(ENV['path'])
    path = ENV['path']
    if(path[0]!="/")
        path = "./" + path
    end
    begin
        converter = XmlHashConverter.new()
        converter.write_file(converter.convert_from_file(path))
    rescue IOError => e
        puts e.message
    end
else
    puts "Filename required. Missing path argument. Append 'path=[filepath]'"
end