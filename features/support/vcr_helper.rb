require 'httpi'
require 'savon'
require 'vcr'

VCR.configure do |c|
  c.register_request_matcher :external_api_matcher do |req1, req2|
    #JSON.parse(URI(req1.uri).to_json)
    #{
    #      "scheme" => "http",
    #        "user" => nil,
    #    "password" => nil,
    #        "host" => "sparkgatetest.interfax.ru",
    #        "port" => 80,
    #        "path" => "/IfaxWebService/ifaxwebservice.asmx",
    #       "query" => "WSDL",
    #      "opaque" => nil,
    #    "registry" => nil,
    #    "fragment" => nil,
    #      "parser" => nil
    #}
    if req1.uri     == req2.uri &&
       req1.method  == req2.method

      case URI(req2.uri).path
        when %r(/SMSGateway/sms)
          # all requests for sms gateway are identical for testing purpose
          true

        when %r(/IfaxWebService/ifaxwebservice.asmx) # Spark
          req1.body  == req2.body &&
          req1.headers["Soapaction"]   == req2.headers["Soapaction"]   &&
          req1.headers["Content-Type"] == req2.headers["Content-Type"]
        
        when %r(/authentication/user/login/) # Uas
          req1.body == req2.body

        when %r(/api/orders) # Cart
          if req1.method == :post
            hash1 = JSON.parse req1.body
            hash2 = JSON.parse req2.body
            hash1.delete "SuccessUrl"
            hash2.delete "SuccessUrl"
            hash1.delete "ErrorUrl"
            hash2.delete "ErrorUrl"
            hash1 == hash2
          else
            true
          end
        else 
          req1.headers == req2.headers &&
          req1.body    == req2.body 
      end
    else
      false
    end
  end
end

VCR.configure do |c|
  c.cassette_library_dir = 'features/vcr_cassettes'
  c.hook_into :webmock
  #http://stackoverflow.com/questions/20667642/rspec-savon-vcr-not-recording
  #c.ignore_hosts 'pim.sredda.ru'
  c.ignore_localhost                        = true
  c.allow_http_connections_when_no_cassette = true
  c.default_cassette_options                = { 
    record: :new_episodes, 
    allow_playback_repeats: true, 
    match_requests_on: [:external_api_matcher]
    #match_requests_on: [:method, :uri, :headers, :body] 
  }

  # a filter, to prevent saving requests to these sites, as they should be saved by puffing-billy
  BLACKLIST = [
    %r(securepayments.sberbank.ru),
    %r(/Payment/Credentials?PaymentID=), # on payment-delo.sredda.ru:8081 site, but site could change in time
    %r(/acquiring/Register/),            # on payment-delo.sredda.ru:8081 site, but site could change in time
    %r(s.ytimg.com),
    %r(fonts.googleapis.com),
    %r(www.youtube.com),
    %r(www.google-analytics.com),
    %r(www.google.com)
  ]
  c.before_record do |i|
    if BLACKLIST.select{|e| e =~ i.request.uri }.empty?
      i.response.body.force_encoding('UTF-8') # to save cassette in human readable format
    else
      i.ignore! 
    end
  end
end
