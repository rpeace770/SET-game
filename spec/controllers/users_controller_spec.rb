require 'rails_helper'

describe UsersController do
  # let!(:game) { Game.create!(user_throw: Game::THROWS.sample) }

  # describe "GET #index" do
  #   it "responds with status code 200" do
  #     get :index
  #     expect(response.status).to eq 200
  #   end

  #   it "displays the top 10 games on homepage" do
  #     get :index
  #     expect(assigns(:games)).to eq (Game.top_ten)
  #   end

  #   it "renders the :index template" do
  #     get :index
  #     expect(response).to render_template(:index)
  #   end
  # end

  # describe "GET #show" do
  #   it "responds with status code 200" do
  #     get :show, { id: game.id }
  #     expect(response).to have_http_status 200
  #   end

  #   it "assigns the correct game as @game" do
  #     get :show, { id: game.id }
  #     expect(assigns(:game)).to eq(game)
  #   end

  #   it "renders the :show template" do
  #     get :show, { id: game.id }
  #     expect(response).to render_template(:show)
  #   end
  # end

  # describe "GET #new" do
  #   it "responds with status code 200" do
  #     get :new
  #     expect(response.status).to eq 200
  #   end

  #   it "assigns a new game to @game" do
  #     get :new
  #     expect(assigns(:game)).to be_a_new Game
  #   end

  #   it "renders the :new template" do
  #     get :new
  #     expect(response).to render_template(:new)
  #   end
  # end

  # describe "POST #create" do
  #   context "when valid params are passed" do
  #     let(:valid_attributes) {
  #       { user_throw: "rock", computer_throw: "paper" }
  #     }

  #     let(:game) {
  #       game = Game.create! valid_attributes
  #     }

  #     it "responds with status code 302" do
  #       post :create, { game: valid_attributes }
  #       expect(response).to have_http_status 302
  #     end

  #     it "creates a new game in the database" do
  #       expect{
  #         post :create, { game: valid_attributes }
  #       }.to change(Game, :count)
  #     end

  #     it "assigns the newly created game as @game" do
  #       post :create, { game: valid_attributes }
  #       expect(assigns(:game)).to eq (Game.last)
  #     end

  #     it "sets a notice that the game was successfully created" do
  #       post :create, { game: valid_attributes }
  #       expect(flash[:notice]).to eq("Game was successfully created.")
  #     end

  #     it "redirects to the created game" do
  #       post :create, { game: valid_attributes }
  #       expect(response).to redirect_to game_path(assigns(:game))
  #     end
  #   end

  #   context "when invalid params are passed" do
  #     it "responds with status code 422: Unprocessable Entity" do
  #       post :create, { game: { user_throw: "pineapple" } }
  #       expect(response).to have_http_status 422
  #     end

  #     it "does not create a new game in the database" do
  #       expect{
  #         post :create, { game: { user_throw: "pineapple" } }
  #       }.to_not change(Game, :count)
  #     end

  #     it "assigns the unsaved game as @game" do
  #       post :create, { game: { user_throw: "pineapple" } }
  #       expect(assigns(:game)).to be_a_new Game
  #     end

  #     it "renders the :new template" do
  #       post :create, { game: { user_throw: "pineapple" } }
  #       expect(response).to render_template(:new)
  #     end
  #   end
  # end

  # describe "DELETE #destroy" do
  #   it "responds with status code 302" do
  #     delete :destroy, { id: game.id }
  #     expect(response).to have_http_status 302
  #   end

  #   it "destroys the requested game" do
  #     expect { delete(:destroy, { id: game.id }) }.to change(Game, :count).by(-1)
  #   end

  #   it "sets a notice that the game was destroyed" do
  #     delete :destroy, { id: game.id }
  #     expect(flash[:notice]).to match /Game was successfully destroyed/
  #   end

  #   it "redirects to the games list" do
  #     delete :destroy, { id: game.id }
  #     expect(response).to redirect_to games_url

  #   end
  # end
end
