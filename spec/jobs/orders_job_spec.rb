require 'rails_helper'

RSpec.describe OrdersJob, type: :job do
  let(:order) { create(:order) }

  describe '#perform_later' do
    it 'send mail of order_shipped' do
      ActiveJob::Base.queue_adapter = :test
      expect {
        OrdersJob.perform_later(order)
      }.to have_enqueued_job
    end
  end
end
