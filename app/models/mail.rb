require 'core_extensions'
module Mail
  class IMAP
    # Mail::IMAP
    #
    # Description:
    #   Wrapper around Net::IMAP
    #
    require 'net/imap'
    attr_accessor :settings, :connection, :query, :authenticated
    attr_reader :access, :folder, :before, :body, :cc, :from, :on, :since, :subject, :to
    
    # Initialize an IMAP object.
    #
    # Options:
    #   :address          # string, server's address
    #   :username         # string, user mail account to connect with
    #   :password         # string, user password
    #   :authentication   # string, authentication protocol, options {'login', 'cram-md5'}
    #   :enable_ssl       # boolean, default false
    #
    # Example:
    #   imap = Mail::IMAP.new(:address => '<mailserver>',:username => '<username>',:password => '<password>',:authentication => 'CRAM-MD5')
    #
    def initialize(values = {})
      self.settings = {
        :address => 'localhost',
        :port => 143,
        :username => nil,
        :password => nil,
        :authentication => 'LOGIN',
        :enable_ssl => false,
        :folder => nil,
        :access => nil
      }.merge!(values)
      @authenticated = false
      @query = []
    end
        
    # Open IMAP session.
    #
    # Accepts a hash of options.
    # Options:
    #   :folder     # string, default 'inbox'
    #   :access     # string, options: {'read-only', 'read-write'}, default 'read-only'
    #
    # Example:
    #   imap.open :folder => 'Sent Messages' do |mailbox|
    #     mailbox.search(['from', 'some user').each do |msg_id|
    #       puts msg_id
    #     end
    #   end
    #
    def open(args = {:folder => 'INBOX', :access => 'read-only'})
      self.settings.merge!(args)
      @connection ||= Net::IMAP.new(settings[:address])
      at_exit {
        connection.disconnect
      }
      begin
        @connection.authenticate(settings[:authentication],settings[:username],settings[:password]) unless authenticated
        @authenticated = true
        if settings[:access] == 'read-write'
          @connection.select(settings[:folder])
        else
          @connection.examine(settings[:folder])
        end
        yield(self) if block_given?
      rescue Net::IMAP::NoResponseError
        "Failed to authenticate."
      end
    end
    
    def access(access = 'read-only')
      @access = access
      self
    end
    
    def folder(folder = 'INBOX')
      @folder = folder
    end
    
    def before(date = Date.today)
      query.push('BEFORE',date.to_imap)
      self
    end
    
    def body(string)
      query.push('BODY',string)
      self
    end
    
    def cc(string)
      query.push('CC',string)
      self
    end
    
    def from(string)
      query.push('FROM',string)
      self
    end
    
    def update
      self
    end
    
    def on(date = Date.today)
      query.push('ON',date.to_imap)
      self
    end
    
    def since(date = Date.today - 14)
      query.push('SINCE',date.to_imap)
      self
    end
    
    def subject(string)
      query.push('SUBJECT',string)
      self
    end
    
    def to(string)
      query.push('TO',string)
      self
    end
    
    def search
      scratch = query.clone
      clear_query
      connection.search(scratch)
    end
    
    def clear_query
      @query = []
    end
    
    def fetch(arr = [])
      connection.fetch(arr,['BODY']) unless arr.empty?
    end
    
    def uid_fetch(arr = [])
      
    end
  end
  
  class Message
  end
end