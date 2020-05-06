require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do
  describe 'POST #create' do
    context 'Authenticated user' do
      let(:user) { create(:user) }
      let(:kite_name) { create(:kite_name) }
      before { login(user) }

      it 'assigns subscription' do
        post :create, params: { kite_name_id: kite_name, subscriptionable: 'kite_names' }
        expect(assigns(:subscription).subscriptionable).to eq kite_name
      end

      it 'redirect to account' do
        post :create, params: { kite_name_id: kite_name, subscriptionable: 'kite_names' }
        expect(assigns(:subscription).subscriptionable).to redirect_to account_path(user.account)
      end

      it 'change subscription count' do
        expect do
          post :create, params: { kite_name_id: kite_name, subscriptionable: 'kite_names' }
        end.to change(Subscription, :count).by(1)
      end
    end
    context 'Guest'
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }
    let(:kite_name) { create(:kite_name) }
    let!(:subscription) { create(:subscription, user: user, subscriptionable: kite_name) }

    context 'Authenticated user' do
      before { login(user) }

      it 'assigns subscription' do
        delete :destroy, params: { id: subscription }, format: :js
        expect(assigns(:subscription)).to eq subscription
      end

      it 'render template destroy' do
        delete :destroy, params: { id: subscription }, format: :js
        expect(assigns(:subscription)).to render_template :destroy
      end

      it 'change subscription count' do
        expect do
          delete :destroy, params: { id: subscription }, format: :js
        end.to change(Subscription, :count).by(-1)
      end
    end

    context 'Guest' do

      it 'assigns subscription' do
        delete :destroy, params: { id: subscription }, format: :js
        expect(assigns(:subscription)).to be_nil
      end

      it 'does not change subscription count' do
        expect do
          delete :destroy, params: { id: subscription }, format: :js
        end.to_not change(Subscription, :count)
      end
    end
  end
end
