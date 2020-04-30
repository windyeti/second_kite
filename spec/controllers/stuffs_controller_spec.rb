require 'rails_helper'

RSpec.describe StuffsController, type: :controller do
  describe 'GET #new' do
    context 'Authenticated user' do
      let(:stuff_name) { create(:stuff_name) }
      let(:user) { create(:user) }
      before { login(user) }

      it 'assigns new stuff' do
        get :new, params: { stuff_name_id: stuff_name }
        expect(assigns(:stuff)).to be_a_new Stuff
      end

      it 'assigns stuff_name' do
        get :new, params: { stuff_name_id: stuff_name }
        expect(assigns(:stuff_name)).to eq stuff_name
      end

      it 'render template new' do
        get :new, params: { stuff_name_id: stuff_name }
        expect(response).to render_template :new
      end
    end
    context 'Guest'
  end
end
