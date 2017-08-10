module AnonymousUserHelper

  def self.anonymous
    number = User.last.id + 1
    User.create!(email: "#{number}@example.com", password: "123123", username: "#{number}")
  end
end
