module Exchanger
  # The ExtendedProperty element identifies extended MAPI properties on folders and items.
  # http://msdn.microsoft.com/en-us/library/aa566405(v=exchg.140).aspx
  class ExtendedProperty < Element
    element :extended_field_uri, :type => ExtendedFieldUri
    element :value
  end
end
