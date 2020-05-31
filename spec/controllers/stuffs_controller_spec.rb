require 'rails_helper'

RSpec.describe StuffsController, type: :controller do
  let(:stuff_name) { create(:stuff_name) }
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

      it "assigns stuff is new" do
        expect(assigns(:stuff)).to be_a_new(Stuff)
      end
    end

    context 'Guest' do
      before { get :new, params: { stuff_name_id: stuff_name } }

      it "redirect to log in" do
        expect(response).to redirect_to new_user_session_path
      end

      it "assigns stuff is new" do
        expect(assigns(:stuff)).to be_nil
      end
    end

  end

  describe "POST #create" do
    context 'Authenticated user create stuff' do
      let!(:brand) { create(:brand, name: 'F-ONE') }
      let!(:stuff_name) { create(:stuff_name, brand: brand, name: 'Solo') }
      let(:user) { create(:user) }
      before { login(user) }

      context 'with valid data can create stuff' do

        it 'assigns stuff' do
          post :create, params: { stuff: attributes_for(:stuff, brand: "F-ONE", madel: "Solo") }, format: :json
          expect(assigns(:stuff)).to eq stuff_name.stuffs.first
        end

        it 'assigns stuff with new madel' do
          post :create, params: { stuff: attributes_for(:stuff, brand: "F-ONE", madel: "NEWSolo") }, format: :json
          expect(assigns(:stuff).stuff_name.name).to eq 'NEWSolo'
        end

        it 'assigns stuff with new brand and madel' do
          post :create, params: { stuff: attributes_for(:stuff, brand: "NEWF-ONE", madel: "NEWSolo") }, format: :json
          expect(assigns(:stuff).stuff_name.brand.name).to eq 'NEWF-ONE'
        end

        it 'change count stuff by 1' do
          expect do
            post :create, params: { stuff: attributes_for(:stuff, brand: "F-ONE", madel: "Solo") }, format: :json
          end.to change(Stuff, :count).by(1)
        end

        it 'return status ok' do
          post :create, params: { stuff: attributes_for(:stuff, brand: "F-ONE", madel: "Solo") }, format: :json
          expect(response).to have_http_status :ok
        end
      end

      it 'return status :unprocessable_entity' do
        post :create, params: { stuff_name_id: stuff_name, stuff: attributes_for(:stuff, brand: "", madel: "Solo") }, format: :json
        expect(response).to have_http_status :unprocessable_entity
      end

      context 'with invalid data cannot create stuff' do

        it 'stuff is not valid' do
          post :create, params: { stuff_name_id: stuff_name, stuff: attributes_for(:stuff, :invalid, brand: "F-ONE", madel: "Solo") }, format: :json
          expect(assigns(:stuff).year).to be_nil
        end

        it 'does not change stuffs' do
          expect do
            post :create, params: { stuff_name_id: stuff_name, stuff: attributes_for(:stuff, :invalid, brand: "F-ONE", madel: "Solo") }, format: :json
          end.to_not change(Stuff, :count)
        end

        it 'return status :unprocessable_entity' do
          post :create, params: { stuff_name_id: stuff_name, stuff: attributes_for(:stuff, :invalid, brand: "F-ONE", madel: "Solo") }, format: :json
          expect(response).to have_http_status :unprocessable_entity
        end
      end
    end

    context 'Guest' do

      it 'does not assigns stuff' do
        post :create, params: { stuff_name_id: stuff_name, stuff: attributes_for(:stuff, brand: "F-ONE", madel: "Solo") }, format: :json
        expect(assigns(:stuff)).to be_nil
      end

      it 'does not change count stuff by 1' do
        expect do
          post :create, params: { stuff_name_id: stuff_name, stuff: attributes_for(:stuff, brand: "F-ONE", madel: "Solo") }, format: :json
        end.to_not change(Stuff, :count)
      end

      it 'return status :unauthorized' do
        post :create, params: { stuff_name_id: stuff_name, stuff: attributes_for(:stuff, brand: "F-ONE", madel: "Solo") }, format: :json
        expect(response).to have_http_status :unauthorized
      end
    end
  end

  describe "GET #show" do
    context 'Authenticated user' do
      let(:owner_user) { create(:user) }
      let(:other_user) { create(:user, email: 'other_user@mail.com') }
      let(:stuff) { create(:stuff, user: owner_user) }

      context 'owner stuff' do
        before { login(owner_user) }

        it "render template show" do
          get :show, params: { id: stuff }
          expect(response).to render_template :show
        end

        it "assigns stuff" do
          get :show, params: { id: stuff }
          expect(assigns(:stuff)).to eq stuff
        end
      end

      context 'not owner stuff' do
        before { login(other_user) }

        it "render template show" do
          get :show, params: { id: stuff }
          expect(response).to render_template :show
        end

        it "assigns stuff" do
          get :show, params: { id: stuff }
          expect(assigns(:stuff)).to eq stuff
        end
      end
    end

    context 'Guest' do
      let(:stuff) { create(:stuff) }

      it "render template show" do
        get :show, params: { id: stuff }
        expect(response).to render_template :show
      end

      it "assigns stuff" do
        get :show, params: { id: stuff }
        expect(assigns(:stuff)).to eq stuff
      end
    end
  end

  describe 'GET #edit' do
    let(:owner_user) { create(:user) }
    let(:other_user) { create(:user, email: 'other@mail.com') }
    let(:stuff) { create(:stuff, user: owner_user) }

    context 'Authenticated user' do
      context 'owner' do
        before { login(owner_user) }

        it 'render template edit' do
          get :edit, params: { id: stuff, brand: "F-ONE", madel: "Solo" }, xhr: true
          expect(response).to render_template :edit
        end

        it 'assigns stuff' do
          get :edit, params: { id: stuff, brand: "F-ONE", madel: "Solo" }, xhr: true
          expect(assigns(:stuff)).to eq stuff
        end
      end
      context 'not owner' do
        before { login(other_user) }

        it 'return status :forbidden' do
          get :edit, params: { id: stuff, brand: "F-ONE", madel: "Solo" }, xhr: true
          expect(response).to have_http_status :forbidden
        end

        it 'assigns stuff' do
          get :edit, params: { id: stuff, brand: "F-ONE", madel: "Solo" }, xhr: true
          expect(assigns(:stuff)).to eq stuff
        end
      end
    end
    context 'Guest' do
      it 'assigns stuff is nil' do
        get :edit, params: { id: stuff, brand: "F-ONE", madel: "Solo" }, xhr: true
        expect(assigns(:stuff)).to be_nil
      end

      it 'redirect to log in' do
        get :edit, params: { id: stuff }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH #update' do
    let(:owner_user) { create(:user) }
    let(:other_user) { create(:user, email: 'other@mail.com') }
    let(:stuff) { create(:stuff, user: owner_user) }

    context 'Authenticated user' do
      context 'owner' do
        before { login(owner_user) }

        context 'with valid data can update stuff' do

          it 'assigns stuff' do
            patch :update, params: { id: stuff , stuff: { price: 8, brand: "F-ONE", madel: "Solo" } }, format: :json
            expect(assigns(:stuff)).to eq stuff
          end

          it 'change attributes' do
            patch :update, params: { id: stuff , stuff: { price: 8, brand: "F-ONE", madel: "Solo" } }, format: :json
            stuff.reload
            expect(stuff.price).to eq 8
          end

          it 'return status ok' do
            patch :update, params: { id: stuff , stuff: { price: 8, brand: "F-ONE", madel: "Solo" } }, format: :json
            expect(response).to have_http_status :ok
          end
        end
        context 'with invalid data can not update stuff' do

          it 'assigns stuff' do
            patch :update, params: { id: stuff , stuff: { price: '', brand: "F-ONE", madel: "Solo" } }, format: :json
            expect(assigns(:stuff)).to eq stuff
          end

          it 'does not change attributes' do
            patch :update, params: { id: stuff , stuff: { price: '', brand: "F-ONE", madel: "Solo" } }, format: :json
            expect(stuff.price).to eq Stuff.find(stuff.id).price
          end

          it 'return status :unprocessable_entity' do
            patch :update, params: { id: stuff , stuff: { price: '', brand: "F-ONE", madel: "Solo" } }, format: :json
            expect(response).to have_http_status :unprocessable_entity
          end
        end
      end
      context 'not owner' do
        before { login(other_user) }

        it 'does not assign stuff' do
          patch :update, params: { id: stuff , stuff: { price: 8, brand: "F-ONE", madel: "Solo" } }, format: :json
          expect(assigns(:stuff)).to eq stuff
        end

        it 'does not change attributes' do
          patch :update, params: { id: stuff , stuff: { price: 8, brand: "F-ONE", madel: "Solo" } }, format: :json
          expect(stuff.price).to eq Stuff.find(stuff.id).price
        end

        it 'return status :forbidden' do
          patch :update, params: { id: stuff , stuff: { price: 8, brand: "F-ONE", madel: "Solo" } }, format: :json
          expect(response).to have_http_status :forbidden
        end
      end
    end

    context 'Guest' do

      it 'does not assign stuff' do
        patch :update, params: { id: stuff , stuff: { price: 8, brand: "F-ONE", madel: "Solo" } }, format: :json
        expect(assigns(:stuff)).to be_nil
      end

      it 'does not change attributes' do
        patch :update, params: { id: stuff , stuff: { price: 8, brand: "F-ONE", madel: "Solo" } }, format: :json
        expect(stuff.price).to eq Stuff.find(stuff.id).price
      end

      it 'return status :unauthorized' do
        patch :update, params: { id: stuff , stuff: { price: 8, brand: "F-ONE", madel: "Solo" } }, format: :json
        expect(response).to have_http_status :unauthorized
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:owner_user) { create(:user) }
    let(:other_user) { create(:user, email: 'other@mail.com') }
    let!(:stuff) { create(:stuff, user: owner_user) }

    context 'Authenticated user' do

      context 'owner can delete stuff' do
        before { login(owner_user) }

        it 'assigns stuff' do
          delete :destroy, params: { id: stuff }, format: :js
          expect(assigns(:stuff)).to eq stuff
        end

        it 'change stuff count' do
          expect do
            delete :destroy, params: { id: stuff }, format: :js
          end.to change(Stuff, :count).by(-1)
        end

        it 'render template destroy' do
          delete :destroy, params: { id: stuff }, format: :js
          expect(response).to render_template :destroy
        end
      end

      context 'not owner can not delete stuff' do
        before { login(other_user) }

        it 'assigns kite' do
          delete :destroy, params: { id: stuff }
          expect(assigns(:stuff)).to eq stuff
        end

        it 'does not change stuff count' do
          expect do
            delete :destroy, params: { id: stuff }
          end.to_not change(Stuff, :count)
        end

        it 'redirect to root' do
          delete :destroy, params: { id: stuff }
          expect(response).to redirect_to root_path
        end
      end
    end
    context 'Guest' do
      context 'can not delete stuff' do

        it 'does not assigns stuff' do
          delete :destroy, params: { id: stuff }
          expect(assigns(:stuff)).to be_nil
        end

        it 'does not change stuff count' do
          expect do
            delete :destroy, params: { id: stuff }
          end.to_not change(Stuff, :count)
        end

        it 'redirect to log in' do
          delete :destroy, params: { id: stuff }
          expect(response).to redirect_to new_user_session_path
        end
      end
    end
  end
end
