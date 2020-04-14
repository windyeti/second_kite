require 'rails_helper'

RSpec.describe KitesController, type: :controller do
  let(:user) { create(:user) }

  describe "GET #new" do
    before do
      login(user)
      get :new
    end
    it "render template new" do
      expect(response).to render_template :new
    end

    it "assigns ad to new" do
      expect(assigns(:kite)).to be_a_new(Kite)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context 'Authenticated user can create kite' do

      let(:user) { create(:user) }
      before { login(user) }

      context 'with valid data' do

        it 'change count kites by 1' do
          expect do
            post :create, params: { kite: attributes_for(:kite) }
          end.to change(Kite, :count).by(1)
        end

        it 'redirect to kite' do
          post :create, params: { kite: attributes_for(:kite) }
          expect(response).to redirect_to assigns(:kite)
        end
      end
      context 'with invalid data' do

        it 'does not change count kites' do
          expect do
            post :create, params: { kite: attributes_for(:kite, :invalid) }
          end.to_not change(Kite, :count)
        end

        it 'render template new' do
          post :create, params: { kite: attributes_for(:kite, :invalid) }
          expect(response).to render_template :new
        end
      end
    end

    context 'Guest'
      it 'change count kites by 1' do
        expect do
          post :create, params: { kite: attributes_for(:kite) }
        end.to_not change(Kite, :count)
      end

      it 'redirect to log in' do
        post :create, params: { kite: attributes_for(:kite, :invalid) }
        expect(response).to redirect_to new_user_session_path
      end
  end

  describe "GET #show" do
    let(:user) { create(:user) }
    let(:kite) { create(:kite, user: user) }

    it "render template show" do
      get :show, params: { id: kite }
      expect(response).to render_template :show
    end

    # it "assigns ad to new" do
    #   get :show, params: { id: kite }
    #   expect(assigns(:kite)).to eq kite
    # end
    #
    # it "returns http success" do
    #   get :show
    #   expect(response).to have_http_status(:success)
    # end
  end

end
