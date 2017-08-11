class Card < ApplicationRecord

  belongs_to :deck, dependent: :destroy

end
