# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe User do
  before { @user = User.new(name: "Example User", email: "email@example.com",
                            password: "value1", password_confirmation: "value1") }
  
  subject { @user }
  
  it { should respond_to(:name)}
  it { should respond_to(:email)}
  it { should respond_to(:password_digest)}
  it { should respond_to(:password)}
  it { should respond_to(:password_confirmation)}
  it { should respond_to(:remember_token)}
  it { should respond_to(:authenticate)}
  
  it { should be_valid }
  
  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid}
  end
  
  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end
  
  describe "when a name is too long" do
    before { @user.name = "a" * 51}
    it { should_not be_valid}
  end
  
  describe "when email format is not valid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_food.org example.user@fuck. blah@blach_hal.com black@white+black.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
    end
  end
  
  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[gob@bluth.COM a_turner-1@tetco.org banana.grabber@bluth.net george+michael@bluth.co.uk]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
  end
  
  describe "when an email is taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.save
    end
    
    it { should_not be_valid }
  end
  
  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end
  
  describe "when password doesnt match confirmation" do
    before { @user.password_confirmation = "badwrong"}
    it { should_not be_valid }
  end
  
  describe "when the confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end
  
  describe "return value of auth method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email)}
    
    describe "with valid password" do
      it { should == found_user.authenticate(@user.password)}
    end
    
    describe "with invalid password" do
      let(:user_with_bad_password) { found_user.authenticate("badwrong") }
      it { should_not == user_with_bad_password }
      specify { user_with_bad_password.should be_false }
    end
  end
  
  describe "with a password thats too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end
  
  describe "remember token" do
    before {@user.save}
    its(:remember_token) { should_not be_blank }
  end
end
