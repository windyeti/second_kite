require 'rails_helper'

RSpec.describe BoardsController, type: :controller do

  describe 'GET #new' do
    context 'Authenticated user owner board' do
      let(:user) { create(:user) }
      let(:board_name) { create(:board_name) }
      before { login(user) }

      it 'assigns board_name' do
        get :new, params: { board_name_id: board_name }
        expect(assigns(:board_name)).to eq board_name
      end

      it 'assigns new' do
        get :new, params: { board_name_id: board_name }
        expect(assigns(:board)).to be_a_new Board
      end

      it 'render template new' do
        get :new, params: { board_name_id: board_name }
        expect(response).to render_template :new
      end
    end
    context 'Guest'
  end

  describe 'POST #create' do

    context 'Authenticated user' do
      let(:user) { create(:user) }
      let(:board_name) { create(:board_name) }
      before { login(user) }

      context 'with valid data can create board' do

        it 'assigns board_name' do
          post :create, params: { board_name_id: board_name, board: attributes_for(:board) }
          expect(assigns(:board_name)).to eq board_name
        end

        it 'redirect to board' do
          post :create, params: { board_name_id: board_name, board: attributes_for(:board) }
          expect(response).to redirect_to assigns(:board)
        end

        it 'change board count' do
          expect do
            post :create, params: { board_name_id: board_name, board: attributes_for(:board) }
          end.to change(Board, :count).by(1)
        end
      end
      context 'with invalid data can not create board' do

        it 'assigns board_name' do
          post :create, params: { board_name_id: board_name, board: { size: '' } }
          expect(assigns(:board_name).valid?).to be_falsey
        end

        it 'render template new' do
          post :create, params: { board_name_id: board_name, board: { size: '' } }
          expect(response).to render_template :new
        end

        it 'does not change board count' do
          expect do
            post :create, params: { board_name_id: board_name, board: { size: '' } }
          end.to_not change(Board, :count)
        end
      end
    end

    context 'Guest' do
      let(:board_name) { create(:board_name) }

      context 'can not create board' do

        it 'assigns board_name' do
          post :create, params: { board_name_id: board_name, board: attributes_for(:board) }
          expect(assigns(:board_name)).to be_nil
        end

        it 'redirect to log in' do
          post :create, params: { board_name_id: board_name, board: attributes_for(:board) }
          expect(response).to redirect_to new_user_session_path
        end

        it 'does not change board count' do
          expect do
            post :create, params: { board_name_id: board_name, board: attributes_for(:board) }
          end.to_not change(Board, :count)
        end
      end
    end
  end

  describe 'GET #show' do
    let(:owner_user) { create(:user) }
    let(:board) { create(:board, user: owner_user) }

    context 'Authenticated user' do
      context 'owner' do
        before { login(owner_user) }

        it 'assigns board' do
          get :show, params: { id: board }
          expect(assigns(:board)).to eq board
        end

        it 'render template show' do
          get :show, params: { id: board }
          expect(response).to render_template :show
        end
      end
      context 'not owner' do
        let(:other_user) { create(:user, email: 'other@mail.com') }
        before { login(other_user) }

        it 'assigns board' do
          get :show, params: { id: board }
          expect(assigns(:board)).to eq board
        end

        it 'redirect to root' do
          get :show, params: { id: board }
          expect(response).to redirect_to root_path
        end
      end
    end
    context 'Guest' do

      it 'assigns board' do
        get :show, params: { id: board }
        expect(assigns(:board)).to be_nil
      end

      it 'redirect to log in' do
        get :show, params: { id: board }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET #edit' do
    let(:owner_user) { create(:user) }
    let(:board) { create(:board, user: owner_user) }

    context 'Authenticated user' do
      context 'owner' do
        before { login(owner_user) }

        it 'assigns board' do
          get :edit, params: { id: board }
          expect(assigns(:board)).to eq board
        end

        it 'render template edit' do
          get :edit, params: { id: board }
          expect(response).to render_template :edit
        end

      end
      context 'not owner' do
        let(:other_user) { create(:user, email: 'other@mail.com') }
        before { login(other_user) }

        it 'assigns board' do
          get :edit, params: { id: board }
          expect(assigns(:board)).to eq board
        end

        it 'redirect to root' do
          get :edit, params: { id: board }
          expect(response).to redirect_to root_path
        end
      end
    end
    context 'Guest' do

      it 'assigns board' do
        get :edit, params: { id: board }
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
    let(:board) { create(:board, user: owner_user, length: 100) }

    context 'Authenticated user' do
      context 'owner' do
        before { login(owner_user) }

        context 'with valid data can update board' do
          it 'assigns board' do
            patch :update, params: { id: board, board: { length: 250 } }
            expect(assigns(:board)).to eq board
          end

          it 'redirect to board' do
            patch :update, params: { id: board, board: { length: 250 } }
            expect(response).to redirect_to board
          end

          it 'change board count' do
            expect do
              patch :update, params: { id: board, board: { length: 250 } }
              board.reload
            end.to change(board, :length)
          end
        end
        context 'with invalid data can not update board' do
          it 'assigns board' do
            patch :update, params: { id: board, board: { length: '' } }
            expect(assigns(:board).valid?).to be_falsey
          end

          it 'render template edit' do
            patch :update, params: { id: board, board: { length: '' } }
            expect(response).to render_template :edit
          end

          it 'does not change board count' do
            expect do
              patch :update, params: { id: board, board: { length: '' } }
              board.reload
            end.to_not change(board, :length)
          end
        end
      end

      context 'not owner' do
        let(:other_user) { create(:user, email: 'other@mail.com') }
        before { login(other_user) }

        it 'assigns board' do
          patch :update, params: { id: board, board: { length: 150 } }
          expect(assigns(:board)).to eq board
        end

        it 'redirect to root' do
          patch :update, params: { id: board, board: { length: 150 } }
          expect(response).to redirect_to root_path
        end

        it 'does not change board count' do
          expect do
            patch :update, params: { id: board, board: { length: 150 } }
            board.reload
          end.to_not change(board, :length)
        end
      end
    end
    context 'Guest' do

      it 'assigns board' do
        patch :update, params: { id: board, board: { length: 150 } }
        expect(assigns(:board)).to be_nil
      end

      it 'redirect to log in' do
        patch :update, params: { id: board, board: { length: 150 } }
        expect(response).to redirect_to new_user_session_path
      end

      it 'does not change board count' do
        expect do
          patch :update, params: { id: board, board: { length: 150 } }
          board.reload
        end.to_not change(board, :length)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:owner_user) { create(:user) }
    let!(:board) { create(:board, user: owner_user) }

    context 'Authenticated user' do
      let(:other_user) { create(:user, email: 'other@mail.com') }

      context 'owner' do
        before { sign_in(owner_user) }

        it 'assigns board' do
          delete :destroy, params: { id: board }, format: :js
          expect(assigns(:board)).to eq board
        end

        it 'render template destroy' do
          delete :destroy, params: { id: board }, format: :js
          expect(assigns(:board)).to render_template :destroy
        end

        it 'change board count' do
          expect do
            delete :destroy, params: { id: board }, format: :js
          end.to change(Board, :count).by(-1)
        end
      end
      context 'not owner' do
        before { sign_in(other_user) }

        it 'assigns board' do
          delete :destroy, params: { id: board }, format: :js
          expect(assigns(:board)).to eq board
        end

        it 'return status forbidden' do
          delete :destroy, params: { id: board }, format: :js
          expect(response).to have_http_status :forbidden
        end

        it 'does not change board count' do
          expect do
            delete :destroy, params: { id: board }, format: :js
          end.to_not change(Board, :count)
        end
      end
    end
    context 'Guest' do

      it 'assigns board' do
        delete :destroy, params: { id: board }, format: :js
        expect(assigns(:board)).to be_nil
      end

      it 'return status unauthorized' do
        delete :destroy, params: { id: board }, format: :js
        expect(response).to have_http_status :unauthorized
      end

      it 'does not change board count' do
        expect do
          delete :destroy, params: { id: board }, format: :js
        end.to_not change(Board, :count)
      end
    end
  end
end
