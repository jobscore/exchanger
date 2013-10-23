module Exchanger
  # The CalendarItem element represents an Exchanger calendar item.
  #
  # http://msdn.microsoft.com/en-us/library/aa562964(v=exchg.140).aspx
  class AcceptItem < Element
    # self.field_uri_namespace = :calendar

    # element :body, :type => Body
    element :reference_item_id, :type => ReferenceIdentifier

    def create
      CreateItem.run(:items => [self], :message_disposition => 'SendOnly')
    end
  end
end
