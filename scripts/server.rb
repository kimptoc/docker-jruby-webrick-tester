# webrick server, parsing xml via REXML

require_relative 'common'

require "webrick"
require 'webrick/https'
require 'rexml/document'

include WEBrick

class RootServlet < HTTPServlet::AbstractServlet

  def initialize(http_server = nil, request_method = nil, controller_method = nil)
    @request_method = request_method
    @controller_method = controller_method
  end

  def service(req, resp)
    begin
      resp.content_type = "application/xml"
      resp.status = HTTPStatus::RC_OK
      if req.request_method.to_sym == @request_method
        __send__(@controller_method, req, resp)
      else
        resp.body = "<error>Request not supported</error>"
        resp.status = HTTPStatus::RC_NOT_IMPLEMENTED
      end

    rescue Exception => e
      log e.message
      resp.body = "<error>#{e.message}</error>"
      resp.status = HTTPStatus::RC_INTERNAL_SERVER_ERROR
    end

  end

end





class MockWebservice < RootServlet

  @@main_instance  = nil

  def do_callback(xml, request_uri, req)
    @callback.call(xml, request_uri, req) if @callback
  end

  def start(&callback)
    log "Starting Mock Webservice"
    @@main_instance = self
    @callback = callback
    @started = false
    Thread.new do
      start_webrick do |server|
        server.mount('/heartbeat', MockWebservice, :GET, :handle_heartbeat)
        server.mount('/', MockWebservice, :GET, :handle_default)
        @started = true
        log "start block done"
      end
      log "after start_webrick"
    end
    while !@started
      sleep 1
    end
    log "Mock Webservice started!"
  end

  def start_webrick(config = {})
    config.update(:Port => 8088)
    @server = HTTPServer.new(config)
    yield @server if block_given?
    %w(INT TERM).each {|signal| trap(signal) {@server.shutdown} }
    @server.start
  end

  def handle_heartbeat(req, resp)
    begin
        xml = REXML::Document.new(req.body)

        @@main_instance.do_callback(xml, req.request_uri, req)

        resp.body = "<message>hearbeat complete @ #{Time.now}</message>"
    rescue Exception => ex
        log ex
        log req.body
        resp.body = "<message>HB ERROR:#{ex.message}</message>"
    end
  end

  def handle_default(req, resp)
    log "processing handle_post, body:#{req.body}, query:#{req.query}."

    xml = REXML::Document.new(req.body)

    @@main_instance.do_callback(xml, req.request_uri, req)

    resp.body = "<default/>"
    # raise HTTPStatus::OK
  end

  def stop
    @server.shutdown
  end
end

allxml = ''

$webservice = MockWebservice.new
$webservice.start do |xml|
  # log "req xml:#{xml}"
  allxml = allxml + xml.to_s
end

while true do
  sleep 1
end
