require 'rails_helper'

RSpec.describe AdsController, type: :controller do

  describe "GET #index" do
    let(:ads) { create_list(:ad, 3, user: create(:user)) }

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

end
