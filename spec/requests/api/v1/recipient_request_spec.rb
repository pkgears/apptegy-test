# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Recipients', type: :request do
  let(:api_path) { '/api/v1' }

  let(:json) { JSON.parse(response.body) }

  let(:valid_params) do
    {
      name: 'Recipient Test',
      school_id: create(:school).id,
      address_attributes: attributes_for(:address)
    }
  end

  let(:updated_params) do
    {
      name: 'Updated Recipient'
    }
  end

  let(:invalid_params) { { name: Faker::Name.name, school_id: 150 } }

  let(:recipient) { create(:recipient) }

  describe 'GET #index' do
    it 'returns a list  of  recipiets' do
      create_list(:recipient, 5)
      get "#{api_path}/recipients"
      expect(json.size).to eq(5)
    end
  end

  describe 'GET #show' do
    context 'when response is succesful' do
      it 'returns http success' do
        get "#{api_path}/recipients/#{recipient.id}"
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when record does not exist' do
      it 'return not found status' do
        get "#{api_path}/recipients/100"
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'returns http created' do
        post "#{api_path}/recipients/", params: { recipient: valid_params }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'returns http unporcessable entity' do
        post "#{api_path}/recipients/", params: { recipient: invalid_params }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      it 'when update recipient returns http success' do
        patch "#{api_path}/recipients/#{recipient.id}", params: { recipient: { name: 'Updated School' } }
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid params' do
      it 'returns http unporcessable entity' do
        patch "#{api_path}/recipients/#{recipient.id}", params: { recipient: invalid_params }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH #address' do
    context 'with valid params' do
      it 'when update recipient returns http success' do
        patch "#{api_path}/recipients/#{recipient.id}/address", params: { address: { address: 'Updated address' } }
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid params' do
      it 'returns http unporcessable entity' do
        patch "#{api_path}/recipients/#{recipient.id}/address", params: { address: { address: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when address was not found' do
      it 'returns http not found' do
        patch "#{api_path}/recipients/10/address", params: { address: { address: nil } }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'returns http success' do
      delete "#{api_path}/recipients/#{recipient.id}"
      expect(response).to have_http_status(:success)
    end
  end
end
