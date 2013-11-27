module Exchanger
  # The Body element represents the actual body content of a message.
  #
  # http://msdn.microsoft.com/en-us/library/aa581015(v=exchg.140).aspx
  class Body < Element
    self.field_uri_namespace = :'Body'

    element :text
    key :body_type #HTML or Text
  end
end
