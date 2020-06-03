require 'rails_helper'

RSpec.describe ProofsController, type: :controller do
  let(:admin_user) { create(:user, role: 'Admin', email: 'adminr@mail.com') }
  let(:user) { create(:user, email: 'user@mail.com') }

  describe 'GET #index' do
    let!(:ads_proofs) { create_list(:ad, 3, user: user) }
    let!(:ad_approve) { create(:ad, user: user, approve: true) }
    context 'Admin' do
      before do
        login(admin_user)
        get :index
      end

      it 'assigns proofs' do
        expect(assigns(:proofs).to_a).to eq ads_proofs
      end

      it 'render index' do
        expect(response).to render_template :index
      end
    end

    context 'Authenticated user' do
      before do
        login(user)
        get :index
      end

      it 'assigns proofs' do
        expect(assigns(:proofs)).to be_nil
      end

      it 'redirect to log in' do
        expect(response).to redirect_to root_path
      end
    end

    context 'Guest' do
      before do
        get :index
      end

      it 'assigns proofs' do
        expect(assigns(:proofs)).to be_nil
      end

      it 'redirect to log in' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET #show' do
    let!(:ad) { create(:ad, user: user) }

    context 'Admin' do
      before do
        login(admin_user)
        get :show, params: { id: ad }
      end

      it 'assigns proofs' do
        expect(assigns(:proof)).to eq ad
      end

      it 'render index' do
        expect(response).to render_template :show
      end
    end

    context 'Authenticated user' do
      before do
        login(user)
        get :show, params: { id: ad }
      end

      it 'assigns proofs' do
        expect(assigns(:proof)).to be_nil
      end

      it 'redirect to log in' do
        expect(response).to redirect_to root_path
      end
    end

    context 'Guest' do
      before do
        get :show, params: { id: ad }
      end

      it 'assigns proofs' do
        expect(assigns(:proof)).to be_nil
      end

      it 'redirect to log in' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH #update' do
    let!(:brand_approve) { create(:brand, approve: true) }
    let!(:kite_name) { create(:kite_name, brand: brand_approve, approve: true) }
    let!(:kite) { create(:kite, kite_name: kite_name) }

    context 'Admin' do
      before do
        login(admin_user)
        patch :update, params: { id: kite.kite_name , klass: kite.kite_name.class }, format: :json
      end

      it 'assigns proofs' do
        expect(assigns(:proof)).to eq kite.kite_name
      end

      it 'return status ok' do
        expect(response).to have_http_status :ok
      end
    end

    context 'Authenticated user' do
      before do
        login(user)
        patch :update, params: { id: kite.kite_name , klass: kite.kite_name.class }, format: :json
      end

      it 'assigns proofs' do
        expect(assigns(:proof)).to be_nil
      end

      it 'return status forbidden' do
        expect(response).to have_http_status :forbidden
      end
    end

    context 'Guest' do
      before do
        patch :update, params: { id: kite.kite_name , klass: kite.kite_name.class }, format: :json
      end

      it 'assigns proofs' do
        expect(assigns(:proof)).to be_nil
      end

      it 'return status unauthorized' do
        expect(response).to have_http_status :unauthorized
      end
    end
  end

  describe 'POST #notification' do
    let!(:brand_approve) { create(:brand, approve: true) }
    let!(:kite_name) { create(:kite_name, brand: brand_approve) }
    let!(:kite) { create(:kite, kite_name: kite_name) }
    let!(:ad) { create(:ad, kite_ids: [kite.id], user: user) }

    context 'Admin' do
      before do
        login(admin_user)
      end

      it 'assigns proofs' do
        post :notification, params: { id: ad, subject: 'Text Subject', message: 'Text text text' }
        expect(assigns(:proof)).to eq ad
      end

      it 'redirect to proofs' do
        post :notification, params: { id: ad, subject: 'Text Subject', message: 'Text text text' }
        expect(response).to redirect_to proofs_path
      end

      it 'call DismissUserBrandJob.perform_later' do
        args = {
          ad: ad,
          subject: 'Text Subject',
          message: 'Text text text'
        }
        expect(DismissUserBrandJob).to receive(:perform_later).with(args)
        post :notification, params: { id: ad, subject: 'Text Subject', message: 'Text text text' }
      end
    end

    context 'Authenticated user' do
      before do
        login(user)
        post :notification, params: { id: ad, subject: 'Text Subject', message: 'Text text text' }
      end

      it 'assigns proof' do
        expect(assigns(:proof)).to be_nil
      end

      it 'redirect to root' do
        expect(response).to redirect_to root_path
      end
    end

    context 'Guest' do
      before do
        post :notification, params: { id: ad, subject: 'Text Subject', message: 'Text text text' }
      end

      it 'assigns proof' do
        expect(assigns(:proof)).to be_nil
      end

      it 'redirect to log in' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
