require 'sphinx_helper'

RSpec.describe SearchesController, type: :controller do

  describe "GET #index" do
    let!(:user) { create(:user) }
    let!(:kite_name) { create(:kite_name, name: 'Ozone') }
    let!(:board_name) { create(:board_name, name: 'Liquid') }
    let!(:kite) { create(:kite, user: user, kite_name: kite_name) }
    let!(:board) { create(:board, user: user) }
    let!(:bar) { create(:bar, user: user) }
    let!(:stuff) { create(:stuff, user: user) }
    let!(:ad_kite) { create(:ad, user: user, kite_ids: [kite.id]) }
    let!(:ad_board) { create(:ad, user: user, board_ids: [board.id]) }

    it_behaves_like 'Search' do
      let(:what_search) { ad_kite }
      let(:scope) { what_search.kites.first.class }
      let(:query) { kite_name.name }
      let(:other_data) { [ad_board] }
    end

    it_behaves_like 'Search' do
      let(:what_search) { ad_board }
      let(:scope) { what_search.boards.first.class }
      let(:query) { board_name.name }
      let(:other_data) { [ad_kite] }
    end

    context 'Invalid scope' do
      let(:invalid_params_search) { {scope: 'Invalid', query: board_name.name} }

      before do
        expect(Services::Search).to receive(:call).and_return(nil)
        get :index, params: invalid_params_search
      end

      it 'assigns results' do
        expect(assigns(:results)).to be_nil
      end

      it 'redirect to root' do
        expect(response).to redirect_to root_path
      end
    end
  end
end
