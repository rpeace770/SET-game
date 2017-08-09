class Game < ApplicationRecord
  belongs_to :user

  def total_time
    tot_t = self.end_time - self.created_at
    tot_t.floor
  end
end
