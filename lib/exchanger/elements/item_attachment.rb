module Exchanger
  
  # The ItemAttachment element represents an Exchange item that is attached to another Exchange item.
  #
  # http://msdn.microsoft.com/en-us/library/aa562997(v=exchg.140).aspx
  class ItemAttachment < Element
    element :attachment_id, :type => AttachmentId
    element :name
    element :content_type
    element :content_id
    element :content_location
    element :size
    element :last_modified_time
    element :is_inline
    element :item, :type => Item
    element :calendar_item, :type => CalendarItem
    element :meeting_request, :type => MeetingRequest
    element :contact, :type => Contact
    element :task, :type => Task
    element :meeting_message, :type => MeetingMessage
    element :meeting_response, :type => MeetingResponse
    element :meeting_cancellation, :type => MeetingCancellation
    element :message, :type => Message
  end
end
