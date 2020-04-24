require 'rails_helper'

RSpec.describe BoardNamesController, type: :controller do

  describe 'POST #create' do
    let(:brand) { create(:brand) }

    context 'Admin' do
      let(:admin_user) { create(:user, role: 'Admin') }
      before { login(admin_user) }

      context 'with valid data' do

        it 'assigns brand' do
          post :create, params: { brand_id: brand, board_name: attributes_for(:board_name) }, format: :json
          expect(assigns(:brand)).to eq brand
        end

        it 'assigns board_name' do
          post :create, params: { brand_id: brand, board_name: attributes_for(:board_name) }, format: :json
          expect(assigns(:board_name)).to eq brand.board_names.first
        end

        it 'does not render template create' do
          post :create, params: { brand_id: brand, board_name: attributes_for(:board_name) }, format: :json
          expect(response).to_not render_template :create
        end

        it 'change board_names count' do
          expect do
            post :create, params: { brand_id: brand, board_name: attributes_for(:board_name) }, format: :json
          end.to change(BoardName, :count).by(1)
        end
      end

      context 'with invalid data' do

        it 'return status :forbidden' do
          post :create, params: { brand_id: brand, board_name: { name: '' } }, format: :json
          expect(response).to_not have_http_status :forbidden
        end

        it 'does not render template create' do
          post :create, params: { brand_id: brand, board_name: { name: '' } }, format: :json
          expect(response).to_not render_template :create
        end

        it 'does not change board_names count' do
          expect do
            post :create, params: { brand_id: brand, board_name: { name: '' } }, format: :json
          end.to_not change(BoardName, :count)
        end
      end
    end
    context 'Authenticated user not admin' do
      let(:user) { create(:user) }
      before { login(user) }

      it 'redirect to root' do
        post :create, params: { brand_id: brand, board_name: attributes_for(:board_name) }, format: :json
        expect(response).to have_http_status :forbidden
      end

      it 'return status :forbidden' do
        post :create, params: { brand_id: brand, board_name: attributes_for(:board_name) }, format: :json
        expect(response).to have_http_status :forbidden
      end

      it 'does not change board_names count' do
        expect do
          post :create, params: { brand_id: brand, board_name: attributes_for(:board_name) }, format: :json
        end.to_not change(BoardName, :count)
      end
    end
    context 'Guest' do

      it 'return status' do
        post :create, params: { brand_id: brand, board_name: attributes_for(:board_name) }, format: :json
        expect(response).to have_http_status :unauthorized
      end

      it 'does not change board_names count' do
        expect do
          post :create, params: { brand_id: brand, board_name: attributes_for(:board_name) }, format: :json
        end.to_not change(BoardName, :count)
      end
    end
  end

  describe 'GET #edit' do
    let!(:board_name) { create(:board_name, name: 'Liquid') }

    context 'Admin' do
      let(:admin_user) { create(:user, role: 'Admin') }
      before { login(admin_user) }

      it 'assigns board_name' do
        get :edit, params: { id: board_name }
        expect(assigns(:board_name)).to eq board_name
      end

      it 'render template edit' do
        get :edit, params: { id: board_name }
        expect(response).to render_template :edit
      end
    end

    context 'Authenticated user not admin' do
      let(:user) { create(:user) }
      before { login(user) }

      it 'redirect to root' do
        get :edit, params: { id: board_name }
        expect(response).to redirect_to root_path
      end

    end
    context 'Guest' do

      it 'assigns board_name' do
        get :edit, params: { id: board_name }
        expect(assigns(:board_name)).to be_nil
      end

      it 'redirect to log in' do
        get :edit, params: { id: board_name }
        expect(response).to redirect_to new_user_session_path
      end

    end
  end

  describe 'PATCH #update' do
    let!(:board_name) { create(:board_name, name: 'Liquid') }

    context 'Admin' do
      let(:admin_user) { create(:user, role: 'Admin') }
      before { login(admin_user) }

      it 'assigns board_name' do
        patch :update, params: { id: board_name, board_name: { name: 'Liquid NEW' } }
        expect(assigns(:board_name)).to eq board_name
      end

      it 'redirect to board_name' do
        patch :update, params: { id: board_name, board_name: { name: 'Liquid NEW' } }
        expect(response).to redirect_to assigns(:board_name)
      end

      it 'change name in board_name' do
        expect do
          patch :update, params: { id: board_name, board_name: { name: 'Liquid NEW' } }
          board_name.reload
        end.to change(board_name, :name)
      end

      context 'with invalid data can not update board_name' do

        it 'assigns board_name' do
          patch :update, params: { id: board_name, board_name: { name: '' } }
          expect(assigns(:board_name).valid?).to be_falsey
        end

        it 'render template edit' do
          patch :update, params: { id: board_name, board_name: { name: '' } }
          expect(response).to render_template :edit
        end

        it 'does not change name in board_name' do
          expect do
            patch :update, params: { id: board_name, board_name: { name: '' } }
            board_name.reload
          end.to_not change(board_name, :name)
        end
      end
    end
    context 'Authenticated user not admin' do
      let(:user) { create(:user) }
      before { login(user) }

      context 'can not update board_name' do

        it 'assigns board_name' do
          patch :update, params: { id: board_name, board_name: { name: 'Liquid NEW' } }
          expect(assigns(:board_name)).to eq board_name
        end

        it 'redirect to root' do
          patch :update, params: { id: board_name, board_name: { name: 'Liquid NEW' } }
          expect(response).to redirect_to root_path
        end

        it 'does not change name in board_name' do
          expect do
            patch :update, params: { id: board_name, board_name: { name: 'Liquid NEW' } }
            board_name.reload
          end.to_not change(board_name, :name)
        end
      end
    end

    context 'Guest' do
      context 'can not update board_name' do

        it 'assigns board_name' do
          patch :update, params: { id: board_name, board_name: { name: 'Liquid NEW' } }
          expect(assigns(:board_name)).to be_nil
        end

        it 'redirect to log in' do
          patch :update, params: { id: board_name, board_name: { name: 'Liquid NEW' } }
          expect(response).to redirect_to new_user_session_path
        end

        it 'does not change name in board_name' do
          expect do
            patch :update, params: { id: board_name, board_name: { name: 'Liquid NEW' } }
            board_name.reload
          end.to_not change(board_name, :name)
        end
      end
    end

  end

  describe 'GET #show' do
    let(:board_name) { create(:board_name) }

    context 'Admin' do
      let(:admin_user) { create(:user, role: 'Admin') }
      before { login(admin_user) }

      it 'assigns board_name' do
        get :show, params: { id: board_name }
        expect(assigns(:board_name)).to eq board_name
      end

      it 'render template show' do
        get :show, params: { id: board_name }
        expect(response).to render_template :show
      end
    end

    context 'Authenticated user not admin' do
      let(:user) { create(:user) }
      before { login(user) }

      it 'assigns board_name' do
        get :show, params: { id: board_name }
        expect(assigns(:board_name)).to eq board_name
      end

      it 'redirect to root' do
        get :show, params: { id: board_name }
        expect(response).to redirect_to root_path
      end
    end

    context 'Guest' do

      it 'assigns board_name' do
        get :show, params: { id: board_name }
        expect(assigns(:board_name)).to be_nil
      end

      it 'redirect to log in' do
        get :show, params: { id: board_name }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:board_name) { create(:board_name) }

    context 'Admin' do
      let(:admin_user) { create(:user, role: 'Admin') }
      before { login(admin_user) }

      it 'assigns board_name' do
        delete :destroy, params: { id: board_name }, format: :js
        expect(assigns(:board_name)).to eq board_name
      end

      it 'change count BoardName' do
        expect do
          delete :destroy, params: { id: board_name }, format: :js
        end.to change(BoardName, :count).by(-1)
      end

      it 'render template destroy' do
        delete :destroy, params: { id: board_name }, format: :js
        expect(response).to render_template :destroy
      end
    end
    context 'Authenticated user not admin' do
      let(:user) { create(:user) }
      before { login(user) }

      it 'assigns board_name' do
        delete :destroy, params: { id: board_name }, format: :js
        expect(assigns(:board_name)).to eq board_name
      end

      it 'does not change count BoardName' do
        expect do
          delete :destroy, params: { id: board_name }, format: :js
        end.to_not change(BoardName, :count)
      end

      it 'return status :forbidden' do
        delete :destroy, params: { id: board_name }, format: :js
        expect(response).to have_http_status :forbidden
      end
    end
    context 'Guest' do

      it 'assigns board_name' do
        delete :destroy, params: { id: board_name }, format: :js
        expect(assigns(:board_name)).to be_nil
      end

      it 'does not change count BoardName' do
        expect do
          delete :destroy, params: { id: board_name }, format: :js
        end.to_not change(BoardName, :count)
      end

      it 'return status :unauthorized' do
        delete :destroy, params: { id: board_name }, format: :js
        expect(response).to have_http_status :unauthorized
      end
    end
  end

end
