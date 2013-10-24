module Exchanger
  # The AttachmentId element identifies an item or file attachment. This element is used in CreateAttachment responses.
  #
  # http://msdn.microsoft.com/en-us/library/aa580987(v=exchg.140).aspx
  class AttachmentId < Element
    key :id 
    key :root_item_id 
    key :root_item_change_key
  end
end
