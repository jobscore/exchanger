module Exchanger
  # The GetRooms operation gets the rooms within the specified room list.
  # 
  # http://msdn.microsoft.com/en-us/library/office/dd899415(v=exchg.140).aspx
  class GetRooms < Operation
    class Request < Operation::Request
      attr_accessor :email_address

      def reset
        @email_address = nil
      end

      def to_xml
        Nokogiri::XML::Builder.new do |xml|
          xml.send("soap:Envelope", "xmlns:soap" => NS["soap"], "xmlns:t" => NS["t"], "xmlns:m" => NS["m"]) do
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
            xml['soap'].Body do
              xml.send("m:GetRooms") do
                xml.send("m:RoomList") do
                  xml.send("t:EmailAddress", email_address)
                end
              end
            end
          end
        end
      end
    end
    class Response < Operation::Response
      def items
        to_xml.xpath(".//t:Id", NS).map do |node|
          Identifier.new_from_xml(node)
        end
      end
    end
  end
end