
FactoryGirl.define do
  factory :job, :class => Refinery::Jobs::Job do
    sequence(:reference) { |n| "refinery#{n}" }
  end
end

