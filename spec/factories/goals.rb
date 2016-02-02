FactoryGirl.define do
  factory :goal do # The name matters. :cat factory returns a Cat object.
    content "Be the potatoest potato!"
    user_id 1
    privacy false

    factory :private_goal do
      content "I secretly loathe russets"
      privacy true
    end

  end
end
