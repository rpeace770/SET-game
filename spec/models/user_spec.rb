require 'rails_helper'

RSpec.describe User, type: :model do
  describe "user attributes" do
    it "has a username" do
      user = FactoryGirl.create(:user)
      expect(user.username).to eq("thisisusername")
    end

    it "has a email" do
      user = FactoryGirl.create(:user)
      expect(user.email).to eq("email@example.com")
    end
  end


  describe "user validations" do
    context "user inputs valid information" do
      before(:each) { user = FactoryGirl.create(:user) }

      it "is valid when there is a username" do
        expect(user.errors[:username]).to be_empty
      end

      it "is valid when there is a email" do
        expect(user.errors[:email]).to be_empty
      end
    end

    context "user inputs invalid information" do
      before(:each) { user = User.create }

      it "is invalid when there is no username" do
        expect(user.errors[:username]).to_not be_empty
      end

      it "is invalid when there is no email" do
        expect(user.errors[:email]).to_not be_empty
      end
    end
  end
end
