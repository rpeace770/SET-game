class Game < ApplicationRecord
  belongs_to :user

  def total_time
    self.end_time - self.created_at
  end
end
