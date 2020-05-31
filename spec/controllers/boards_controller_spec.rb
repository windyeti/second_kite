require 'rails_helper'

RSpec.describe BoardsController, type: :controller do
  let(:board_name) { create(:board_name) }
  let(:user) { create(:user) }

  describe "GET #new" do
    context 'Authenticated user' do
      before do
        login(user)
        get :new, xhr: true
      end

      it "render template new" do
        expect(response).to render_template :new
      end

      it "assigns board is new" do
        expect(assigns(:board)).to be_a_new(Board)
      end
    end

    context 'Guest' do
      before { get :new, params: { board_name_id: board_name } }

      it "redirect to log in" do
        expect(response).to redirect_to new_user_session_path
      end

      it "assigns kite is new" do
        expect(assigns(:board)).to be_nil
      end
    end

  end

  describe "POST #create" do
    context 'Authenticated user create kite' do
      let!(:brand) { create(:brand, name: 'F-ONE') }
      let!(:board_name) { create(:board_name, brand: brand, name: 'Solo') }
      let(:user) { create(:user) }
      before { login(user) }

      context 'with valid data can create board' do

        it 'assigns board' do
          post :create, params: { board: attributes_for(:board, brand: "F-ONE", madel: "Solo") }, format: :json
          expect(assigns(:board)).to eq board_name.boards.first
        end

        it 'assigns board with new madel' do
          post :create, params: { board: attributes_for(:board, brand: "F-ONE", madel: "NEWSolo") }, format: :json
          expect(assigns(:board).board_name.name).to eq 'NEWSolo'
        end

        it 'assigns board with new brand and madel' do
          post :create, params: { board: attributes_for(:board, brand: "NEWF-ONE", madel: "NEWSolo") }, format: :json
          expect(assigns(:board).board_name.brand.name).to eq 'NEWF-ONE'
        end

        it 'change count board by 1' do
          expect do
            post :create, params: { board: attributes_for(:board, brand: "F-ONE", madel: "Solo") }, format: :json
          end.to change(Board, :count).by(1)
        end

        it 'return status ok' do
          post :create, params: { board: attributes_for(:board, brand: "F-ONE", madel: "Solo") }, format: :json
          expect(response).to have_http_status :ok
        end
      end

      it 'return status :unprocessable_entity' do
        post :create, params: { board_name_id: board_name, board: attributes_for(:board, brand: "", madel: "Solo") }, format: :json
        expect(response).to have_http_status :unprocessable_entity
      end

      context 'with invalid data cannot create kite' do

        it 'board is not valid' do
          post :create, params: { board_name_id: board_name, board: attributes_for(:board, :invalid, brand: "F-ONE", madel: "Solo") }, format: :json
          expect(assigns(:board).year).to be_nil
        end

        it 'does not change count boards' do
          expect do
            post :create, params: { board_name_id: board_name, board: attributes_for(:board, :invalid, brand: "F-ONE", madel: "Solo") }, format: :json
          end.to_not change(Board, :count)
        end

        it 'return status :unprocessable_entity' do
          post :create, params: { board_name_id: board_name, board: attributes_for(:board, :invalid, brand: "F-ONE", madel: "Solo") }, format: :json
          expect(response).to have_http_status :unprocessable_entity
        end
      end
    end

    context 'Guest' do

      it 'does not assigns kite' do
        post :create, params: { board_name_id: board_name, board: attributes_for(:board, brand: "F-ONE", madel: "Solo") }, format: :json
        expect(assigns(:board)).to be_nil
      end

      it 'does not change count kites by 1' do
        expect do
          post :create, params: { board_name_id: board_name, board: attributes_for(:board, brand: "F-ONE", madel: "Solo") }, format: :json
        end.to_not change(Board, :count)
      end

      it 'return status :unauthorized' do
        post :create, params: { board_name_id: board_name, board: attributes_for(:board, brand: "F-ONE", madel: "Solo") }, format: :json
        expect(response).to have_http_status :unauthorized
      end
    end
  end

  describe "GET #show" do
    context 'Authenticated user' do
      let(:owner_user) { create(:user) }
      let(:other_user) { create(:user, email: 'other_user@mail.com') }
      let(:board) { create(:board, user: owner_user) }

      context 'owner kite' do
        before { login(owner_user) }

        it "render template show" do
          get :show, params: { id: board }
          expect(response).to render_template :show
        end

        it "assigns board" do
          get :show, params: { id: board }
          expect(assigns(:board)).to eq board
        end
      end

      context 'not owner kite' do
        before { login(other_user) }

        it "render template show" do
          get :show, params: { id: board }
          expect(response).to render_template :show
        end

        it "assigns board" do
          get :show, params: { id: board }
          expect(assigns(:board)).to eq board
        end
      end
    end

    context 'Guest' do
      let(:board) { create(:board) }

      it "render template show" do
        get :show, params: { id: board }
        expect(response).to render_template :show
      end

      it "assigns board" do
        get :show, params: { id: board }
        expect(assigns(:board)).to eq board
      end
    end
  end

  describe 'GET #edit' do
    let(:owner_user) { create(:user) }
    let(:other_user) { create(:user, email: 'other@mail.com') }
    let(:board) { create(:board, user: owner_user) }

    context 'Authenticated user' do
      context 'owner' do
        before { login(owner_user) }

        it 'render template edit' do
          get :edit, params: { id: board, brand: "F-ONE", madel: "Solo" }, xhr: true
          expect(response).to render_template :edit
        end

        it 'assigns board' do
          get :edit, params: { id: board, brand: "F-ONE", madel: "Solo" }, xhr: true
          expect(assigns(:board)).to eq board
        end
      end
      context 'not owner' do
        before { login(other_user) }

        it 'return status :forbidden' do
          get :edit, params: { id: board, brand: "F-ONE", madel: "Solo" }, xhr: true
          expect(response).to have_http_status :forbidden
        end

        it 'assigns board' do
          get :edit, params: { id: board, brand: "F-ONE", madel: "Solo" }, xhr: true
          expect(assigns(:board)).to eq board
        end
      end
    end
    context 'Guest' do
      it 'assigns board is nil' do
        get :edit, params: { id: board, brand: "F-ONE", madel: "Solo" }, xhr: true
        expect(assigns(:board)).to be_nil
      end

      it 'redirect to log in' do
        get :edit, params: { id: board }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH #update' do
    let(:owner_user) { create(:user) }
    let(:other_user) { create(:user, email: 'other@mail.com') }
    let(:board) { create(:board, user: owner_user) }

    context 'Authenticated user' do
      context 'owner' do
        before { login(owner_user) }

        context 'with valid data can update board' do

          it 'assigns board' do
            patch :update, params: { id: board , board: { length: 8, brand: "F-ONE", madel: "Solo" } }, format: :json
            expect(assigns(:board)).to eq board
          end

          it 'change attributes' do
            patch :update, params: { id: board , board: { length: 8, brand: "F-ONE", madel: "Solo" } }, format: :json
            board.reload
            expect(board.length).to eq 8
          end

          it 'return status ok' do
            patch :update, params: { id: board , board: { length: 8, brand: "F-ONE", madel: "Solo" } }, format: :json
            expect(response).to have_http_status :ok
          end
        end
        context 'with invalid data can not update board' do

          it 'assigns board' do
            patch :update, params: { id: board , board: { length: '', brand: "F-ONE", madel: "Solo" } }, format: :json
            expect(assigns(:board)).to eq board
          end

          it 'does not change attributes' do
            patch :update, params: { id: board , board: { length: '', brand: "F-ONE", madel: "Solo" } }, format: :json
            expect(board.length).to eq Board.find(board.id).length
          end

          it 'return status :unprocessable_entity' do
            patch :update, params: { id: board , board: { length: '', brand: "F-ONE", madel: "Solo" } }, format: :json
            expect(response).to have_http_status :unprocessable_entity
          end
        end
      end
      context 'not owner' do
        before { login(other_user) }

        it 'does not assign board' do
          patch :update, params: { id: board , board: { length: 8, brand: "F-ONE", madel: "Solo" } }, format: :json
          expect(assigns(:board)).to eq board
        end

        it 'does not change attributes' do
          patch :update, params: { id: board , board: { length: 8, brand: "F-ONE", madel: "Solo" } }, format: :json
          expect(board.length).to eq Board.find(board.id).length
        end

        it 'return status :forbidden' do
          patch :update, params: { id: board , board: { length: 8, brand: "F-ONE", madel: "Solo" } }, format: :json
          expect(response).to have_http_status :forbidden
        end
      end
    end

    context 'Guest' do

      it 'does not assign board' do
        patch :update, params: { id: board , board: { length: 8, brand: "F-ONE", madel: "Solo" } }, format: :json
        expect(assigns(:board)).to be_nil
      end

      it 'does not change attributes' do
        patch :update, params: { id: board , board: { length: 8, brand: "F-ONE", madel: "Solo" } }, format: :json
        expect(board.length).to eq Board.find(board.id).length
      end

      it 'return status :unauthorized' do
        patch :update, params: { id: board , board: { length: 8, brand: "F-ONE", madel: "Solo" } }, format: :json
        expect(response).to have_http_status :unauthorized
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:owner_user) { create(:user) }
    let(:other_user) { create(:user, email: 'other@mail.com') }
    let!(:board) { create(:board, user: owner_user) }

    context 'Authenticated user' do

      context 'owner can delete board' do
        before { login(owner_user) }

        it 'assigns board' do
          delete :destroy, params: { id: board }, format: :js
          expect(assigns(:board)).to eq board
        end

        it 'change board count' do
          expect do
            delete :destroy, params: { id: board }, format: :js
          end.to change(Board, :count).by(-1)
        end

        it 'render template destroy' do
          delete :destroy, params: { id: board }, format: :js
          expect(response).to render_template :destroy
        end
      end

      context 'not owner can not delete board' do
        before { login(other_user) }

        it 'assigns board' do
          delete :destroy, params: { id: board }
          expect(assigns(:board)).to eq board
        end

        it 'does not change board count' do
          expect do
            delete :destroy, params: { id: board }
          end.to_not change(Board, :count)
        end

        it 'redirect to root' do
          delete :destroy, params: { id: board }
          expect(response).to redirect_to root_path
        end
      end
    end
    context 'Guest' do
      context 'can not delete board' do

        it 'does not assigns board' do
          delete :destroy, params: { id: board }
          expect(assigns(:board)).to be_nil
        end

        it 'does not change board count' do
          expect do
            delete :destroy, params: { id: board }
          end.to_not change(Board, :count)
        end

        it 'redirect to log in' do
          delete :destroy, params: { id: board }
          expect(response).to redirect_to new_user_session_path
        end
      end
    end
  end
end
