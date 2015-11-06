class ClearOrderJob
  include Sidekiq::Worker 
  include Sidetiq::Schedulable 

  recurrence { daily }
  
  def perform

    Order.pending.each do |o|

      if o.created_at + 24.hours <= Time.now
        o.destroy
      end

    end
  end

end
