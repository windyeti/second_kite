require 'rails_helper'

RSpec.describe BarsController, type: :controller do
  describe 'GET #new' do
    let(:bar_name) { create(:bar_name) }

    context 'Authenticated user' do
      let(:user) { create(:user) }
      before { login(user) }

      it 'assigns new' do
        get :new, params: { bar_name_id: bar_name }
        expect(assigns(:bar)).to be_a_new Bar
      end
      it 'assigns bar_name' do
        get :new, params: { bar_name_id: bar_name }
        expect(assigns(:bar_name)).to eq bar_name
      end
      it 'render template new' do
        get :new, params: { bar_name_id: bar_name }
        expect(assigns(:bar_name)).to render_template :new
      end
    end
    context 'Guest' do

      it 'does not assigns new' do
        get :new, params: { bar_name_id: bar_name }
        expect(assigns(:bar)).to be_nil
      end
      it 'assigns bar_name' do
        get :new, params: { bar_name_id: bar_name }
        expect(assigns(:bar_name)).to be_nil
      end
      it 'redicert to log in' do
        get :new, params: { bar_name_id: bar_name }
        expect(assigns(:bar_name)).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST #create' do
    let(:bar_name) { create(:bar_name) }

    context 'Authenticated user' do
      let(:user) { create(:user) }
      before { login(user) }

      context 'can create bar with valid data' do

        it 'assigns bar_name' do
          post :create, params: { bar_name_id: bar_name, bar: attributes_for(:bar) }
          expect(assigns(:bar_name)).to eq bar_name
        end

        it 'assigns bar' do
          post :create, params: { bar_name_id: bar_name, bar: attributes_for(:bar) }
          expect(assigns(:bar)).to eq bar_name.bars.first
        end

        it 'change bar count' do
          expect do
            post :create, params: { bar_name_id: bar_name, bar: attributes_for(:bar) }
          end.to change(Bar, :count).by(1)
        end

        it 'redirect to bar' do
          post :create, params: { bar_name_id: bar_name, bar: attributes_for(:bar) }
          expect(response).to redirect_to assigns(:bar)
        end
      end
      context 'can not create bar with invalid data' do

        it 'assigns bar_name' do
          post :create, params: { bar_name_id: bar_name, bar: attributes_for(:bar, length: '') }
          expect(assigns(:bar_name)).to eq bar_name
        end

        it 'assigns bar' do
          post :create, params: { bar_name_id: bar_name, bar: attributes_for(:bar, length: '') }
          expect(assigns(:bar).valid?).to be_falsey
        end

        it 'does not change bar count' do
          expect do
            post :create, params: { bar_name_id: bar_name, bar: attributes_for(:bar, length: '') }
          end.to_not change(Bar, :count)
        end

        it 'render template new' do
          post :create, params: { bar_name_id: bar_name, bar: attributes_for(:bar, length: '') }
          expect(response).to render_template :new
        end
      end
    end
    context 'Guest' do

      it 'assigns bar_name' do
        post :create, params: { bar_name_id: bar_name, bar: attributes_for(:bar) }
        expect(assigns(:bar_name)).to be_nil
      end

      it 'assigns bar' do
        post :create, params: { bar_name_id: bar_name, bar: attributes_for(:bar) }
        expect(assigns(:bar)).to be_nil
      end

      it 'does not change bar count' do
        expect do
          post :create, params: { bar_name_id: bar_name, bar: attributes_for(:bar) }
        end.to_not change(Bar, :count)
      end

      it 'redirect to log in' do
        post :create, params: { bar_name_id: bar_name, bar: attributes_for(:bar) }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user) }
    let(:bar) { create(:bar, user: user) }

    context 'Authenticated user' do
      before { login(user) }

      context 'owner' do

        it 'assigns bar' do
          get :show, params: { id: bar }
          expect(assigns(:bar)).to eq bar
        end
        it 'render template show' do
          get :show, params: { id: bar }
          expect(response).to render_template :show
        end
      end
      context 'not owner' do

        it 'assigns bar' do
          get :show, params: { id: bar }
          expect(assigns(:bar)).to eq bar
        end
        it 'render template show' do
          get :show, params: { id: bar }
          expect(response).to render_template :show
        end
      end
    end

    context 'Guest' do

      it 'assigns bar' do
        get :show, params: { id: bar }
        expect(assigns(:bar)).to eq bar
      end
      it 'render template show' do
        get :show, params: { id: bar }
        expect(response).to render_template :show
      end
    end
  end

  describe 'GET #edit' do
    let(:user) { create(:user) }
    let(:bar) { create(:bar, user: user) }

    context 'Authenticated user' do
      before { login(user) }

      it 'assigns bar' do
        get :edit, params: { id: bar }
        expect(assigns(:bar)).to eq bar
      end

      it 'render template edit' do
        get :edit, params: { id: bar }
        expect(response).to render_template :edit
      end
    end

    context 'Guest' do

      it 'assigns bar' do
        get :edit, params: { id: bar }
        expect(assigns(:bar)).to be_nil
      end

      it 'redirect to log in' do
        get :edit, params: { id: bar }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH #update' do
    let(:user) { create(:user) }
    let!(:bar) { create(:bar, user: user) }

    context 'Authenticated user' do
      before { login(user) }

      context 'with valid data can update bar' do
        it 'assigns bar' do
          patch :update, params: { id: bar, bar: { price: 123 } }
          expect(assigns(:bar)).to eq bar
        end

        it 'redirect to bar' do
          patch :update, params: { id: bar, bar: { price: 123 } }
          expect(assigns(:bar)).to redirect_to :bar
        end

        it 'change bar price' do
          expect do
            patch :update, params: { id: bar, bar: { price: 123 } }
            bar.reload
          end.to change(bar, :price)
        end
      end

      context 'with invalid data can not update bar' do

        it 'assigns bar' do
          patch :update, params: { id: bar, bar: { price: '' } }
          expect(assigns(:bar).valid?).to be_falsey
        end

        it 'render tamplate edit' do
          patch :update, params: { id: bar, bar: { price: '' } }
          expect(assigns(:bar)).to render_template :edit
        end

        it 'does not change bar price' do
          expect do
            patch :update, params: { id: bar, bar: { price: '' } }
            bar.reload
          end.to_not change(bar, :price)
        end
      end
    end
    context 'Guest' do

      it 'assigns bar' do
        patch :update, params: { id: bar, bar: { price: 123 } }
        expect(assigns(:bar)).to be_nil
      end

      it 'redirect to log in' do
        patch :update, params: { id: bar, bar: { price: 123 } }
        expect(assigns(:bar)).to redirect_to new_user_session_path
      end

      it 'does not change bar price' do
        expect do
          patch :update, params: { id: bar, bar: { price: 123 } }
          bar.reload
        end.to_not change(bar, :price)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:other_user) { create(:user, email: 'other@mail.com') }
    let(:user) { create(:user) }
    let!(:bar) { create(:bar, user: user) }

    context 'Authenticated user' do
      before { login(user) }

      context 'owner' do

        it 'assigns bar' do
          delete :destroy, params: { id: bar }, format: :js
          expect(assigns(:bar)).to eq bar
        end

        it 'assigns bar' do
          expect do
            delete :destroy, params: { id: bar }, format: :js
          end.to change(Bar, :count).by(-1)
        end

        it 'render template destroy' do
          delete :destroy, params: { id: bar }, format: :js
          expect(assigns(:bar)).to render_template :destroy
        end
      end
      context 'not owner' do
        before { login(other_user) }

        it 'assigns bar' do
          delete :destroy, params: { id: bar }, format: :js
          expect(assigns(:bar)).to eq bar
        end

        it 'does not assigns bar' do
          expect do
            delete :destroy, params: { id: bar }, format: :js
          end.to_not change(Bar, :count)
        end

        it 'return status forbidden' do
          delete :destroy, params: { id: bar }, format: :js
          expect(response).to have_http_status :forbidden
        end
      end
    end
    context 'Guest' do

      it 'does not assigns bar' do
        delete :destroy, params: { id: bar }, format: :js
        expect(assigns(:bar)).to be_nil
      end

      it 'does not assigns bar' do
        expect do
          delete :destroy, params: { id: bar }, format: :js
        end.to_not change(Bar, :count)
      end

      it 'return status unauthorized' do
        delete :destroy, params: { id: bar }, format: :js
        expect(response).to have_http_status :unauthorized
      end
    end
  end
end
