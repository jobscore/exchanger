module Exchanger
  # The AcceptItem element represents an Accept reply to a meeting request.
  #
  # http://msdn.microsoft.com/en-us/library/aa562964(v=exchg.140).aspx
  class AcceptItem < Element

    element :reference_item_id, :type => ReferenceIdentifier

    def create
      CreateItem.run(:items => [self], :message_disposition => 'SendOnly')
    end
  end
end
