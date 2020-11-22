# frozen_string_literal: true
require 'rails_helper'
require 'support/devise_auth_helper.rb'

RSpec.describe 'Schools', type: :request do
  let(:api_path) { '/api/v1' }

  let(:json) { JSON.parse(response.body) }

  let(:valid_params) do
    {
      name: 'School Test',
      address_attributes: attributes_for(:address)
    }
  end

  let(:updated_params) do
    {
      name: 'Updated School'
    }
  end

  let(:invalid_params) { { name: nil } }

  let(:school) { create(:school) }

  let(:headers) { token_sign_in(create(:user_with_password)) }

  describe 'GET #index' do
    it 'returns a list of schools' do
      create_list(:school, 5)
      get "#{api_path}/schools", headers: headers
      expect(json.size).to eq(5)
    end
  end

  describe 'GET #show' do
    context 'when response is succesful' do
      it 'returns http success' do
        get "#{api_path}/schools/#{school.id}", headers: headers
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when record does not exist' do
      it 'return not found status' do
        get "#{api_path}/schools/100", headers: headers
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'returns http created' do
        post "#{api_path}/schools/", params: { school: valid_params }, headers: headers
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'returns http unporcessable entity' do
        post "#{api_path}/schools/", params: { school: invalid_params }, headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      it 'when update school returns http success' do
        patch "#{api_path}/schools/#{school.id}", params: { school: { name: 'Updated School' } }, headers: headers
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid params' do
      it 'returns http unporcessable entity' do
        patch "#{api_path}/schools/#{school.id}", params: { school: invalid_params }, headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH #address' do
    context 'with valid params' do
      it 'when update school returns http success' do
        patch "#{api_path}/schools/#{school.id}/address", params: { address: { address: 'Updated address' } }, headers: headers
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid params' do
      it 'returns http unporcessable entity' do
        patch "#{api_path}/schools/#{school.id}/address", params: { address: { address: nil } }, headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when address was not found' do
      it 'returns http not found' do
        patch "#{api_path}/schools/10/address", params: { address: { address: nil } }, headers: headers
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'returns http success' do
      delete "#{api_path}/schools/#{school.id}", headers: headers
      expect(response).to have_http_status(:success)
    end
  end
end
