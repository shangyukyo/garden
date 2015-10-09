require "digest"
require 'base64' 

module Sms

  class Base

    def initialize args

      @account_sid = "8a48b5514fb1a66a014fb645c6660a43"
      @auth_token  = "7c09f0da3b2e4dc1ad90daae3536d492"

      @timestamp   = Time.now.strftime("%Y%m%d%H%M%S")

      sign_params = ""
      sign_params << @account_sid
      sign_params << @auth_token
      sign_params << @timestamp

      sign_params = Digest::MD5.hexdigest(sign_params).upcase      

      if Rails.env.production?
        @domain = "https://app.cloopen.com:8883"
      elsif Rails.env.development?
        @domain = "https://sandboxapp.cloopen.com:8883"
      end

      @path = "/2013-12-26/Accounts/#{@account_sid}/SMS/TemplateSMS?sig=#{sign_params}"
      @to = args[:to]
      @app_id = "aaf98f894fba2cb2014fd0361da9112e"
      @template_id = "37453"
      @datas = [ args[:code] ]
    end

    def send
      params = {
        to: @to,
        appId: @app_id,
        templateId: @template_id,
        datas: @datas
      }

      puts "#{@account_sid}:#{@timestamp}"


      headers = {
        "Accept"        => "application/json",
        "Content-Type"  => "application/json;charset=utf-8",        
        "Authorization" => Base64.encode64("#{@account_sid}:#{@timestamp}").delete("\n")
      }

      a = Base64.encode64("#{@account_sid}:#{@timestamp}")



      client = RestClient::Resource.new @domain

      response = client[@path].post params.to_json, headers

      response
    end

  end

end