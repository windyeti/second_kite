require 'rails_helper'

RSpec.describe AdsController, type: :controller do
  let(:user) { create(:user) }

  describe "GET #index" do
    let(:ads) { create_list(:ad, 3, user: user) }

    before { get :index }

    it "render template index" do
      expect(response).to render_template :index
    end

    it "assigns @ads" do
      expect(assigns(:ads)).to eq ads
    end

    it "returns status success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    context 'Authenticated user can create new ad' do
      before do
        login(user)
        get :new
      end

      it "@ad is a new" do
        expect(assigns(:ad)).to be_a_new(Ad)
      end

      it "return status success" do
        expect(response).to be_success
      end

      it "render template new" do
        expect(response).to render_template :new
      end

    end

    context 'Guest can not create new ad' do
      before { get :new }

      it "@ad is a new" do
        expect(assigns(:ad)).to be_nil
      end

      it "return status :found" do
        expect(response).to have_http_status :found
      end

      it "redirect to root" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "GET #create" do
    context 'Authenticated user' do
        let(:user) { create(:user) }
        before do
          login(user)
        end

      context ' can create ad with valid data' do

        it 'ads count be more' do
          expect do
            get :create, params: { ad: attributes_for(:ad, user: user)}
          end.to change(Ad, :count).by(1)
        end

        it 'redirect to ad' do
          get :create, params: { ad: attributes_for(:ad, user: user)}
          expect(response).to redirect_to assigns(:ad)
        end

        it 'return status redirect' do
          get :create, params: { ad: attributes_for(:ad, user: user)}
          expect(response).to be_redirect
        end
      end
      context 'can not create ad with invalid data' do

        it 'ads count does not change' do
          expect do
            get :create, params: { ad: attributes_for(:ad, :invalid, user: user)}
          end.to_not change(Ad, :count)
        end

        it 'render template new' do
          get :create, params: { ad: attributes_for(:ad, :invalid, user: user)}
          expect(response).to render_template :new
        end

        it 'return status render' do
          get :create, params: { ad: attributes_for(:ad, :invalid, user: user)}
          expect(response.status).to eq 200
        end
      end
    end
    context 'Guest user can not create ad' do
      let(:user) { create(:user) }

      it 'ads count does not change' do
        expect do
          get :create, params: { ad: attributes_for(:ad, user: user)}
        end.to_not change(Ad, :count)
      end

      it 'redirect to log in' do
        get :create, params: { ad: attributes_for(:ad, user: user)}
        expect(response).to redirect_to new_user_session_path
      end

      it 'return status render' do
        get :create, params: { ad: attributes_for(:ad, user: user)}
        expect(response).to be_redirect
      end
    end
  end

  describe "GET #show" do
    context 'Anybody can see an ad' do
      let(:ad) { create(:ad, user: create(:user)) }
      before { get :show, params: { id: ad } }

      it 'render template show' do
        expect(response).to render_template :show
      end

      it 'return status success' do
        expect(response).to be_success
      end

      it 'assigns ad' do
        expect(assigns(:ad)).to eq ad
      end
    end
  end

end
