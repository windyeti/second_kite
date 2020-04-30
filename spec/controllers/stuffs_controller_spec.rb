require 'rails_helper'

RSpec.describe StuffsController, type: :controller do
  describe 'GET #new' do
    context 'Authenticated user' do
      let(:stuff_name) { create(:stuff_name) }
      let(:user) { create(:user) }
      before { login(user) }

      it 'assigns new stuff' do
        get :new, params: { stuff_name_id: stuff_name }
        expect(assigns(:stuff)).to be_a_new Stuff
      end

      it 'assigns stuff_name' do
        get :new, params: { stuff_name_id: stuff_name }
        expect(assigns(:stuff_name)).to eq stuff_name
      end

      it 'render template new' do
        get :new, params: { stuff_name_id: stuff_name }
        expect(response).to render_template :new
      end
    end
    context 'Guest'
  end

  describe 'POST #create' do
    let(:stuff_name) { create(:stuff_name) }

    context 'Authenticated user' do
      let(:user) { create(:user) }
      before { login(user) }

      context 'can create stuff with valid data' do
        it 'assigns stuff_name' do
          post :create, params: { stuff_name_id: stuff_name, stuff: attributes_for(:stuff) }
          expect(assigns(:stuff_name)).to eq stuff_name
        end

        it 'assigns stuff' do
          post :create, params: { stuff_name_id: stuff_name, stuff: attributes_for(:stuff) }
          expect(assigns(:stuff)).to eq stuff_name.stuffs.first
        end

        it 'redirect to stuff' do
          post :create, params: { stuff_name_id: stuff_name, stuff: attributes_for(:stuff) }
          expect(response).to redirect_to stuff_name.stuffs.first
        end

        it 'change stuff count' do
          expect do
            post :create, params: { stuff_name_id: stuff_name, stuff: attributes_for(:stuff) }
          end.to change(Stuff, :count).by(1)
        end
      end

      context 'cannot create stuff with invalid data' do

        it 'assigns stuff_name' do
          post :create, params: { stuff_name_id: stuff_name, stuff: { price: '' } }
          expect(assigns(:stuff_name)).to eq stuff_name
        end

        it 'assigns stuff' do
          post :create, params: { stuff_name_id: stuff_name, stuff: { price: '' } }
          expect(assigns(:stuff).valid?).to be_falsey
        end

        it 'render template new' do
          post :create, params: { stuff_name_id: stuff_name, stuff: { price: '' } }
          expect(response).to render_template :new
        end

        it 'does not change stuff count' do
          expect do
            post :create, params: { stuff_name_id: stuff_name, stuff: { price: '' } }
          end.to_not change(Stuff, :count)
        end
      end
    end
    context 'Guest' do

      it 'assigns stuff_name' do
        post :create, params: { stuff_name_id: stuff_name, stuff: attributes_for(:stuff) }
        expect(assigns(:stuff_name)).to be_nil
      end

      it 'assigns stuff' do
        post :create, params: { stuff_name_id: stuff_name, stuff: attributes_for(:stuff) }
        expect(assigns(:stuff)).to be_nil
      end

      it 'redirect to log in' do
        post :create, params: { stuff_name_id: stuff_name, stuff: attributes_for(:stuff) }
        expect(response).to redirect_to new_user_session_path
      end

      it 'does not change stuff count' do
        expect do
          post :create, params: { stuff_name_id: stuff_name, stuff: attributes_for(:stuff) }
        end.to_not change(Stuff, :count)
      end
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user) }
    let(:stuff) { create(:stuff, user: user) }

    context 'Authenticated user' do
      before { login(user) }

      it 'assigns stuff' do
        get :show, params: { id: stuff }
        expect(assigns(:stuff)).to eq stuff
      end

      it 'render template show' do
        get :show, params: { id: stuff }
        expect(assigns(:stuff)).to render_template :show
      end
    end
    context 'Guest' do

      it 'assigns stuff' do
        get :show, params: { id: stuff }
        expect(assigns(:stuff)).to be_nil
      end

      it 'redirect to log in' do
        get :show, params: { id: stuff }
        expect(assigns(:stuff)).to redirect_to new_user_session_path
      end
    end
  end
end
