FactoryGirl.define do
  factory :post do
    name { "Delivering Goods" }
    content { "In order to deliver goods, you should..." }

    factory :invalid_post do
      name { nil }
    end
  end
end
