module Exchanger
  # The FindItem operation identifies items that are located in a specified folder.
  # 
  # http://msdn.microsoft.com/en-us/library/aa566107.aspx
  class FindItem < Operation
    class Request < Operation::Request
      attr_accessor :folder_id, :traversal, :base_shape, :email_address, :property_name, :property_value

      # Reset request options to defaults.
      def reset
        @folder_id = :contacts
        @traversal = :shallow
        @base_shape = :all_properties
        @email_address = nil
      end

      def to_xml
        Nokogiri::XML::Builder.new do |xml|
          xml.send("soap:Envelope", "xmlns:soap" => NS["soap"], "xmlns:t" => NS["t"]) do
            if Exchanger.config.version || Exchanger.config.acts_as
              xml["soap"].Header do
                if Exchanger.config.version
                  xml["t"].RequestServerVersion("Version" => Exchanger.config.version)
                end
                if Exchanger.config.acts_as
                  xml["t"].ExchangeImpersonation do
                    xml["t"].ConnectingSID do
                      xml["t"].PrimarySmtpAddress Exchanger.config.acts_as
                    end
                  end
                end
              end
            end
            xml.send("soap:Body") do
              xml.FindItem("xmlns" => NS["m"], "xmlns:t" => NS["t"], "Traversal" => traversal.to_s.camelize) do
                xml.ItemShape do
                  xml.send "t:BaseShape", base_shape.to_s.camelize
                  if property_name
                    xml["t"].AdditionalProperties do
                      xml["t"].ExtendedFieldURI(
                        "PropertyName" => property_name.to_s,
                        "DistinguishedPropertySetId" => "PublicStrings",
                        "PropertyType" => "String"
                      )
                    end
                  end
                end
                if property_name
                  xml.Restriction do
                    xml["t"].IsEqualTo do
                      xml["t"].ExtendedFieldURI(
                        "PropertyName" => property_name.to_s,
                        "DistinguishedPropertySetId" => "PublicStrings",
                        "PropertyType" => "String"
                      )
                      xml["t"].FieldURIOrConstant do
                        xml["t"].Constant("Value" => property_value.to_s)
                      end
                    end
                  end
                end
                xml.ParentFolderIds do
                  if folder_id.is_a?(Symbol)
                    xml.send("t:DistinguishedFolderId", "Id" => folder_id) do
                      if email_address
                        xml.send("t:Mailbox") do
                          xml.send("t:EmailAddress", email_address)
                        end
                      end
                    end
                  else
                    xml.send("t:FolderId", "Id" => folder_id)
                  end
                end
              end
            end
          end
        end
      end
    end

    class Response < Operation::Response
      def items
        to_xml.xpath(".//t:Items", NS).children.map do |node|
          item_klass = Exchanger.const_get(node.name)
          item_klass.new_from_xml(node)
        end
      end
    end
  end
end
