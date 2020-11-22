# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Api::V1::Orders', type: :request do
  let(:api_path) { '/api/v1' }

  let(:json) { JSON.parse(response.body) }

  let(:valid_params) do
    {
      school_id: create(:school).id,
      recipient_ids: create_list(:recipient, 4).map(&:id),
      gift_ids: create_list(:gift, 3).map(&:id)
    }
  end

  let(:invalid_params) do
    {
      school_id: 150,
      recipient_ids: create_list(:recipient, 4).map(&:id),
      gift_ids: create_list(:gift, 3).map(&:id)
    }
  end

  let(:order) { create(:order) }

  let(:headers) { token_sign_in(create(:user_with_password)) }

  describe 'POST #create' do
    context 'with valid params' do
      it 'returns http created' do
        post "#{api_path}/orders/", params: { order: valid_params }, headers: headers
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'returns http unprocessable entity' do
        post "#{api_path}/orders/", params: { order: invalid_params }, headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH #update' do
    context 'when order does not exist' do
      it 'returns http not found ' do
        patch "#{api_path}/orders/100", params: { order: { name: 'Updated School' } }, headers: headers
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'with valid params' do
      it 'when update recipient returns http success' do
        patch "#{api_path}/orders/#{order.id}", params: { order: { name: 'Updated School' } }, headers: headers
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid params' do
      it 'returns http unprocessable entity' do
        patch "#{api_path}/orders/#{order.id}", params: { order: invalid_params }, headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when order was shipped' do
      it 'returns http unprocessable entity' do
        new_order = order
        new_order.ORDER_SHIPPED!
        patch "#{api_path}/orders/#{new_order.id}", params: { order: valid_params }, headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH #ship' do
    context 'when order can change status' do
      it 'returns http success' do
        patch "#{api_path}/orders/#{order.id}/ship", headers: headers
        expect(response).to have_http_status(:success)
      end
    end

    context 'when order can change status' do
      it 'returns http unprocessable entity' do
        order.ORDER_SHIPPED!
        patch "#{api_path}/orders/#{order.id}/ship", headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH #cancel' do
    context 'when order can change status' do
      it 'returns http success' do
        patch "#{api_path}/orders/#{order.id}/cancel", headers: headers
        expect(response).to have_http_status(:success)
      end
    end

    context 'when order can change status' do
      it 'returns http unprocessable entity' do
        order.ORDER_SHIPPED!
        patch "#{api_path}/orders/#{order.id}/cancel", headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
