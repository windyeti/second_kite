require 'rails_helper'

feature 'Admin can see list unapproved ads', js: true do
  describe '' do
    given!(:user) {create(:user, email: 'user@mail.com')}
    given!(:params_unapproved) { attributes_for(:kite, brand: 'Unapproved_Brand', madel: 'Unapproved_Model') }
    given!(:kite_unapproved) { Kite.custom_create(params_unapproved, user) }
    given!(:params_ad_unapproved) { { kite_ids: [kite_unapproved.id], board_ids: [], bar_ids: [], stuff_ids: [] } }

    given!(:ad_unapproved) { create(:ad, title: 'TITLE Unapproved', kite_ids: [kite_unapproved.id], user: user, approve: Ad.approve?(params_ad_unapproved)) }

    given!(:brand_approved) { create(:brand, name: 'Approve_Brand', approve: true) }
    given!(:model_approved) { create(:kite_name, brand: brand_approved, name: 'Approve_Model', approve: true) }
    given!(:params_approved) { attributes_for(:kite, brand: brand_approved.name, madel: model_approved.name) }
    given!(:kite_approved) { Kite.custom_create(params_approved, user) }
    given!(:params_ad_approved) { { kite_ids: [kite_approved.id], board_ids: [], bar_ids: [], stuff_ids: [] } }

    given!(:ad_approved) { create(:ad, title: 'TITLE Approved', kite_ids: [kite_approved.id], user: user, approve: Ad.approve?(params_ad_approved)) }

    given(:admin) { create(:user, role: 'Admin', email: 'admin@mail.com') }
    background { sign_in(admin) }
    scenario 'Admin can see list' do

        visit root_path
        click_on 'Proofs'

        expect(page).to have_content ad_unapproved.title
        expect(page).to_not have_content ad_approved.title

        click_on ad_unapproved.title

        within ".item-for-approve.Brand_id_#{kite_unapproved.kite_name.brand.id}" do
          click_on 'approve'
        end

        expect(page).to have_content "Brand: Unapproved_Brand (approve:true)"
    end
  end
end
