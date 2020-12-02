require "nokogiri"

class Foo
  def hello(asd)
    asd
  end
end

@doc = Nokogiri::XML(File.read("./src/hr_test_1.xml"))
@first_names = @doc.xpath("//FirstName")
@last_names = @doc.xpath("//LastName")

puts "first_names: "
puts @first_names
puts "last names: "
puts @last_names

@test = @doc.xpath("//data")
puts @test.xpath("//invio")

