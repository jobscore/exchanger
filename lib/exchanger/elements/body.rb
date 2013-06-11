module Exchanger
  # The Body element represents the actual body content of a message.
  #
  # http://msdn.microsoft.com/en-us/library/aa580339.aspx
  class Body < Element
    self.field_uri_namespace = :'Body'

    element :text

    # Temp static tag attribute
    def tag_attributes
      { :body_type => "HTML" }
    end
  end
end
