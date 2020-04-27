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
      context 'can not create bar with invalid data' do

        it 'assigns brand' do
          post :create, params: { brand_id: brand, bar_name: attributes_for(:bar_name) }, format: :json
          expect(assigns(:brand)).to eq brand
        end

        it 'assigns bar_name' do
          post :create, params: { brand_id: brand, bar_name: attributes_for(:bar_name) }, format: :json
          expect(assigns(:bar_name).valid?).to be_falsey
        end

        it 'does not change bar_name count' do
          expect do
            post :create, params: { brand_id: brand, bar_name: attributes_for(:bar_name) }, format: :json
          end.to_not change(BarName, :count)
        end

        it 'return status unprocessable_entity' do
          post :create, params: { brand_id: brand, bar_name: attributes_for(:bar_name) }, format: :json
          expect(response).to have_http_status :unprocessable_entity
        end
      end
    end
    context 'Authenticated user not admin can not create bar_name' do
      let(:brand) { create(:brand) }
      let(:user) { create(:user) }
      before { login(user) }

      it 'assigns brand' do
        post :create, params: { brand_id: brand, bar_name: attributes_for(:bar_name) }, format: :json
        expect(assigns(:brand)).to be_nil
      end

      it 'assigns bar_name' do
        post :create, params: { brand_id: brand, bar_name: attributes_for(:bar_name) }, format: :json
        expect(assigns(:bar_name)).to be_nil
      end

      it 'does not change bar_name count' do
        expect do
          post :create, params: { brand_id: brand, bar_name: attributes_for(:bar_name) }, format: :json
        end.to_not change(BarName, :count)
      end

      it 'return status forbidden' do
        post :create, params: { brand_id: brand, bar_name: attributes_for(:bar_name) }, format: :json
        expect(response).to have_http_status :forbidden
      end
    end
    context 'Guest can not create bar_name' do
      let(:brand) { create(:brand) }

      it 'assigns brand' do
        post :create, params: { brand_id: brand, bar_name: attributes_for(:bar_name) }, format: :json
        expect(assigns(:brand)).to be_nil
      end

      it 'assigns bar_name' do
        post :create, params: { brand_id: brand, bar_name: attributes_for(:bar_name) }, format: :json
        expect(assigns(:bar_name)).to be_nil
      end

      it 'does not change bar_name count' do
        expect do
          post :create, params: { brand_id: brand, bar_name: attributes_for(:bar_name) }, format: :json
        end.to_not change(BarName, :count)
      end

      it 'return status unauthorized' do
        post :create, params: { brand_id: brand, bar_name: attributes_for(:bar_name) }, format: :json
        expect(response).to have_http_status :unauthorized
      end
    end
  end

  describe 'GET #edit' do
    let(:bar_name) { create(:bar_name) }

    context 'Admin' do
      let(:admin_user) { create(:user, role: 'Admin') }
      before { login(admin_user) }

      it 'assigns bar_name' do
        get :edit, params: { id: bar_name }
        expect(assigns(:bar_name)).to eq bar_name
      end
      it 'render template edit' do
        get :edit, params: { id: bar_name }
        expect(response).to render_template :edit
      end
    end

    context 'Authenticated user not admin' do
      let(:user) { create(:user) }
      before { login(user) }

      it 'assigns bar_name' do
        get :edit, params: { id: bar_name }
        expect(assigns(:bar_name)).to eq bar_name
      end

      it 'redirect to root' do
        get :edit, params: { id: bar_name }
        expect(response).to redirect_to root_path
      end
    end
    context 'Guest' do

      it 'assigns bar_name' do
        get :edit, params: { id: bar_name }
        expect(assigns(:bar_name)).to be_nil
      end

      it 'redirect to log in' do
        get :edit, params: { id: bar_name }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH #update' do
    let(:bar_name) { create(:bar_name) }

    context 'Admin' do
      let(:admin_user) { create(:user, role: 'Admin') }
      before { login(admin_user) }

      context 'cat update bar_name with valid date' do

        it 'assigns bar_name' do
          patch :update, params: { id: bar_name, bar_name: attributes_for(:bar_name) }
          expect(assigns(:bar_name)).to eq bar_name
        end

        it 'change bar_name count' do
          expect do
            patch :update, params: { id: bar_name, bar_name: { name: 'NewName' } }
            bar_name.reload
          end.to change(bar_name, :name)
        end

        it 'redirect to bar_name' do
          patch :update, params: { id: bar_name, bar_name: attributes_for(:bar_name) }
          expect(response).to redirect_to bar_name
        end

      end
      context 'can not update bar_name with invalid date' do

        it 'assigns bar_name' do
          patch :update, params: { id: bar_name, bar_name: { name: '' } }
          expect(assigns(:bar_name).valid?).to be_falsey
        end

        it 'does not change bar_name count' do
          expect do
            patch :update, params: { id: bar_name, bar_name: { name: '' } }
            bar_name.reload
          end.to_not change(bar_name, :name)
        end

        it 'render template edit' do
          patch :update, params: { id: bar_name, bar_name: { name: '' } }
          expect(response).to render_template :edit
        end
      end
    end
    context 'Authenticated user not admin' do
      let(:user) { create(:user) }
      before { login(user) }

      it 'assigns bar_name' do
        patch :update, params: { id: bar_name, bar_name: attributes_for(:bar_name) }
        expect(assigns(:bar_name)).to eq bar_name
      end

      it 'does not change bar_name count' do
        expect do
          patch :update, params: { id: bar_name, bar_name: attributes_for(:bar_name) }
          bar_name.reload
        end.to_not change(bar_name, :name)
      end

      it 'redirect to root' do
        patch :update, params: { id: bar_name, bar_name: attributes_for(:bar_name) }
        expect(response).to redirect_to root_path
      end
    end
    context 'Guest' do

      it 'assigns bar_name' do
        patch :update, params: { id: bar_name, bar_name: attributes_for(:bar_name) }
        expect(assigns(:bar_name)).to be_nil
      end

      it 'does not change bar_name count' do
        expect do
          patch :update, params: { id: bar_name, bar_name: attributes_for(:bar_name) }
          bar_name.reload
        end.to_not change(bar_name, :name)
      end

      it 'redirect to log in' do
        patch :update, params: { id: bar_name, bar_name: attributes_for(:bar_name) }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET #show' do
    let(:bar_name) { create(:bar_name) }

    context 'Admin' do
      let(:admin_user) { create(:user, role: 'Admin') }
      before { login(admin_user) }

      it 'assigns bar_name' do
        get :show, params: { id: bar_name }
        expect(assigns(:bar_name)).to eq bar_name
      end
      it 'render template show' do
        get :show, params: { id: bar_name }
        expect(response).to render_template :show
      end
    end
    context 'Authenticated user not admin' do
      let(:user) { create(:user) }
      before { login(user) }

      it 'assigns bar_name' do
        get :show, params: { id: bar_name }
        expect(assigns(:bar_name)).to eq bar_name
      end
      it 'redirect to root' do
        get :show, params: { id: bar_name }
        expect(response).to redirect_to root_path
      end
    end
    context 'Guest' do

      it 'assigns bar_name' do
        get :show, params: { id: bar_name }
        expect(assigns(:bar_name)).to be_nil
      end
      it 'redirect to log in' do
        get :show, params: { id: bar_name }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
