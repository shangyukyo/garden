::CarrierWave.configure do |config|  
  config.asset_host = Rails.env.production? ? "http://101.200.197.162:9004" : "http://localhost:3000"
end