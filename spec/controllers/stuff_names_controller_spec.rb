require 'rails_helper'

RSpec.describe StuffNamesController, type: :controller do
  describe 'POST #create' do
    let(:brand) { create(:brand) }

    context 'Admin' do
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
          end.to change(StuffName, :count).by(1)
        end
        it 'return status ok' do
          post :create, params: { brand_id: brand, stuff_name: attributes_for(:stuff_name) },format: :json
          expect(response).to have_http_status :ok
        end
      end
      context 'can not create stuff_name with invalid data' do
        it 'assigns brand' do
          post :create, params: { brand_id: brand, stuff_name: { name: '' } },format: :json
          expect(assigns(:brand)).to eq brand
        end
        it 'assigns stuff_name' do
          post :create, params: { brand_id: brand, stuff_name: { name: '' } },format: :json
          expect(assigns(:stuff_name).valid?).to be_falsey
        end
        it 'does not change stuff_name count' do
          expect do
            post :create, params: { brand_id: brand, stuff_name: { name: '' } },format: :json
          end.to_not change(StuffName, :count)
        end
        it 'return status unprocessable_entity' do
          post :create, params: { brand_id: brand, stuff_name: { name: '' } },format: :json
          expect(response).to have_http_status :unprocessable_entity
        end
      end
    end
    context 'Authenticated user not admin' do
      let(:user) { create(:user) }
      before { login(user) }

      it 'assigns brand' do
        post :create, params: { brand_id: brand, stuff_name: attributes_for(:stuff_name) },format: :json
        expect(assigns(:brand)).to eq brand
      end
      it 'assigns stuff_name' do
        post :create, params: { brand_id: brand, stuff_name: attributes_for(:stuff_name) },format: :json
        expect(assigns(:stuff_name)).to be_nil
      end
      it 'does not change stuff_name count' do
        expect do
          post :create, params: { brand_id: brand, stuff_name: attributes_for(:stuff_name) },format: :json
        end.to_not change(StuffName, :count)
      end
      it 'return status forbidden' do
        post :create, params: { brand_id: brand, stuff_name: attributes_for(:stuff_name) },format: :json
        expect(response).to have_http_status :forbidden
      end
    end
    context 'Guest' do

      it 'assigns brand' do
        post :create, params: { brand_id: brand, stuff_name: attributes_for(:stuff_name) },format: :json
        expect(assigns(:brand)).to be_nil
      end
      it 'assigns stuff_name' do
        post :create, params: { brand_id: brand, stuff_name: attributes_for(:stuff_name) },format: :json
        expect(assigns(:stuff_name)).to be_nil
      end
      it 'does not change stuff_name count' do
        expect do
          post :create, params: { brand_id: brand, stuff_name: attributes_for(:stuff_name) },format: :json
        end.to_not change(StuffName, :count)
      end
      it 'return status unauthorized' do
        post :create, params: { brand_id: brand, stuff_name: attributes_for(:stuff_name) },format: :json
        expect(response).to have_http_status :unauthorized
      end
    end
  end
end
