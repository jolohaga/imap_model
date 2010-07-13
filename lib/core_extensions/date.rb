module Mail
  module DateExtensions
    def to_imap
      self.strftime('%d-%b-%Y')
    end

    Date.send(:include, self)
  end
end