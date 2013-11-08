module Exchanger
  # The GetRoomLists operation gets the room lists that are available within the Exchange organization.
  # 
  # http://msdn.microsoft.com/en-us/library/office/dd899416(v=exchg.140).aspx
  class GetRoomList < Operation
    class Request < Operation::Request
      def to_xml
        Nokogiri::XML::Builder.new do |xml|
          xml.send("soap:Envelope", "xmlns:soap" => NS["soap"], "xmlns:t" => NS["t"], "xmlns:m" => NS["m"]) do
            if Exchanger.config.acts_as != nil && Exchanger.config.acts_as != ''
              xml["soap"].Header do
                xml["t"].ExchangeImpersonation do
                  xml["t"].ConnectingSID do
                    xml["t"].PrimarySmtpAddress Exchanger.config.acts_as
                  end
                end
              end
            end
            xml.send("soap:Header") do
              xml.send("t:RequestServerVersion", "Version" => "Exchange2010")
            end
            xml['soap'].Body do
              xml.send("m:GetRoomLists")
            end
          end
        end
      end
    end
    class Response < Operation::Response
      def items
        to_xml.xpath(".//t:Address", NS).map do |node|
          Identifier.new_from_xml(node)
        end
      end
    end
  end
end
