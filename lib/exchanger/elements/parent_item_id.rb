module Exchanger
  # The ParentItemId element identifies the parent item that links to an associated attachment.
  #
  # http://msdn.microsoft.com/en-us/library/aa563720(v=exchg.80).aspx
  class ParentItemId < Element
    key :id 
    key :change_key
  end
end