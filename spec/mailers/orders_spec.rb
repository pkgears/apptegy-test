# frozen_string_literal: true
require 'rails_helper'

RSpec.describe OrdersMailer, type: :mailer do
  describe '#order_shipped' do
    let(:order) { create(:order) }
    let(:mail) { OrdersMailer.with(order: order).order_shipped }

    it 'renders the headers' do
      expect(mail.subject).to eq('You has an order shipped')
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include('Hi!')
    end
  end
end
