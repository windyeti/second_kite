# TODO Еще везде рассмотреть Admin
require 'rails_helper'

RSpec.describe KitesController, type: :controller do
  let(:kite_name) { create(:kite_name) }
  let(:user) { create(:user) }

  describe "GET #new" do
    context 'Authenticated user' do
      before do
        login(user)
        get :new, params: { kite_name_id: kite_name }
      end

      it "render template new" do
        expect(response).to render_template :new
      end

      it "assigns kite is new" do
        expect(assigns(:kite)).to be_a_new(Kite)
      end

      it "assigns kite_name" do
        expect(assigns(:kite_name)).to eq kite_name
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

      it "assigns kite_name" do
        expect(assigns(:kite_name)).to be_nil
      end
    end

  end

  describe "POST #create" do
    context 'Authenticated user create kite' do
      let(:user) { create(:user) }
      before { login(user) }

      context 'with valid data can create kite' do

        it 'assigns kite' do
          post :create, params: { kite_name_id: kite_name, kite: attributes_for(:kite) }
          expect(assigns(:kite)).to eq kite_name.kites.first
        end

        it 'assigns kite_name' do
          post :create, params: { kite_name_id: kite_name, kite: attributes_for(:kite) }
          expect(assigns(:kite_name)).to eq kite_name
        end

        it 'change count kites by 1' do
          expect do
            post :create, params: { kite_name_id: kite_name, kite: attributes_for(:kite) }
          end.to change(Kite, :count).by(1)
        end

        it 'redirect to kite' do
          post :create, params: { kite_name_id: kite_name, kite: attributes_for(:kite) }
          expect(response).to redirect_to assigns(:kite)
        end
      end

      context 'with invalid data can not create kite' do

        it 'kite is not valid' do
          post :create, params: { kite_name_id: kite_name, kite: attributes_for(:kite, :invalid) }
          expect(assigns(:kite).year).to be_nil
        end

        it 'assigns kite_name' do
          post :create, params: { kite_name_id: kite_name, kite: attributes_for(:kite, :invalid) }
          expect(assigns(:kite_name)).to eq kite_name
        end

        it 'does not change count kites' do
          expect do
            post :create, params: { kite_name_id: kite_name, kite: attributes_for(:kite, :invalid) }
          end.to_not change(Kite, :count)
        end

        it 'render template new' do
          post :create, params: { kite_name_id: kite_name, kite: attributes_for(:kite, :invalid) }
          expect(response).to render_template :new
        end
      end
    end

    context 'Guest' do

      it 'does not assigns kite' do
        post :create, params: { kite_name_id: kite_name, kite: attributes_for(:kite) }
        expect(assigns(:kite)).to be_nil
      end

      it 'does not assigns kite_name' do
        post :create, params: { kite_name_id: kite_name, kite: attributes_for(:kite) }
        expect(assigns(:kite_name)).to be_nil
      end

      it 'does not change count kites by 1' do
        expect do
          post :create, params: { kite_name_id: kite_name, kite: attributes_for(:kite) }
        end.to_not change(Kite, :count)
      end

      it 'redirect to log in' do
        post :create, params: { kite_name_id: kite_name, kite: attributes_for(:kite) }
        expect(response).to redirect_to new_user_session_path
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

        it "redirect to root" do
          get :show, params: { id: kite }
          expect(response).to redirect_to root_path
        end

        it "assigns kite" do
          get :show, params: { id: kite }
          expect(assigns(:kite)).to eq kite
        end
      end
    end

    context 'Guest' do
      let(:kite) { create(:kite) }

      it "redirect to log in" do
        get :show, params: { id: kite }
        expect(response).to redirect_to new_user_session_path
      end

      it "does not assigns kite" do
        get :show, params: { id: kite }
        expect(assigns(:kite)).to be_nil
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
          get :edit, params: { id: kite }
          expect(response).to render_template :edit
        end

        it 'assigns kite' do
          get :edit, params: { id: kite }
          expect(assigns(:kite)).to eq kite
        end
      end
      context 'not owner' do
        before { login(other_user) }

        it 'redirect to root' do
          get :edit, params: { id: kite }
          expect(response).to redirect_to root_path
        end

        it 'assigns kite' do
          get :edit, params: { id: kite }
          expect(assigns(:kite)).to eq kite
        end
      end
    end
    context 'Guest' do
      it 'assigns kite is nil' do
        get :edit, params: { id: kite }
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
            patch :update, params: { id: kite , kite: { size: 8 } }
            expect(assigns(:kite)).to eq kite
          end

          it 'change attributes' do
            patch :update, params: { id: kite , kite: { size: 8 } }
            kite.reload
            expect(kite.size).to eq 8
          end

          it 'redirect to kite' do
            patch :update, params: { id: kite , kite: { size: 8 } }
            expect(response).to redirect_to kite
          end
        end
        context 'with invalid data can not update kite' do

          it 'assigns kite' do
            patch :update, params: { id: kite , kite: { size: '' } }
            expect(assigns(:kite)).to eq kite
          end

          it 'does not change attributes' do
            patch :update, params: { id: kite , kite: { size: '' } }
            expect(kite.size).to eq Kite.find(kite.id).size
          end

          it 'render template edit' do
            patch :update, params: { id: kite , kite: { size: '' } }
            expect(response).to render_template :edit
          end
        end
      end
      context 'not owner' do
        before { login(other_user) }

        it 'does not assign kite' do
          patch :update, params: { id: kite , kite: { size: 8 } }
          expect(assigns(:kite)).to eq kite
        end

        it 'does not change attributes' do
          patch :update, params: { id: kite , kite: { size: 8 } }
          expect(kite.size).to eq Kite.find(kite.id).size
        end

        it 'rdirect to root' do
          patch :update, params: { id: kite , kite: { size: 8 } }
          expect(response).to redirect_to root_path
        end
      end
    end

    context 'Guest' do

      it 'does not assign kite' do
        patch :update, params: { id: kite , kite: { size: 8 } }
        expect(assigns(:kite)).to be_nil
      end

      it 'does not change attributes' do
        patch :update, params: { id: kite , kite: { size: 8 } }
        expect(kite.size).to eq Kite.find(kite.id).size
      end

      it 'rdirect to log in' do
        patch :update, params: { id: kite , kite: { size: 8 } }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

end
