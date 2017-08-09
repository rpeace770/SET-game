require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:game) { FactoryGirl.create(:game) }

  describe "game attributes" do
    it "has a number of sets" do
      expect(game.sets).to eq("10")
    end

    it "has an end time" do
      pendingexpect(user.end_time).to eq("email@example.com")
    end

    it "has a user" do
      expect(user.user_id).to eq(1)
    end
  end

  describe "game associations" do
    it "belongs to many users" do
      t = game.reflect_on_association(:user)
      expect(game).to eq(:belongs_to)
    end
  end

  # describe "game validations" do
  #   context "user inputs valid information" do
  #     before(:each) { user = FactoryGirl.create(:user) }

  #     it "is valid when there is a username" do
  #       expect(user.errors[:username]).to be_empty
  #     end

  #     it "is valid when there is a email" do
  #       expect(user.errors[:email]).to be_empty
  #     end
  #   end

  #   context "user inputs invalid information" do
  #     before(:each) { user = User.create }

  #     it "is invalid when there is no username" do
  #       expect(user.errors[:username]).to_not be_empty
  #     end

  #     it "is invalid when there is no email" do
  #       expect(user.errors[:email]).to_not be_empty
  #     end
  #   end
  # end
end
