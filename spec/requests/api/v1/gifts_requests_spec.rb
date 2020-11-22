# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Gifts', type: :request do
  let(:api_path) { '/api/v1' }

  let(:json) { JSON.parse(response.body) }

  let(:valid_params) do
    {
      name: 'MUG'
    }
  end

  let(:updated_params) do
    {
      name: 'Updated gift'
    }
  end

  let(:invalid_params) { { name: nil } }

  let(:gift) { create(:gift) }

  describe 'GET #index' do
    it 'returns a list of gifts' do
      create_list(:gift, 5)
      get "#{api_path}/gifts"
      expect(json.size).to eq(5)
    end
  end

  describe 'GET #show' do
    context 'when response is succesful' do
      it 'returns http success' do
        get "#{api_path}/gifts/#{gift.id}"
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when record does not exist' do
      it 'return not found status' do
        get "#{api_path}/gifts/100"
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'returns http created' do
        post "#{api_path}/gifts/", params: { gift: valid_params }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'returns http unporcessable entity' do
        post "#{api_path}/gifts/", params: { gift: invalid_params }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      it 'when update gift returns http success' do
        patch "#{api_path}/gifts/#{gift.id}", params: { gift: { name: 'Updated School' } }
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid params' do
      it 'returns http unporcessable entity' do
        patch "#{api_path}/gifts/#{gift.id}", params: { gift: invalid_params }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'returns http success' do
      delete "#{api_path}/gifts/#{gift.id}"
      expect(response).to have_http_status(:success)
    end
  end
end
