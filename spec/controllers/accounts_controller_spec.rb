require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  describe 'GET #show' do
    context 'Authenticate user can see his account' do
      let(:user) { create(:user) }
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
  end
end
