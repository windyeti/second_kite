require 'rails_helper'

RSpec.describe BarsController, type: :controller do
  let(:bar_name) { create(:bar_name) }
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

      it "assigns bar is new" do
        expect(assigns(:bar)).to be_a_new(Bar)
      end
    end

    context 'Guest' do
      before { get :new, params: { bar_name_id: bar_name } }

      it "redirect to log in" do
        expect(response).to redirect_to new_user_session_path
      end

      it "assigns bar is new" do
        expect(assigns(:bar)).to be_nil
      end
    end

  end

  describe "POST #create" do
    context 'Authenticated user create kite' do
      let!(:brand) { create(:brand, name: 'F-ONE') }
      let!(:bar_name) { create(:bar_name, brand: brand, name: 'Solo') }
      let(:user) { create(:user) }
      before { login(user) }

      context 'with valid data can create bar' do

        it 'assigns bar' do
          post :create, params: { bar: attributes_for(:bar, brand: "F-ONE", madel: "Solo") }, format: :json
          expect(assigns(:bar)).to eq bar_name.bars.first
        end

        it 'assigns bar with new madel' do
          post :create, params: { bar: attributes_for(:bar, brand: "F-ONE", madel: "NEWSolo") }, format: :json
          expect(assigns(:bar).bar_name.name).to eq 'NEWSolo'
        end

        it 'assigns bar with new brand and madel' do
          post :create, params: { bar: attributes_for(:bar, brand: "NEWF-ONE", madel: "NEWSolo") }, format: :json
          expect(assigns(:bar).bar_name.brand.name).to eq 'NEWF-ONE'
        end

        it 'change count bars by 1' do
          expect do
            post :create, params: { bar: attributes_for(:bar, brand: "F-ONE", madel: "Solo") }, format: :json
          end.to change(Bar, :count).by(1)
        end

        it 'return status ok' do
          post :create, params: { bar: attributes_for(:bar, brand: "F-ONE", madel: "Solo") }, format: :json
          expect(response).to have_http_status :ok
        end
      end

      it 'return status :unprocessable_entity' do
        post :create, params: { bar_name_id: bar_name, bar: attributes_for(:bar, brand: "", madel: "Solo") }, format: :json
        expect(response).to have_http_status :unprocessable_entity
      end

      context 'with invalid data cannot create bar' do

        it 'bar is not valid' do
          post :create, params: { bar_name_id: bar_name, bar: attributes_for(:bar, :invalid, brand: "F-ONE", madel: "Solo") }, format: :json
          expect(assigns(:bar).year).to be_nil
        end

        it 'does not change count bars' do
          expect do
            post :create, params: { bar_name_id: bar_name, bar: attributes_for(:bar, :invalid, brand: "F-ONE", madel: "Solo") }, format: :json
          end.to_not change(Bar, :count)
        end

        it 'return status :unprocessable_entity' do
          post :create, params: { bar_name_id: bar_name, bar: attributes_for(:bar, :invalid, brand: "F-ONE", madel: "Solo") }, format: :json
          expect(response).to have_http_status :unprocessable_entity
        end
      end
    end

    context 'Guest' do

      it 'does not assigns bar' do
        post :create, params: { bar_name_id: bar_name, bar: attributes_for(:bar, brand: "F-ONE", madel: "Solo") }, format: :json
        expect(assigns(:bar)).to be_nil
      end

      it 'does not change count bars by 1' do
        expect do
          post :create, params: { bar_name_id: bar_name, bar: attributes_for(:bar, brand: "F-ONE", madel: "Solo") }, format: :json
        end.to_not change(Bar, :count)
      end

      it 'return status :unauthorized' do
        post :create, params: { bar_name_id: bar_name, bar: attributes_for(:bar, brand: "F-ONE", madel: "Solo") }, format: :json
        expect(response).to have_http_status :unauthorized
      end
    end
  end

  describe "GET #show" do
    context 'Authenticated user' do
      let(:owner_user) { create(:user) }
      let(:other_user) { create(:user, email: 'other_user@mail.com') }
      let(:bar) { create(:bar, user: owner_user) }

      context 'owner bar' do
        before { login(owner_user) }

        it "render template show" do
          get :show, params: { id: bar }
          expect(response).to render_template :show
        end

        it "assigns bar" do
          get :show, params: { id: bar }
          expect(assigns(:bar)).to eq bar
        end
      end

      context 'not owner bar' do
        before { login(other_user) }

        it "render template show" do
          get :show, params: { id: bar }
          expect(response).to render_template :show
        end

        it "assigns bar" do
          get :show, params: { id: bar }
          expect(assigns(:bar)).to eq bar
        end
      end
    end

    context 'Guest' do
      let(:bar) { create(:bar) }

      it "render template show" do
        get :show, params: { id: bar }
        expect(response).to render_template :show
      end

      it "assigns bar" do
        get :show, params: { id: bar }
        expect(assigns(:bar)).to eq bar
      end
    end
  end

  describe 'GET #edit' do
    let(:owner_user) { create(:user) }
    let(:other_user) { create(:user, email: 'other@mail.com') }
    let(:bar) { create(:bar, user: owner_user) }

    context 'Authenticated user' do
      context 'owner' do
        before { login(owner_user) }

        it 'render template edit' do
          get :edit, params: { id: bar, brand: "F-ONE", madel: "Solo" }, xhr: true
          expect(response).to render_template :edit
        end

        it 'assigns bar' do
          get :edit, params: { id: bar, brand: "F-ONE", madel: "Solo" }, xhr: true
          expect(assigns(:bar)).to eq bar
        end
      end
      context 'not owner' do
        before { login(other_user) }

        it 'return status :forbidden' do
          get :edit, params: { id: bar, brand: "F-ONE", madel: "Solo" }, xhr: true
          expect(response).to have_http_status :forbidden
        end

        it 'assigns bar' do
          get :edit, params: { id: bar, brand: "F-ONE", madel: "Solo" }, xhr: true
          expect(assigns(:bar)).to eq bar
        end
      end
    end
    context 'Guest' do
      it 'assigns bar is nil' do
        get :edit, params: { id: bar, brand: "F-ONE", madel: "Solo" }, xhr: true
        expect(assigns(:bar)).to be_nil
      end

      it 'redirect to log in' do
        get :edit, params: { id: bar }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH #update' do
    let(:owner_user) { create(:user) }
    let(:other_user) { create(:user, email: 'other@mail.com') }
    let(:bar) { create(:bar, user: owner_user) }

    context 'Authenticated user' do
      context 'owner' do
        before { login(owner_user) }

        context 'with valid data can update bar' do

          it 'assigns bar' do
            patch :update, params: { id: bar , bar: { length: 8, brand: "F-ONE", madel: "Solo" } }, format: :json
            expect(assigns(:bar)).to eq bar
          end

          it 'change attributes' do
            patch :update, params: { id: bar , bar: { length: 8, brand: "F-ONE", madel: "Solo" } }, format: :json
            bar.reload
            expect(bar.length).to eq 8
          end

          it 'return status ok' do
            patch :update, params: { id: bar , bar: { length: 8, brand: "F-ONE", madel: "Solo" } }, format: :json
            expect(response).to have_http_status :ok
          end
        end
        context 'with invalid data can not update bar' do

          it 'assigns bar' do
            patch :update, params: { id: bar , bar: { length: '', brand: "F-ONE", madel: "Solo" } }, format: :json
            expect(assigns(:bar)).to eq bar
          end

          it 'does not change attributes' do
            patch :update, params: { id: bar , bar: { length: '', brand: "F-ONE", madel: "Solo" } }, format: :json
            expect(bar.length).to eq Bar.find(bar.id).length
          end

          it 'return status :unprocessable_entity' do
            patch :update, params: { id: bar , bar: { length: '', brand: "F-ONE", madel: "Solo" } }, format: :json
            expect(response).to have_http_status :unprocessable_entity
          end
        end
      end
      context 'not owner' do
        before { login(other_user) }

        it 'does not assign bar' do
          patch :update, params: { id: bar , bar: { length: 8, brand: "F-ONE", madel: "Solo" } }, format: :json
          expect(assigns(:bar)).to eq bar
        end

        it 'does not change attributes' do
          patch :update, params: { id: bar , bar: { length: 8, brand: "F-ONE", madel: "Solo" } }, format: :json
          expect(bar.length).to eq Bar.find(bar.id).length
        end

        it 'return status :forbidden' do
          patch :update, params: { id: bar , bar: { length: 8, brand: "F-ONE", madel: "Solo" } }, format: :json
          expect(response).to have_http_status :forbidden
        end
      end
    end

    context 'Guest' do

      it 'does not assign bar' do
        patch :update, params: { id: bar , bar: { length: 8, brand: "F-ONE", madel: "Solo" } }, format: :json
        expect(assigns(:bar)).to be_nil
      end

      it 'does not change attributes' do
        patch :update, params: { id: bar , bar: { length: 8, brand: "F-ONE", madel: "Solo" } }, format: :json
        expect(bar.length).to eq Bar.find(bar.id).length
      end

      it 'return status :unauthorized' do
        patch :update, params: { id: bar , bar: { length: 8, brand: "F-ONE", madel: "Solo" } }, format: :json
        expect(response).to have_http_status :unauthorized
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:owner_user) { create(:user) }
    let(:other_user) { create(:user, email: 'other@mail.com') }
    let!(:bar) { create(:bar, user: owner_user) }

    context 'Authenticated user' do

      context 'owner can delete bar' do
        before { login(owner_user) }

        it 'assigns bar' do
          delete :destroy, params: { id: bar }, format: :js
          expect(assigns(:bar)).to eq bar
        end

        it 'change bar count' do
          expect do
            delete :destroy, params: { id: bar }, format: :js
          end.to change(Bar, :count).by(-1)
        end

        it 'render template destroy' do
          delete :destroy, params: { id: bar }, format: :js
          expect(response).to render_template :destroy
        end
      end

      context 'not owner can not delete bar' do
        before { login(other_user) }

        it 'assigns bar' do
          delete :destroy, params: { id: bar }
          expect(assigns(:bar)).to eq bar
        end

        it 'does not change bar count' do
          expect do
            delete :destroy, params: { id: bar }
          end.to_not change(Bar, :count)
        end

        it 'redirect to root' do
          delete :destroy, params: { id: bar }
          expect(response).to redirect_to root_path
        end
      end
    end
    context 'Guest' do
      context 'can not delete bar' do

        it 'does not assigns bar' do
          delete :destroy, params: { id: bar }
          expect(assigns(:bar)).to be_nil
        end

        it 'does not change bar count' do
          expect do
            delete :destroy, params: { id: bar }
          end.to_not change(Bar, :count)
        end

        it 'redirect to log in' do
          delete :destroy, params: { id: bar }
          expect(response).to redirect_to new_user_session_path
        end
      end
    end
  end
end
