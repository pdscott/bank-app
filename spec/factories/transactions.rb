FactoryGirl.define do
  factory :transaction do
    type ""
    amount 1.5
    status "MyString"
    from 1
    to 1
    start_date "2017-02-11 20:29:35"
    eff_date "2017-02-11 20:29:35"
  end
end
