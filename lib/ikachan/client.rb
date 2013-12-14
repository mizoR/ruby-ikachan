require 'net/http'
require 'net/https'

module Ikachan
  class Client
    attr_reader :hostname, :port, :ssl, :channel, :latest_exception

    def initialize(params={})
      @hostname = params[:hostname]
      @port     = params[:port] || 6667
      @ssl      = params[:ssl]  || false
    end

    def to(channel)
      @channel = channel
      self
    end

    def notify(message)
      http_start do |http|
        post = Net::HTTP::Post.new('/join')
        post.set_form_data(:channel => @channel)
        http.request(post)

        post = Net::HTTP::Post.new('/notice')
        post.set_form_data(:channel => @channel, :message => message)
        http.request(post)
      end
    end

    def notify_or_ignore(message)
      notify(message)
    rescue Exception => e
      @latest_exception = e
    end

    private

    def http_start
      http = Net::HTTP.new(@hostname, @port)
      http.use_ssl = @ssl
      http.start do
        yield(http)
      end
    end
  end
end
