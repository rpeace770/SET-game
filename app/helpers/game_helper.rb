module GameHelper

  def self.find_user(game)
    User.find(game.user_id)
  end

end
