require 'rails_helper'

RSpec.describe SinglySalesController, type: :controller do
  describe 'GET #kites' do
    let!(:kites) { create_list(:kite, 3, user: create(:user)) }

    context 'Guest' do
      it 'assigns kites' do
        get :kites
        expect(assigns(:kites)).to eq kites
      end

      it 'render template kites' do
        get :kites
        expect(response).to render_template :kites
      end
    end
  end
end
