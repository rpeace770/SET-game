require "rails_helper"

RSpec.describe "Routing to the application", :type => :routing do
  it "routes GET /games to games#index" do
    expect(:get => "/games").to route_to("games#index")
  end
end
