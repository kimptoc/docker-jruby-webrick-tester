# web client passing xml

require 'rexml/document'

require 'net/http'

require_relative 'common'

log "Give the server time to start"

sleep 3

allxml = ""

conn = Net::HTTP.new('server', 8088)
conn.start do |http|
  req = Net::HTTP::Get.new('/heartbeat')
  req.content_type = 'application/xml'
  (0...999).each do |i|
    req.body = %Q{<?xml version="1.0" encoding="utf-8" ?>
    <pulse>
          <dateTime>#{Time.now}</dateTime>
    </pulse>
  }
    http_resp = http.request(req)
    xml = REXML::Document.new(http_resp.body)
    allxml = allxml + xml.to_s
  end
end
