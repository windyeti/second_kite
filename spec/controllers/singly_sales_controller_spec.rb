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

  describe 'GET #boards' do
    let!(:boards) { create_list(:board, 2, user: create(:user)) }

    context 'Guest' do
      it 'assigns boards' do
        get :boards
        expect(assigns(:boards)).to eq boards
      end

      it 'render template boards' do
        get :boards
        expect(response).to render_template :boards
      end
    end
  end

  describe 'GET #bars' do
    let!(:bars) { create_list(:bar, 4, user: create(:user)) }

    context 'Guest' do
      it 'assigns bars' do
        get :bars
        expect(assigns(:bars)).to eq bars
      end

      it 'render template bars' do
        get :bars
        expect(response).to render_template :bars
      end
    end
  end

  describe 'GET #stuffs' do
    let!(:stuffs) { create_list(:stuff, 4, user: create(:user)) }

    context 'Guest' do
      it 'assigns stuffs' do
        get :stuffs
        expect(assigns(:stuffs)).to eq stuffs
      end

      it 'render template stuffs' do
        get :stuffs
        expect(response).to render_template :stuffs
      end
    end
  end
end
