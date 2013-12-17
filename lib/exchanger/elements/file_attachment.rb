module Exchanger
  # The FileAttachment element represents a file that is attached to an item in the Exchange store.
  #
  # http://msdn.microsoft.com/en-us/library/aa580492(v=exchg.140).aspx
  class FileAttachment < Element
    element :attachment_id, :type => AttachmentId
    element :name
    element :content_type
    element :content_id
    element :content_location
    element :size
    element :last_modified_time
    element :is_inline
    element :is_contact_photo
    element :content
  end    
end
