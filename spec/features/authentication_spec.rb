require 'rails_helper'

feature "the signup process" do
  before(:all) do
    FactoryGirl.reload
  end

  let(:cur_user) { FactoryGirl.create(:user) }

  feature "sign up validations" do
    before(:each){ visit new_user_url }

    scenario "has a new user page" do
      expect(page).to have_content "Sign Up"
    end

    scenario "Doesn't allow blank username" do
      click_on "Sign Up"
      expect(page).to have_content "Username can't be blank"
    end

    scenario "Doesn't allow blank password" do
      sign_up_potato(FactoryGirl.build(:user, password: ''))

      expect(page).to have_content "Password is too short (minimum is 6 characters)"
    end

    scenario "Requires 6 character password" do
      sign_up_potato(FactoryGirl.build(:user, password: '123'))

      expect(page).to have_content "Password is too short (minimum is 6 characters)"
    end
  end


  feature "signing up a user" do

    before(:each) do
      sign_up_potato(cur_user)
    end

    scenario "redirects to goal index page after signup" do
      expect(page).to have_content "Goals!"
    end

    scenario "shows username after signup" do
      expect(page).to have_content cur_user.username
    end
  end

  feature "logging out" do
    before(:each) do
      sign_up_potato(cur_user)
    end

    scenario "shows logout button if signed in" do
      expect(page).to have_selector(:link_or_button, "Sign Out")
    end

    scenario "logs out user" do
      click_on "Sign Out"

      expect(page).not_to have_content("Sign Out")
      expect(page).to have_content "Sign In"
    end
  end

  feature "logging in" do
    before(:each) do
      sign_up_potato(cur_user)
      click_on "Sign Out"
      click_on "Sign In"
    end

    scenario "Displays login page" do
      expect(page).to have_content "Sign In"
      expect(page).to have_content "Username"
      expect(page).to have_content "Password"
    end

    feature "invalid log in credentials" do
      before(:each) do
        sign_in_potato(FactoryGirl.build(:user, password: '1231322342'))
      end

      scenario "Circles back if wrong login" do
        expect(page).to have_content "Sign In"
        expect(page).to have_content "Username"
        expect(page).to have_content "Password"
      end

      scenario "Alert user of invalid credentials" do
        expect(page).to have_content "Invalid Credentials"
      end

    end

    feature "Correct log in" do
      before(:each) do
        sign_in_potato(cur_user)
      end

      scenario "Logs in correctly" do
        expect(page).to have_selector(:link_or_button, "Sign Out")
        expect(page).to have_content cur_user.username
      end

      scenario "Directs to goal index page" do
        expect(page).to have_content "Goals!"
      end
    end

  end
end
