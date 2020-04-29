require 'rails_helper'

RSpec.describe StuffNamesController, type: :controller do
  describe 'POST #create' do
    context 'Admin' do
      let(:brand) { create(:brand) }
      let(:admin_user) { create(:user, role: 'Admin') }
      before { login(admin_user) }

      context 'can create stuff_name with valid data' do
        it 'assigns brand' do
          post :create, params: { brand_id: brand, stuff_name: attributes_for(:stuff_name) },format: :json
          expect(assigns(:brand)).to eq brand
        end
        it 'assigns stuff_name' do
          post :create, params: { brand_id: brand, stuff_name: attributes_for(:stuff_name) },format: :json
          expect(assigns(:stuff_name)).to eq brand.stuff_names.first
        end
        it 'change stuff_name count' do
          expect do
            post :create, params: { brand_id: brand, stuff_name: attributes_for(:stuff_name) },format: :json
          end.to change(StuffName, :count)
        end
        it 'return status ok' do
          post :create, params: { brand_id: brand, stuff_name: attributes_for(:stuff_name) },format: :json
          expect(response).to have_http_status :ok
        end
      end
      context 'can not create stuff_name with invalid data'
    end
    context 'Authenticated user not admin'
    context 'Guest'
  end
end
