module Exchanger
  # The Attachments element contains the items or files that are attached to an item in the Exchange store.
  #
  # http://msdn.microsoft.com/en-us/library/aa564869(v=exchg.140).aspx
  class Attachments < Element

    element :file_attachment, :type => FileAttachment

  end
end
