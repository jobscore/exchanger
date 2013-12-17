module Exchanger
  # The CreateAttachment element defines a request to create an attachment to an item in the Exchange store.
  # 
  # http://msdn.microsoft.com/en-us/library/aa565931(v=exchg.80).aspx
  class CreateAttachment < Operation
    class Request < Operation::Request
      attr_accessor :parent_item_id, :attachments

      # Reset request options to defaults.
      def reset
        @parent_item_id = nil
        @attachments = nil
      end

      def to_xml
        create_item_params = {"xmlns" => NS["m"], "xmlns:t" => NS["t"]}

        Nokogiri::XML::Builder.new do |xml|
          xml.send("soap:Envelope", "xmlns:soap" => NS["soap"], "xmlns:t" => NS["t"], "xmlns:xsi" => NS["xsi"], "xmlns:xsd" => NS["xsd"]) do
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
              xml.CreateAttachment(create_item_params) do
                xml << @parent_item_id.to_xml.to_s

                xml.Attachments do
                  @attachments.each do |item|
                    item_xml = item.to_xml
                    item_xml.add_namespace_definition("t", NS["t"])
                    item_xml.namespace = item_xml.namespace_definitions[0]
                    xml << item_xml.to_s
                  end
                end
              end
            end
          end
        end
      end
    end

    class Response < Operation::Response
      def item_ids
        to_xml.to_s
        #to_xml.xpath(".//t:ItemId", NS).map do |node|
        #  Identifier.new_from_xml(node)
        #end
      end
    end
  end
end
