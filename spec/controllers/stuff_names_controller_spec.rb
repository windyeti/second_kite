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

  describe 'GET #edit' do
    let(:stuff_name) { create(:stuff_name) }

    context 'Admin' do
      let(:admin_user) { create(:user, role: 'Admin') }
      before { login(admin_user) }

      it "assigns stuff_name" do
        get :edit, params: { id: stuff_name }
        expect(assigns(:stuff_name)).to eq stuff_name
      end

      it "render template edit" do
        get :edit, params: { id: stuff_name }
        expect(response).to render_template :edit
      end
    end
    context 'Authenticated user not admin' do
      let(:user) { create(:user) }
      before { login(user) }

      it "assigns stuff_name" do
        get :edit, params: { id: stuff_name }
        expect(assigns(:stuff_name)).to eq stuff_name
      end

      it "redirect to root" do
        get :edit, params: { id: stuff_name }
        expect(response).to redirect_to root_path
      end
    end
    context 'Guest' do

      it "assigns stuff_name" do
        get :edit, params: { id: stuff_name }
        expect(assigns(:stuff_name)).to be_nil
      end

      it "redirect to log in" do
        get :edit, params: { id: stuff_name }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH #update' do
    let(:stuff_name) { create(:stuff_name) }

    context 'Admin' do
      let(:admin_user) { create(:user, role: 'Admin') }
      before { login(admin_user) }

      context 'can update stuff_name with valid data' do
        it 'assigns stuff_name' do
          patch :update, params: { id: stuff_name, stuff_name: { name: 'NewStuffName' } }
          expect(assigns(:stuff_name)).to eq stuff_name
        end
        it 'redirect to stuff_name' do
          patch :update, params: { id: stuff_name, stuff_name: { name: 'NewStuffName' } }
          expect(response).to redirect_to stuff_name
        end
        it 'change name of stuff_name' do
          expect do
            patch :update, params: { id: stuff_name, stuff_name: { name: 'NewStuffName' } }
            stuff_name.reload
          end.to change(stuff_name, :name)
        end
      end
      context 'cannot update stuff_name with invalid data' do
        it 'assigns stuff_name' do
          patch :update, params: { id: stuff_name, stuff_name: { name: '' } }
          expect(assigns(:stuff_name).valid?).to be_falsey
        end
        it 'render template edit' do
          patch :update, params: { id: stuff_name, stuff_name: { name: '' } }
          expect(response).to render_template :edit
        end
        it 'does not change name of stuff_name' do
          expect do
            patch :update, params: { id: stuff_name, stuff_name: { name: '' } }
            stuff_name.reload
          end.to_not change(stuff_name, :name)
        end
      end
    end
    context 'Authenticated user not admin' do
      let(:user) { create(:user) }
      before { login(user) }

      it 'assigns stuff_name' do
        patch :update, params: { id: stuff_name, stuff_name: { name: 'NewStuffName' } }
        expect(assigns(:stuff_name)).to eq stuff_name
      end
      it 'redirect to root' do
        patch :update, params: { id: stuff_name, stuff_name: { name: 'NewStuffName' } }
        expect(response).to redirect_to root_path
      end
      it 'does not change name of stuff_name' do
        expect do
          patch :update, params: { id: stuff_name, stuff_name: { name: 'NewStuffName' } }
          stuff_name.reload
        end.to_not change(stuff_name, :name)
      end

    end
    context 'Guest' do
      it 'assigns stuff_name' do
        patch :update, params: { id: stuff_name, stuff_name: { name: 'NewStuffName' } }
        expect(assigns(:stuff_name)).to be_nil
      end
      it 'redirect to log in' do
        patch :update, params: { id: stuff_name, stuff_name: { name: 'NewStuffName' } }
        expect(response).to redirect_to new_user_session_path
      end
      it 'does not change name of stuff_name' do
        expect do
          patch :update, params: { id: stuff_name, stuff_name: { name: 'NewStuffName' } }
          stuff_name.reload
        end.to_not change(stuff_name, :name)
      end
    end
  end

  describe 'GET #show' do
    let(:stuff_name) { create(:stuff_name) }

    context 'Admin' do
      let(:admin_user) { create(:user, role: 'Admin') }
      before { login(admin_user) }

      it 'assigns stuff_name' do
        get :show, params: { id: stuff_name }
        expect(assigns(:stuff_name)).to eq stuff_name
      end

      it 'render template show' do
        get :show, params: { id: stuff_name }
        expect(assigns(:stuff_name)).to render_template :show
      end
    end
    context 'Authenticated user not admin' do
      let(:user) { create(:user) }
      before { login(user) }

      it 'assigns stuff_name' do
        get :show, params: { id: stuff_name }
        expect(assigns(:stuff_name)).to eq stuff_name
      end

      it 'redirect to root' do
        get :show, params: { id: stuff_name }
        expect(assigns(:stuff_name)).to redirect_to root_path
      end
    end
    context 'Guest' do

      it 'assigns stuff_name' do
        get :show, params: { id: stuff_name }
        expect(assigns(:stuff_name)).to be_nil
      end

      it 'redirect to log in' do
        get :show, params: { id: stuff_name }
        expect(assigns(:stuff_name)).to redirect_to new_user_session_path
      end
    end
  end
end
