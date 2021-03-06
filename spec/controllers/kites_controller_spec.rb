require 'rails_helper'

RSpec.describe KitesController, type: :controller do
  let(:kite_name) { create(:kite_name) }
  let(:user) { create(:user) }

  describe "GET #new" do
    context 'Authenticated user' do
      before do
        login(user)
        get :new, xhr: true
      end

      it "render template new" do
        expect(response).to render_template :new
      end

      it "assigns kite is new" do
        expect(assigns(:kite)).to be_a_new(Kite)
      end
    end

    context 'Guest' do
      before { get :new, params: { kite_name_id: kite_name } }

      it "redirect to log in" do
        expect(response).to redirect_to new_user_session_path
      end

      it "assigns kite is new" do
        expect(assigns(:kite)).to be_nil
      end
    end

  end

  describe "POST #create" do
    context 'Authenticated user create kite' do
      let!(:brand) { create(:brand, name: 'F-ONE') }
      let!(:kite_name) { create(:kite_name, brand: brand, name: 'Solo') }
      let(:user) { create(:user) }
      before { login(user) }

      context 'with valid data can create kite' do

        it 'assigns kite' do
          post :create, params: { kite: attributes_for(:kite, brand: "F-ONE", madel: "Solo") }, format: :json
          expect(assigns(:kite)).to eq kite_name.kites.first
        end

        it 'assigns kite with new madel' do
          post :create, params: { kite: attributes_for(:kite, brand: "F-ONE", madel: "NEWSolo") }, format: :json
          expect(assigns(:kite).kite_name.name).to eq 'NEWSolo'
        end

        it 'assigns kite with new brand and madel' do
          post :create, params: { kite: attributes_for(:kite, brand: "NEWF-ONE", madel: "NEWSolo") }, format: :json
          expect(assigns(:kite).kite_name.brand.name).to eq 'NEWF-ONE'
        end

        it 'change count kites by 1' do
          expect do
            post :create, params: { kite: attributes_for(:kite, brand: "F-ONE", madel: "Solo") }, format: :json
          end.to change(Kite, :count).by(1)
        end

        it 'return status ok' do
          post :create, params: { kite: attributes_for(:kite, brand: "F-ONE", madel: "Solo") }, format: :json
          expect(response).to have_http_status :ok
        end
      end

      it 'return status :unprocessable_entity' do
        post :create, params: { kite_name_id: kite_name, kite: attributes_for(:kite, brand: "", madel: "Solo") }, format: :json
        expect(response).to have_http_status :unprocessable_entity
      end

      context 'with invalid data cannot create kite' do

        it 'kite is not valid' do
          post :create, params: { kite_name_id: kite_name, kite: attributes_for(:kite, :invalid, brand: "F-ONE", madel: "Solo") }, format: :json
          expect(assigns(:kite).year).to be_nil
        end

        it 'does not change count kites' do
          expect do
            post :create, params: { kite_name_id: kite_name, kite: attributes_for(:kite, :invalid, brand: "F-ONE", madel: "Solo") }, format: :json
          end.to_not change(Kite, :count)
        end

        it 'return status :unprocessable_entity' do
          post :create, params: { kite_name_id: kite_name, kite: attributes_for(:kite, :invalid, brand: "F-ONE", madel: "Solo") }, format: :json
          expect(response).to have_http_status :unprocessable_entity
        end
      end
    end

    context 'Guest' do

      it 'does not assigns kite' do
        post :create, params: { kite_name_id: kite_name, kite: attributes_for(:kite, brand: "F-ONE", madel: "Solo") }, format: :json
        expect(assigns(:kite)).to be_nil
      end

      it 'does not change count kites by 1' do
        expect do
          post :create, params: { kite_name_id: kite_name, kite: attributes_for(:kite, brand: "F-ONE", madel: "Solo") }, format: :json
        end.to_not change(Kite, :count)
      end

      it 'return status :unauthorized' do
        post :create, params: { kite_name_id: kite_name, kite: attributes_for(:kite, brand: "F-ONE", madel: "Solo") }, format: :json
        expect(response).to have_http_status :unauthorized
      end
    end
  end

  describe "GET #show" do
    context 'Authenticated user' do
      let(:owner_user) { create(:user) }
      let(:other_user) { create(:user, email: 'other_user@mail.com') }
      let(:kite) { create(:kite, user: owner_user) }

      context 'owner kite' do
        before { login(owner_user) }

        it "render template show" do
          get :show, params: { id: kite }
          expect(response).to render_template :show
        end

        it "assigns kite" do
          get :show, params: { id: kite }
          expect(assigns(:kite)).to eq kite
        end
      end

      context 'not owner kite' do
        before { login(other_user) }

        it "render template show" do
          get :show, params: { id: kite }
          expect(response).to render_template :show
        end

        it "assigns kite" do
          get :show, params: { id: kite }
          expect(assigns(:kite)).to eq kite
        end
      end
    end

    context 'Guest' do
      let(:kite) { create(:kite) }

      it "render template show" do
        get :show, params: { id: kite }
        expect(response).to render_template :show
      end

      it "assigns kite" do
        get :show, params: { id: kite }
        expect(assigns(:kite)).to eq kite
      end
    end
  end

  describe 'GET #edit' do
    let(:owner_user) { create(:user) }
    let(:other_user) { create(:user, email: 'other@mail.com') }
    let(:kite) { create(:kite, user: owner_user) }

    context 'Authenticated user' do
      context 'owner' do
        before { login(owner_user) }

        it 'render template edit' do
          get :edit, params: { id: kite, brand: "F-ONE", madel: "Solo" }, xhr: true
          expect(response).to render_template :edit
        end

        it 'assigns kite' do
          get :edit, params: { id: kite, brand: "F-ONE", madel: "Solo" }, xhr: true
          expect(assigns(:kite)).to eq kite
        end
      end
      context 'not owner' do
        before { login(other_user) }

        it 'return status :forbidden' do
          get :edit, params: { id: kite, brand: "F-ONE", madel: "Solo" }, xhr: true
          expect(response).to have_http_status :forbidden
        end

        it 'assigns kite' do
          get :edit, params: { id: kite, brand: "F-ONE", madel: "Solo" }, xhr: true
          expect(assigns(:kite)).to eq kite
        end
      end
    end
    context 'Guest' do
      it 'assigns kite is nil' do
        get :edit, params: { id: kite, brand: "F-ONE", madel: "Solo" }, xhr: true
        expect(assigns(:kite)).to be_nil
      end

      it 'redirect to log in' do
        get :edit, params: { id: kite }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH #update' do
    let(:owner_user) { create(:user) }
    let(:other_user) { create(:user, email: 'other@mail.com') }
    let(:kite) { create(:kite, user: owner_user) }

    context 'Authenticated user' do
      context 'owner' do
        before { login(owner_user) }

        context 'with valid data can update kite' do

          it 'assigns kite' do
            patch :update, params: { id: kite , kite: { size: 8, brand: "F-ONE", madel: "Solo" } }, format: :json
            expect(assigns(:kite)).to eq kite
          end

          it 'change attributes' do
            patch :update, params: { id: kite , kite: { size: 8, brand: "F-ONE", madel: "Solo" } }, format: :json
            kite.reload
            expect(kite.size).to eq 8
          end

          it 'return status ok' do
            patch :update, params: { id: kite , kite: { size: 8, brand: "F-ONE", madel: "Solo" } }, format: :json
            expect(response).to have_http_status :ok
          end
        end
        context 'with invalid data can not update kite' do

          it 'assigns kite' do
            patch :update, params: { id: kite , kite: { size: '', brand: "F-ONE", madel: "Solo" } }, format: :json
            expect(assigns(:kite)).to eq kite
          end

          it 'does not change attributes' do
            patch :update, params: { id: kite , kite: { size: '', brand: "F-ONE", madel: "Solo" } }, format: :json
            expect(kite.size).to eq Kite.find(kite.id).size
          end

          it 'return status :unprocessable_entity' do
            patch :update, params: { id: kite , kite: { size: '', brand: "F-ONE", madel: "Solo" } }, format: :json
            expect(response).to have_http_status :unprocessable_entity
          end

          it 'return status :unprocessable_entity' do
            patch :update, params: { id: kite , kite: { size: '10', brand: "", madel: "Solo" } }, format: :json
            expect(response).to have_http_status :unprocessable_entity
          end
        end
      end
      context 'not owner' do
        before { login(other_user) }

        it 'does not assign kite' do
          patch :update, params: { id: kite , kite: { size: 8, brand: "F-ONE", madel: "Solo" } }, format: :json
          expect(assigns(:kite)).to eq kite
        end

        it 'does not change attributes' do
          patch :update, params: { id: kite , kite: { size: 8, brand: "F-ONE", madel: "Solo" } }, format: :json
          expect(kite.size).to eq Kite.find(kite.id).size
        end

        it 'return status :forbidden' do
          patch :update, params: { id: kite , kite: { size: 8, brand: "F-ONE", madel: "Solo" } }, format: :json
          expect(response).to have_http_status :forbidden
        end
      end
    end

    context 'Guest' do

      it 'does not assign kite' do
        patch :update, params: { id: kite , kite: { size: 8, brand: "F-ONE", madel: "Solo" } }, format: :json
        expect(assigns(:kite)).to be_nil
      end

      it 'does not change attributes' do
        patch :update, params: { id: kite , kite: { size: 8, brand: "F-ONE", madel: "Solo" } }, format: :json
        expect(kite.size).to eq Kite.find(kite.id).size
      end

      it 'return status :unauthorized' do
        patch :update, params: { id: kite , kite: { size: 8, brand: "F-ONE", madel: "Solo" } }, format: :json
        expect(response).to have_http_status :unauthorized
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:owner_user) { create(:user) }
    let(:other_user) { create(:user, email: 'other@mail.com') }
    let!(:kite) { create(:kite, user: owner_user) }

    context 'Authenticated user' do

      context 'owner can delete kite' do
        before { login(owner_user) }

        it 'assigns kite' do
          delete :destroy, params: { id: kite }, format: :js
          expect(assigns(:kite)).to eq kite
        end

        it 'change kite count' do
          expect do
            delete :destroy, params: { id: kite }, format: :js
          end.to change(Kite, :count).by(-1)
        end

        it 'render template destroy' do
          delete :destroy, params: { id: kite }, format: :js
          expect(response).to render_template :destroy
        end
      end

      context 'not owner can not delete kite' do
        before { login(other_user) }

        it 'assigns kite' do
          delete :destroy, params: { id: kite }
          expect(assigns(:kite)).to eq kite
        end

        it 'does not change kite count' do
          expect do
            delete :destroy, params: { id: kite }
          end.to_not change(Kite, :count)
        end

        it 'redirect to root' do
          delete :destroy, params: { id: kite }
          expect(response).to redirect_to root_path
        end
      end
    end
    context 'Guest' do
      context 'can not delete kite' do

        it 'does not assigns kite' do
          delete :destroy, params: { id: kite }
          expect(assigns(:kite)).to be_nil
        end

        it 'does not change kite count' do
          expect do
            delete :destroy, params: { id: kite }
          end.to_not change(Kite, :count)
        end

        it 'redirect to log in' do
          delete :destroy, params: { id: kite }
          expect(response).to redirect_to new_user_session_path
        end
      end
    end
  end

end
