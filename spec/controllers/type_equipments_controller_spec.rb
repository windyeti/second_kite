require 'rails_helper'

RSpec.describe TypeEquipmentsController, type: :controller do

  describe "GET #index" do
    let!(:type_equipments) { create_list(:type_equipment, 3) }

    context 'Admin' do
      let(:admin_user) { create(:user, role: 'Admin') }
      before do
        login(admin_user)
        get :index
      end

      it "render template index" do
        expect(response).to render_template :index
      end

      it "assigns var type_equipments" do
        expect(assigns(:type_equipments)).to eq type_equipments
      end
    end
    context 'Authenticated user not admin' do
      let(:user) { create(:user) }
      before do
        login(user)
        get :index
      end

      it "redirect to root" do
        expect(response).to redirect_to root_path
      end

      it "var type_equipments is nil" do
        expect(assigns(:type_equipments)).to be_nil
      end
    end
    context 'Guest' do
      before do
        get :index
      end

      it "redirect to log in" do
        expect(response).to redirect_to new_user_session_path
      end

      it "var type_equipments is nil" do
        expect(assigns(:type_equipments)).to be_nil
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

      it "assigns type_equipment" do
        get :new
        expect(assigns(:type_equipment)).to be_a_new TypeEquipment
      end
    end

    context 'Authenticated user not admin' do
      let(:user) { create(:user) }
      before { login(user) }

      it "redirect to root" do
        get :new
        expect(response).to redirect_to root_path
      end

      it "assigns type_equipment" do
        get :new
        expect(assigns(:type_equipment)).to be_nil
      end
    end

    context 'Guest' do

      it "redirect to log in" do
        get :new
        expect(response).to redirect_to new_user_session_path
      end

      it "assigns type_equipment" do
        get :new
        expect(assigns(:type_equipment)).to be_nil
      end
    end
  end

  describe 'POST #create' do
    context 'Admin' do
      let(:admin_user) { create(:user, role: 'Admin') }
      before { login(admin_user) }

      context 'with valid data can create type equipment' do
        it "change count by 1" do
          expect do
            post :create, params: {type_equipment: attributes_for(:type_equipment)}
          end.to change(TypeEquipment, :count).by(1)
        end

        it "redirect to type_equipment" do
          post :create, params: {type_equipment: attributes_for(:type_equipment)}
          expect(response).to redirect_to assigns(:type_equipment)
        end
      end
      context 'with invalid data can not create type equipment' do
        it "change count by 1" do
          expect do
            post :create, params: {type_equipment: attributes_for(:type_equipment, :invalid)}
          end.to_not change(TypeEquipment, :count)
        end

        it "render template new" do
          post :create, params: {type_equipment: attributes_for(:type_equipment, :invalid)}
          expect(response).to render_template :new
        end
      end
    end

    context 'Authenticated user not admin' do
      let(:user) { create(:user) }
      before { login(user) }

      it "does not change count" do
        expect do
          post :create, params: {type_equipment: attributes_for(:type_equipment)}
        end.to_not change(TypeEquipment, :count)
      end

      it "redirect to root" do
        post :create, params: {type_equipment: attributes_for(:type_equipment)}
        expect(response).to redirect_to root_path
      end
    end

    context 'Guest' do
      it "does not change count" do
        expect do
          post :create, params: {type_equipment: attributes_for(:type_equipment)}
        end.to_not change(TypeEquipment, :count)
      end

      it "redirect to log in" do
        post :create, params: {type_equipment: attributes_for(:type_equipment)}
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "GET #show" do
    let(:type_equipment) { create(:type_equipment) }

    context 'Admin' do
      let(:admin_user) { create(:user, role: 'Admin') }
      before { login(admin_user) }

      it 'assigns type_equipment' do
        get :show, params: { id: type_equipment }
        expect(assigns(:type_equipment)).to eq type_equipment
      end

      it 'render template show' do
        get :show, params: { id: type_equipment }
        expect(response).to render_template :show
      end
    end

    context 'Authenticated user not admin' do
      let(:user) { create(:user) }
      before { login(user) }

      it 'type_equipment is nil' do
        get :show, params: { id: type_equipment }
        expect(assigns(:type_equipment)).to be_nil
      end

      it 'redirect to root' do
        get :show, params: { id: type_equipment }
        expect(response).to redirect_to root_path
      end
    end

    context 'Guest' do
      it 'type_equipment is nil' do
        get :show, params: { id: type_equipment }
        expect(assigns(:type_equipment)).to be_nil
      end

      it 'redirect to log in' do
        get :show, params: { id: type_equipment }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

end
