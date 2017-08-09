FactoryGirl.define do
  factory :game do
    sets      10
    end_time  DateTime.new(2017, 8, 8, 3)
    user      1
  end
end
