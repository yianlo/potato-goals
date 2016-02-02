require 'rails_helper'

feature "display goals index for each user" do

  before(:all) { FactoryGirl.reload }
  # let(:cur_user) { FactoryGirl.create(:user) }

  before(:each) do
    #potato1
    @cur_user = sign_up_potato(User.new({username: "potato", password: "123456"}))
    FactoryGirl.create(:goal, user_id: @cur_user.id)
    visit user_url(@cur_user)
  end

  scenario "show goals" do
    expect(page).to have_content "potatoest"
  end

  feature "when signed in as author" do
    scenario "show private goals" do
      FactoryGirl.create(:private_goal, user_id: @cur_user.id)
      visit user_url(@cur_user)

      expect(page).to have_content("I secretly loathe russets")
    end

    scenario "show new goal link" do
      expect(page).to have_content("New Goal")
    end

    scenario "show edit goal link" do
      expect(page).to have_content("Edit Goal")
    end

    scenario "show delete goal link" do
      expect(page).to have_content("Delete Goal")
    end
  end


  feature "when signed in not as author" do

    before(:each) do
      click_on "Sign Out"
      #potato2
      sign_up_potato(FactoryGirl.create(:user))
      visit user_url(User.first)
    end

    scenario "does not show private goals" do
      expect(page).not_to have_content("I secretly loathe russets")
    end

    scenario "does not show new goal button" do
      expect(page).not_to have_content("New Goal")
    end

    scenario "does not show edit goal button" do
      expect(page).not_to have_content("Edit Goal")
    end

    scenario "does not delete goal button" do
      expect(page).not_to have_content("Delete Goal")
    end

  end
end
