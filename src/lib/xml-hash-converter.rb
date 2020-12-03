require "nokogiri"
require 'rubygems'
require 'json'

class XmlHashConverter
  def convert_from_xml(xml)
    Hash.from_xml(xml)
  end

  def convert_from_file(path)
    if(path.empty?)
      raise RuntimeError.new("Input path is empty")
    end
    begin
      File.read(path)
      Hash.from_xml(File.read(path))
    rescue => e
      raise IOError.new("Failed to read file, input path is: " + path)
    end
  end

  def write_file(hash)
    File.open("out.txt", "w") { |f| f.write JSON.pretty_generate(hash) }
  end
end

#adapted from https://stackoverflow.com/a/1231297
class Hash
  class << self
    def from_xml(xml_io)
      begin
        result = Nokogiri::XML(xml_io)
        return { result.root.name.to_sym => xml_node_to_hash(result.root)}
      rescue Exception => e
        raise RuntimeError.new("Error during conversion")
      end
    end

    def xml_node_to_hash(node)
      # If we are at the root of the document, start the hash 
      if node.element?
        result_hash = {}
        if node.attributes != {}
          attributes = {}
          node.attributes.keys.each do |key| 
            attributes[node.attributes[key].name.to_sym] = node.attributes[key].value
          end
        end
        if node.children.size > 0
          node.children.each do |child|
            result = xml_node_to_hash(child)
            if child.name == "text"
              unless child.next_sibling || child.previous_sibling
                return result unless attributes
                result_hash[child.name.to_sym] = result
              end
            elsif result_hash[child.name.to_sym]
              if result_hash[child.name.to_sym].is_a?(Object::Array)
                 result_hash[child.name.to_sym] << result
              else
                 result_hash[child.name.to_sym] = [result_hash[child.name.to_sym]] << result
              end
            else
              result_hash[child.name.to_sym] = result
            end
          end
          if attributes
             result_hash = attributes.merge(result_hash)
          end
          return result_hash
        else
          return attributes
        end
      else
        return node.content.to_s
      end
    end
  end
end