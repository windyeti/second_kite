require 'rails_helper'

RSpec.describe KiteNamesController, type: :controller do

  describe "GET #index" do
    let!(:brand) { create(:brand) }

    context 'Admin' do
      let(:admin_user) { create(:user, role: 'Admin') }
      before { login(admin_user) }

      it "render template index" do
        get :index, params: { brand_id: brand }
        expect(response).to render_template :index
      end

      it "assigns brand" do
        get :index, params: { brand_id: brand }
        expect(assigns(:brand)).to eq brand
      end

      it "assigns kite_name" do
        get :index, params: { brand_id: brand }
        expect(assigns(:kite_name)).to be_a_new KiteName
      end
    end

    context 'Authenticated user not admin' do
      let(:user) { create(:user) }
      before { login(user) }

      it "redirect to root" do
        get :index, params: { brand_id: brand }
        expect(response).to redirect_to root_path
      end
    end

    context 'Guest' do

      it "redirect to log in" do
        get :index, params: { brand_id: brand }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "POST #create" do
    context 'Admin' do
      let!(:brand) { create(:brand) }
      let(:admin_user) { create(:user, role: 'Admin') }
      before { login(admin_user) }

      context "with valid data can create kite_name" do

        it "assigns brand" do
          post :create, params: { brand_id: brand, kite_name: attributes_for(:kite_name) }, format: :json
          expect(assigns(:brand)).to eq brand
        end

        it "assigns kite_name" do
          post :create, params: { brand_id: brand, kite_name: attributes_for(:kite_name) }, format: :json
          expect(assigns(:kite_name)).to eq KiteName.all.first
        end

        it 'does not render template create' do
          post :create, params: { brand_id: brand, kite_name: attributes_for(:kite_name) }, format: :json
          expect(response).to_not render_template :create
        end

        it 'change kite_name count' do
          expect do
            post :create, params: { brand_id: brand, kite_name: attributes_for(:kite_name) }, format: :json
          end.to change(KiteName, :count).by(1)
        end
      end

      context "with invalid data can not create kite_name" do

        it "assigns brand" do
          post :create, params: { brand_id: brand, kite_name: attributes_for(:kite_name, :invalid) }, format: :json
          expect(assigns(:brand)).to eq brand
        end

        it "assigns kite_name" do
          post :create, params: { brand_id: brand, kite_name: attributes_for(:kite_name, :invalid) }, format: :json
          expect(assigns(:kite_name).valid?).to be_falsey
        end

        it 'does not change kite_name count' do
          expect do
            post :create, params: { brand_id: brand, kite_name: attributes_for(:kite_name, :invalid) }, format: :json
          end.to_not change(KiteName, :count)
        end
      end
    end

    context 'Authenticated user not admin' do
      let!(:brand) { create(:brand) }
      let(:user) { create(:user) }
      before { login(user) }

      it "assigns brand" do
        post :create, params: { brand_id: brand, kite_name: attributes_for(:kite_name) }, format: :json
        expect(assigns(:brand)).to eq brand
      end

      it "assigns kite_name" do
        post :create, params: { brand_id: brand, kite_name: attributes_for(:kite_name) }, format: :json
        expect(assigns(:kite_name)).to be_nil
      end

      it 'does not change kite_name count' do
        expect do
          post :create, params: { brand_id: brand, kite_name: attributes_for(:kite_name) }, format: :json
        end.to_not change(KiteName, :count)
      end

      it "return status :forbidden" do
        post :create, params: { brand_id: brand, kite_name: attributes_for(:kite_name) }, format: :json
        expect(response).to have_http_status :forbidden
      end
    end

    context 'Guest' do
      let!(:brand) { create(:brand) }

      it "assigns brand" do
        post :create, params: { brand_id: brand, kite_name: attributes_for(:kite_name) }, format: :json
        expect(assigns(:brand)).to be_nil
      end

      it "assigns kite_name" do
        post :create, params: { brand_id: brand, kite_name: attributes_for(:kite_name) }, format: :json
        expect(assigns(:kite_name)).to be_nil
      end

      it 'does not change kite_name count' do
        expect do
          post :create, params: { brand_id: brand, kite_name: attributes_for(:kite_name) }, format: :json
        end.to_not change(KiteName, :count)
      end

      it "return status unauthorized" do
        post :create, params: { brand_id: brand, kite_name: attributes_for(:kite_name) }, format: :json
        expect(response).to have_http_status :unauthorized
      end
    end
  end

  describe "GET #show" do
    let!(:kite_name) { create(:kite_name) }

    context 'Admin' do
      let(:admin_user) { create(:user, role: 'Admin') }
      before { login(admin_user) }

      it "render template show" do
        get :show, params: { id: kite_name }
        expect(response).to render_template :show
      end

      it "assigns kite_name" do
        get :show, params: { id: kite_name }
        expect(assigns(:kite_name)).to eq kite_name
      end
    end

    context 'Authenticated user not admin' do
      let(:user) { create(:user) }
      before { login(user) }

      it "redirect to root" do
        get :show, params: { id: kite_name }
        expect(response).to redirect_to root_path
      end

      it "assigns kite_name" do
        get :show, params: { id: kite_name }
        expect(assigns(:kite_name)).to eq kite_name
      end
    end

    context 'Guest' do

      it "redirect to log in" do
        get :show, params: { id: kite_name }
        expect(response).to redirect_to new_user_session_path
      end

      it "does not assigns kite_name" do
        get :show, params: { id: kite_name }
        expect(assigns(:kite_name)).to be_nil
      end
    end
  end

  describe "GET #edit" do
    let!(:kite_name) { create(:kite_name) }

    context 'Admin' do
      let(:admin_user) { create(:user, role: 'Admin') }
      before { login(admin_user) }

      it "render template edit" do
        get :edit, params: { id: kite_name }
        expect(response).to render_template :edit
      end

      it "assigns kite_name" do
        get :edit, params: { id: kite_name }
        expect(assigns(:kite_name)).to eq kite_name
      end
    end
    context 'Authenticated user not admin' do
      let(:user) { create(:user) }
      before { login(user) }

      it "redirect to root" do
        get :edit, params: { id: kite_name }
        expect(response).to redirect_to root_path
      end

      it "assigns kite_name" do
        get :edit, params: { id: kite_name }
        expect(assigns(:kite_name)).to eq kite_name
      end
    end
    context 'Guest' do

      it "redirect to log in" do
        get :edit, params: { id: kite_name }
        expect(response).to redirect_to new_user_session_path
      end

      it "assigns kite_name" do
        get :edit, params: { id: kite_name }
        expect(assigns(:kite_name)).to be_nil
      end
    end
  end

  describe "PATCH #update" do
    let!(:kite_name) { create(:kite_name) }

    context 'Admin' do
      context 'with valid data can update kite_name' do
        let(:admin_user) { create(:user, role: 'Admin') }
        before { login(admin_user) }

        it "change kite_name" do
          patch :update, params: { id: kite_name, kite_name: { name: 'New Kite Name' } }
          kite_name.reload
          expect(kite_name.name).to eq 'New Kite Name'
        end

        it "redirect to kite_name" do
          patch :update, params: { id: kite_name, kite_name: { name: 'New Kite Name' } }
          expect(response).to redirect_to kite_name
        end
      end
      context 'with invalid data can not update kite_name' do
        let(:admin_user) { create(:user, role: 'Admin') }
        before { login(admin_user) }

        it "does not change change kite_name" do
          patch :update, params: { id: kite_name, kite_name: { name: '' } }
          kite_name.reload
          expect(kite_name.name).to eq 'My Kite'
        end

        it "render template edit" do
          patch :update, params: { id: kite_name, kite_name: { name: '' } }
          expect(response).to render_template :edit
        end
      end
    end
    context 'Authenticated user not admin' do
      let(:user) { create(:user) }
      before { login(user) }

      it "does not change kite_name" do
        patch :update, params: { id: kite_name, kite_name: { name: 'New Kite Name' } }
        kite_name.reload
        expect(kite_name.name).to eq 'My Kite'
      end

      it "redirect to root" do
        patch :update, params: { id: kite_name, kite_name: { name: 'New Kite Name' } }
        expect(response).to redirect_to root_path
      end
    end
    context 'Guest' do
      it "does not change kite_name" do
        patch :update, params: { id: kite_name, kite_name: { name: 'New Kite Name' } }
        kite_name.reload
        expect(kite_name.name).to eq 'My Kite'
      end

      it "redirect to log in" do
        patch :update, params: { id: kite_name, kite_name: { name: 'New Kite Name' } }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:kite_name) { create(:kite_name) }

    context 'Admin' do
      let(:admin_user) { create(:user, role: 'Admin') }
      before { login(admin_user) }

      it 'assigns kite_name' do
        delete :destroy, params: { id: kite_name }, format: :js
        expect(assigns(:kite_name)).to eq kite_name
      end

      it 'change kite name count' do
        expect do
          delete :destroy, params: { id: kite_name }, format: :js
        end.to change(KiteName, :count).by(-1)
      end
    end

    context 'Authenticated user not admin' do
      let(:user) { create(:user) }
      before { login(user) }

      it 'return status redirect' do
        delete :destroy, params: { id: kite_name }
        expect(response).to have_http_status :redirect
      end

      it 'redirect to root' do
        delete :destroy, params: { id: kite_name }
        expect(response).to redirect_to root_path
      end

      it 'does not change kite name count' do
        expect do
          delete :destroy, params: { id: kite_name }
        end.to_not change(KiteName, :count)
      end
    end
    context 'Guest' do

      it 'does not change kite name count' do
        expect do
          delete :destroy, params: { id: kite_name }
        end.to_not change(KiteName, :count)
      end

      it 'redirect to log in' do
        delete :destroy, params: { id: kite_name }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
