require 'rails_helper'

RSpec.describe SinglySalesController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #kites' do
    let!(:kite_1) { create(:kite, user: user) }
    let!(:kite_2) { create(:kite, user: user) }
    let!(:kite_3) { create(:kite, user: user) }
    let!(:ad) { create(:ad, user: user, kite_ids: [kite_1.id, kite_3.id]) }

    context 'Guest' do
      it 'assigns kites' do
        get :kites
        expect(assigns(:kites)).to match_array [kite_1, kite_3]
      end

      it 'render template kites' do
        get :kites
        expect(response).to render_template :kites
      end
    end
  end

  describe 'GET #boards' do
    let!(:board_1) { create(:board, user: user) }
    let!(:board_2) { create(:board, user: user) }
    let!(:board_3) { create(:board, user: user) }
    let!(:ad) { create(:ad, user: user, board_ids: [board_2.id, board_3.id]) }

    context 'Guest' do
      it 'assigns boards' do
        get :boards
        expect(assigns(:boards)).to match_array [board_2, board_3]
      end

      it 'render template boards' do
        get :boards
        expect(response).to render_template :boards
      end
    end
  end

  describe 'GET #bars' do
    let!(:bar_1) { create(:bar, user: user) }
    let!(:bar_2) { create(:bar, user: user) }
    let!(:bar_3) { create(:bar, user: user) }
    let!(:bar_4) { create(:bar, user: user) }
    let!(:ad_1) { create(:ad, user: user, bar_ids: [bar_1.id, bar_2.id]) }
    let!(:ad_2) { create(:ad, user: user, bar_ids: [bar_2.id, bar_4.id]) }

    context 'Guest' do
      it 'assigns bars' do
        get :bars
        expect(assigns(:bars)).to match_array [bar_1, bar_2, bar_4]
      end

      it 'render template bars' do
        get :bars
        expect(response).to render_template :bars
      end
    end
  end

  describe 'GET #stuffs' do
    let!(:stuff_1) { create(:stuff, user: user) }
    let!(:stuff_2) { create(:stuff, user: user) }
    let!(:stuff_3) { create(:stuff, user: user) }
    let!(:stuff_4) { create(:stuff, user: user) }
    let!(:ad_1) { create(:ad, user: user, stuff_ids: [stuff_1.id, stuff_2.id]) }
    let!(:ad_2) { create(:ad, user: user, stuff_ids: [stuff_1.id, stuff_4.id]) }

    context 'Guest' do
      it 'assigns stuffs' do
        get :stuffs
        expect(assigns(:stuffs)).to match_array [stuff_1, stuff_2, stuff_4]
      end

      it 'render template stuffs' do
        get :stuffs
        expect(response).to render_template :stuffs
      end
    end
  end
end
