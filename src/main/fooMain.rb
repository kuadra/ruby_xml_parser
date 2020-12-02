require "nokogiri"

class Foo
  def hello(asd)
    asd
  end
end

@doc = Nokogiri::XML(File.read("./src/hr_test_1.xml"))
print @doc.xpath("//FirstName")

