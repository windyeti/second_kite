require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do

  describe "DELETE #destroy" do

    context 'Authenticated user owner kite' do
      let!(:owner_user) { create(:user) }
      let!(:kite) { create(:kite, :with_attachments, user: owner_user) }
      let!(:attachment) { kite.best_photos[0] }
      before { login(owner_user) }

      it "assigns file" do
        delete :destroy, params: { id: attachment }, format: :js
        expect(assigns(:attachment)).to eq attachment
      end

      it 'change attachments count' do
        expect do
          delete :destroy, params: { id: attachment }, format: :js
        end.to change(ActiveStorage::Attachment, :count).by(-1)
      end
    end

    context 'Authenticated user not owner kite' do

    end
  end

end
