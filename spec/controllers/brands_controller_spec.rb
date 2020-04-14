require 'rails_helper'

RSpec.describe BrandsController, type: :controller do

  describe "GET #new" do
    context 'Admin' do
      let(:admin_user) { create(:user, role: 'Admin') }
      before { login(admin_user) }

      it "render template new" do
        get :new
        expect(response).to render_template :new
      end

      it "assigns new to var" do
        get :new
        expect(assigns(:brand)).to be_a_new Brand
      end
    end

    context 'Authenticated not admin user' do
      let(:user) { create(:user) }
      before { login(user) }

      it "redirect to root" do
        get :new
        expect(response).to redirect_to root_path
      end


      it "brand is nil" do
        get :new
        expect(assigns(:brand)).to be_nil
      end
    end

    context 'Guest' do

      it "redirect to log in" do
        get :new
        expect(response).to redirect_to new_user_session_path
      end


      it "brand is nil" do
        get :new
        expect(assigns(:brand)).to be_nil
      end
    end
  end

  describe 'POST #create' do
    context 'Admin' do
      let(:admin_user) { create(:user, role: 'Admin') }
      before { login(admin_user) }

      context 'with valid data can create' do

        it 'change count brand' do
          expect do
            post :create, params: {brand: attributes_for(:brand)}
          end.to change(Brand, :count).by(1)
        end

        it 'redirect to @brand' do
          post :create, params: {brand: attributes_for(:brand)}
          expect(response).to redirect_to assigns(:brand)
        end
      end
      context 'with invalid data can not create' do

        it 'does not change count brand' do
          expect do
            post :create, params: {brand: attributes_for(:brand, name: '')}
          end.to_not change(Brand, :count)
        end

        it 'render template new' do
          post :create, params: {brand: attributes_for(:brand, name: '')}
          expect(response).to render_template :new
        end
      end
    end

    context 'Authenticated user not admin' do
      let(:user) { create(:user) }
      before { login(user) }

      it 'does not change count brand' do
        expect do
          post :create, params: {brand: attributes_for(:brand)}
        end.to_not change(Brand, :count)
      end

      it 'redirect to root' do
        post :create, params: {brand: attributes_for(:brand)}
        expect(response).to redirect_to root_path
      end
    end
    context 'Guest' do
      it 'does not change count brand' do
        expect do
          post :create, params: {brand: attributes_for(:brand)}
        end.to_not change(Brand, :count)
      end

      it 'redirect to log in' do
        post :create, params: {brand: attributes_for(:brand)}
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET #show' do
    let(:brand) { create(:brand) }

    context 'Admin' do
      let(:admin_user) { create(:user, role: 'Admin') }
      before { login(admin_user) }

      it 'render template show' do
        get :show, params: {id: brand}
        expect(response).to render_template :show
      end
      it 'assigns var brand' do
        get :show, params: {id: brand}
        expect(assigns(:brand)).to eq brand
      end

    end

    context 'Authenticated user not admin' do
      let(:user) { create(:user) }
      before { login(user) }

      it 'redirect to root' do
        get :show, params: {id: brand}
        expect(response).to redirect_to root_path
      end
      it 'assigns var brand' do
        get :show, params: {id: brand}
        expect(assigns(:brand)).to be_nil
      end

    end

    context 'Guest' do

      it 'redirect to log in' do
        get :show, params: {id: brand}
        expect(response).to redirect_to new_user_session_path
      end
      it 'assigns var brand' do
        get :show, params: {id: brand}
        expect(assigns(:brand)).to be_nil
      end
    end
  end

end
