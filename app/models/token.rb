class Token < ActiveRecord::Base

  enum token_type: {
    default: 0
  }

  enum status: {
    pending: 0,
    used: -1    
  }

  before_create do
    loop do
      self.body = SecureRandom.random_number(10000).to_s.rjust(4, '0')
      break if !Token.find_by(body: body)
    end    
  end

  def self.generate_body mobile
    token = self.new
    token.mobile = mobile
    token.token_type = self.token_types[:default]
    token.status = self.statuses[:pending]
    token.save!
    token
  end

  def send_msg
    s = Sms::Base.new to: mobile, code: body
    s.send
  end

end
