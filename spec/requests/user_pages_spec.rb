require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "Profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }

    describe "with invalid information" do
 
       describe "after submission" do
        before { click_button submit }

        it { should have_title('Sign up') }
        it { should have_content('error') }
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end

       describe "after saving the user" do
         before { click_button submit }
         let(:user) { User.find_by(email: 'user@example.com') }

         it { should have_link('Sign out') }
         it { should have_title(user.name) }
         it { should have_selector('div.alert.alert-success', text: 'Welcome') }
       end
    end
  end
end