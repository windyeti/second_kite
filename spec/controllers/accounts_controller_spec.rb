require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  describe 'GET #show' do
    let(:user) { create(:user) }
    context 'Authenticate user can see his account' do
      before { login(user) }

      it 'render template show' do
        get :show, params: { id: user.account }
        expect(response).to render_template :show
      end

      it 'assigns account to var' do
        get :show, params: { id: user.account }
        expect(assigns(:account)).to eq user.account
      end
    end

    describe 'Guest can not see account' do
      it 'redirect to root' do
        get :show, params: { id: user.account }
        expect(response).to redirect_to new_user_session_path
      end

      it 'assigns account to var' do
        get :show, params: { id: user.account }
        expect(assigns(:account)).to be_nil
      end
    end
  end

  describe 'GET #edit' do
    let(:user) { create(:user) }
    context 'Authenticate user can edit his account' do
      before { login(user) }

      it 'render template edit' do
        get :edit, params: { id: user.account }
        expect(response).to render_template :edit
      end

      it 'assigns account to var' do
        get :edit, params: { id: user.account }
        expect(assigns(:account)).to eq user.account
      end
    end
  end

  describe 'PATCH #update' do
    let(:user) { create(:user) }
    context 'Authenticate user can edit his account' do
      before { login(user) }

      it 'redirect to account' do
        patch :update, params: { id: user.account, account: { nickname: 'Jora' } }
        expect(response).to redirect_to account_path(user.account)
      end

      it 'change nick of user.account' do
        expect do
          patch :update, params: { id: user.account, account: { nickname: 'Jora' } }
          user.account.reload
        end.to change(user.account, :nickname)
      end

      it 'assigns account to var' do
        patch :update, params: { id: user.account, account: { nickname: 'Jora' } }
        expect(assigns(:account)).to eq user.account
      end
    end
  end
end
