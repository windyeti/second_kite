require 'rails_helper'

RSpec.describe BarNamesController, type: :controller do
  describe 'POST #create' do
    context 'Admin' do
      let(:brand) { create(:brand) }
      let(:admin_user) { create(:user, role: 'Admin') }
      before { login(admin_user) }

      context 'can create bar with valid data' do

        it 'assigns brand' do
          post :create, params: { brand_id: brand, bar_name: attributes_for(:bar_name) }, format: :json
          expect(assigns(:brand)).to eq brand
        end

        it 'assigns bar' do
          post :create, params: { brand_id: brand, bar_name: attributes_for(:bar_name) }, format: :json
          expect(assigns(:bar_name)).to eq brand.bar_names.first
        end

        it 'change bar count' do
          expect do
            post :create, params: { brand_id: brand, bar_name: attributes_for(:bar_name) }, format: :json
          end.to change(BarName, :count).by(1)
        end

        it 'return status ok' do
          post :create, params: { brand_id: brand, bar_name: attributes_for(:bar_name) }, format: :json
          expect(response).to have_http_status :ok
        end
      end
      context 'can not create bar with invalid data'
    end
    context 'Authenticated user not admin'
      context 'can not create bar'
    context 'Guest'
      context 'can not create bar'
  end
end
