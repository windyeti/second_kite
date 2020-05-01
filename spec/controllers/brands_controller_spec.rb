require 'rails_helper'

RSpec.describe BrandsController, type: :controller do

  describe "GET #index" do
    let(:brand_1) { create(:brand, name: 'Brand_1') }
    let(:brand_2) { create(:brand, name: 'Brand_2') }
    let(:brand_3) { create(:brand, name: 'Brand_3') }

    context 'Admin' do
      let(:admin_user) { create(:user, role: 'Admin') }
      before do
        login(admin_user)
        get :index
      end

      it "render template new" do
        expect(response).to render_template :index
      end

      it "assigns brands" do
        expect(assigns(:brands)).to match_array [brand_1, brand_2, brand_3]
      end
    end

    context 'Authenticated user not admin' do
      let(:user) { create(:user) }
      before do
        login(user)
        get :index
      end

      it "render template index" do
        expect(response).to render_template :index
      end

      it "assigns brands" do
        expect(assigns(:brands)).to match_array [brand_1, brand_2, brand_3]
      end
    end

    context 'Authenticated user' do
      let!(:kite_name_1) { create(:kite_name, brand: brand_1) }
      let!(:kite_name_2) { create(:kite_name, brand: brand_1) }
      let!(:kite_name_3) { create(:kite_name, brand: brand_3) }
      let(:user) { create(:user) }
      before do
        login(user)
        get :index, params: { brands_for: "kite_names" }
      end

      it "assigns brands" do
        expect(assigns(:brands)).to match_array [brand_1, brand_3]
      end

    end

    context 'Guest' do
      before { get :index }

      it "redirect to log in" do
        expect(response).to redirect_to new_user_session_path
      end

      it "assigns brands" do
        expect(assigns(:brands)).to be_nil
      end
    end
  end

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

      it 'assigns var kite_name' do
        get :show, params: {id: brand}
        expect(assigns(:kite_name)).to be_a_new KiteName
      end

      it 'assigns var board_name' do
        get :show, params: {id: brand}
        expect(assigns(:board_name)).to be_a_new BoardName
      end

      it 'assigns var bar_name' do
        get :show, params: {id: brand}
        expect(assigns(:bar_name)).to be_a_new BarName
      end

      it 'assigns var stuff_name' do
        get :show, params: {id: brand}
        expect(assigns(:stuff_name)).to be_a_new StuffName
      end

      it '@type_equipment is nil' do
        get :show, params: {id: brand}
        expect(assigns(:type_equipment)).to be_nil
      end
    end

    context 'Authenticated user not admin' do
      let(:user) { create(:user) }
      before { login(user) }

      it 'render template show' do
        get :show, params: {id: brand}
        expect(response).to render_template :show
      end

      it 'assigns var @type_equipment' do
        get :show, params: {id: brand, "model_for"=> 'kite_names'}
        expect(assigns(:type_equipment)).to eq 'kite_names'
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

  describe "GET #edit" do
    let(:brand) { create(:brand) }

    context 'Admin' do
      let(:admin_user) { create(:user, role: 'Admin') }
      before do
        login(admin_user)
        get :edit, params: { id: brand }
      end

      it 'render template edit' do
        expect(response).to render_template :edit
      end

      it 'assigns brand' do
        expect(assigns(:brand)).to eq brand
      end
    end

    context 'Authenticated user not admin' do
      let(:user) { create(:user) }
      before do
        login(user)
        get :edit, params: { id: brand }
      end

      it 'redirect to root' do
        expect(response).to redirect_to root_path
      end

    end

    context 'Guest' do
      before do
        get :edit, params: { id: brand }
      end

      it 'redirect to log in' do
        expect(response).to redirect_to new_user_session_path
      end

      it 'assigns brand' do
        expect(assigns(:brand)).to be_nil
      end
    end
  end

  describe "PATCH #update" do
    let(:brand) { create(:brand) }

    context 'Admin' do
      let(:admin_user) { create(:user, role: 'Admin') }
      before do
        login(admin_user)
      end

      context 'with valid data can update' do

        it 'assigns brand' do
          patch :update, params: { id: brand, brand: { name: 'New brand name' } }
          expect(assigns(:brand)).to eq brand
        end

        it 'change brand' do
          expect do
            patch :update, params: { id: brand, brand: { name: 'New brand name' } }
            brand.reload
          end.to change(brand, :name)
        end

        it 'redirect to brand' do
          patch :update, params: { id: brand, brand: { name: 'New brand name' } }
          expect(response).to redirect_to brand
        end

      end

      context 'with invalid data can not update' do

        it 'assigns brand' do
          patch :update, params: { id: brand, brand: { name: '' } }
          expect(assigns(:brand)).to eq brand
        end

        it 'does not change brand' do
          expect do
            patch :update, params: { id: brand, brand: { name: '' } }
            brand.reload
          end.to_not change(brand, :name)
        end

        it 'render template edit' do
          patch :update, params: { id: brand, brand: { name: '' } }
          expect(response).to render_template :edit
        end

      end

    end

    context 'Authenticated user not admin' do
      let(:user) { create(:user) }
      before do
        login(user)
      end

      it 'does not change brand' do
        expect do
          patch :update, params: { id: brand, brand: { name: 'New brand name' } }
          brand.reload
        end.to_not change(brand, :name)
      end

      it 'redirect to root' do
        patch :update, params: { id: brand, brand: { name: 'New brand name' } }
        expect(response).to redirect_to root_path
      end

    end

    context 'Guest' do

      it 'does not change brand' do
        expect do
          patch :update, params: { id: brand, brand: { name: 'New brand name' } }
          brand.reload
        end.to_not change(brand, :name)
      end

      it 'redirect to log in' do
        patch :update, params: { id: brand, brand: { name: 'New brand name' } }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:brand) { create(:brand) }

    context 'Admin' do
      let(:admin_user) { create(:user, role: 'Admin') }
      before do
        login(admin_user)
      end

      it 'change count' do
        expect do
          delete :destroy, params: { id: brand }
        end.to change(Brand, :count).by(-1)
      end

      it 'assigns brand' do
        delete :destroy, params: { id: brand }
        expect(assigns(:brand)).to eq brand
      end

      it 'redirect to index' do
        delete :destroy, params: { id: brand }
        expect(response).to redirect_to brands_path
      end
    end

    context 'Authenticated user not admin' do
      let(:user) { create(:user) }
      before do
        login(user)
      end

      it 'does not change count' do
        expect do
          delete :destroy, params: { id: brand }
        end.to_not change(Brand, :count)
      end

      it 'redirect to root' do
        delete :destroy, params: { id: brand }
        expect(response).to redirect_to root_path
      end

    end

    context 'Guest' do

      it 'does not change count' do
        expect do
          delete :destroy, params: { id: brand }
        end.to_not change(Brand, :count)
      end

      it 'redirect to log in' do
        delete :destroy, params: { id: brand }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

end
