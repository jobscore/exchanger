module Exchanger
  # The ExtendedFieldURI element identifies an extended MAPI property.
  # http://msdn.microsoft.com/en-us/library/aa564843(v=exchg.140).aspx
  class ExtendedFieldUri < Element
    key :distinguished_property_set_id
    key :property_name
    key :property_type

    def tag_name
      "ExtendedFieldURI"
    end
  end
end
