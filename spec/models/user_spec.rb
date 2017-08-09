require 'rails_helper'

RSpec.describe User, type: :model do
  describe "user attributes" do
    let!(:user) { FactoryGirl.create(:user) }

    it "has a username" do
      expect(user.username).to eq("thisisusername")
    end

    it "has a email" do
      expect(user.email).to eq("email@example.com")
    end
  end

  describe "user validations" do
    context "user inputs valid information" do
      let!(:user) { FactoryGirl.create(:user) }

      it "is valid when there is a username" do
        expect(user.errors[:username]).to be_empty
      end

      it "is valid when there is a email" do
        expect(user.errors[:email]).to be_empty
      end
    end

    context "user inputs invalid information" do
      let!(:user) { User.create }

      it "fails validation when there is no username" do
        expect(User.new).to have(1).error_on(:username)
      end

      it "is invalid when there is no password" do
        expect(User.new).to have(1).error_on(:password)
      end

      it "fails validation with password less than 6 characters" do
        expect(User.new(:password => "123")).to have(1).error_on(:password)
      end

      it "is invalid when there is no email" do
        expect(User.new).to have(2).error_on(:email)
        # 2 error messages for email ["can't be blank", "add a email! "]
      end
    end
  end

  describe "user associations" do
    # let!(:user) { FactoryGirl.create(:user) }

    # this one is NOT working
    # it "has many games" do
    #   relation = user.reflect_on_all_associations(:has_many)
    #   expect(reflection).to eq :has_many
    # end
  end


end
