FactoryGirl.define do
  factory :user do # The name matters. :cat factory returns a Cat object.
    username ('potato'.concat((0..10000).to_a.sample.to_s))
    password '123456'
  end
end
