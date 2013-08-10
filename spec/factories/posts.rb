FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.words(1) }
    body { Faker::Lorem.words(1) }

    factory :post_one, class: Post do
      tags 'one'
      created_at DateTime.new(2013, 7, 31)
    end

    factory :post_two, class: Post do
      tags 'one,two'
      created_at DateTime.new(2013, 7, 1)
    end

    factory :post_three, class: Post do
      tags 'one,three'
      created_at DateTime.new(2013, 6, 1)
    end

    factory :post_four, class: Post do
      tags 'two,three'
      created_at DateTime.new(2012, 7, 1)
    end
  end
end
