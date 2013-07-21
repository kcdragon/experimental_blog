if Rails.env.development?
  Post.create!(title: Forgery(:lorem_ipsum).words(8),
               body: Forgery(:lorem_ipsum).paragraphs(5),
               tags: 'foo',
               created_at: DateTime.new(2013, 7, 19))
  Post.create!(title: Forgery(:lorem_ipsum).words(7),
               body: Forgery(:lorem_ipsum).paragraphs(10),
               tags: 'foo,bar',
               created_at: DateTime.new(2013, 7, 20))
  Post.create!(title: Forgery(:lorem_ipsum).words(6),
               body: Forgery(:lorem_ipsum).paragraphs(6),
               tags: 'bar,baz',
               created_at: DateTime.new(2013, 7, 21))
end
