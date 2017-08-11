class Game < ApplicationRecord
  belongs_to :user
  has_one :deck, dependent: :destroy

  def total_time
    total = self.end_time - self.created_at
    total.floor
  end
end
