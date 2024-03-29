require 'spec_helper'

describe "User Pages" do
  
  subject { page }
  
  describe "signup page" do
    before { visit signup_path }
    
    it { should have_selector('h1', text: 'Sign up')}
    it { should have_selector('title', text: full_title('Sign up'))}
  end
  
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }
    
    it { should have_selector('h1', text: user.name)}
    it { should have_selector('title', text: user.name)}
  end
  
  describe "signup" do
    before { visit signup_path }
    
    let(:submit) { "Create my account" }
    
    describe "with invalid info" do
      it "should not create a use" do
        expect { click_button submit }.to_not change(User, :count)
      end
    end
    
    describe "after submission" do
      before { click_button submit }
      it { should have_selector('title', text: "Sign up" )}
      it { should have_content('error')}
    end
    
    describe "with valid info" do
      before do
        fill_in "Name",                   with: "Michael Bluth"
        fill_in "Email",                  with: "michael@bluth.com"
        fill_in "Password",               with: "bananastand"
        fill_in "Confirmation",  with: "bananastand"
      end
      
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      
      describe "after saving new user" do
        before { click_button submit }
        let(:user) {User.find_by_email('michael@bluth.com')}
      
        it { should have_selector('title', text: user.name )}
        it { should have_selector('div.alert.alert-success', text: "Welcome" ) }
        it { should have_link('Sign out')}
      end
    end
  end
end
