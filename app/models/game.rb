class Game < ApplicationRecord
  belongs_to :user

  def total_time
    total = self.end_time - self.created_at
    total.floor
  end
end
