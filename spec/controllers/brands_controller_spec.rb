require 'rails_helper'

RSpec.describe BrandsController, type: :controller do

  describe "GET #new" do
    context 'Admin' do
      let(:admin_user) { create(:user, role: 'Admin') }
      before { login(admin_user) }

      it "render template new" do
        get :new
        expect(response).to render_template :new
      end

      it "assigns new to var" do
        get :new
        expect(assigns(:brand)).to be_a_new Brand
      end
    end

    context 'Authenticated not admin user' do
      let(:user) { create(:user) }
      before { login(user) }

      it "redirect to root" do
        get :new
        expect(response).to redirect_to root_path
      end


      it "brand is nil" do
        get :new
        expect(assigns(:brand)).to be_nil
      end
    end

    context 'Guest' do

      it "redirect to log in" do
        get :new
        expect(response).to redirect_to new_user_session_path
      end


      it "brand is nil" do
        get :new
        expect(assigns(:brand)).to be_nil
      end
    end
  end

end
