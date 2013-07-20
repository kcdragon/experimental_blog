if Rails.env.development?
  Post.create!(title: Forgery(:lorem_ipsum).words(8),
               body: Forgery(:lorem_ipsum).paragraphs(5),
               tags: 'foo')
  Post.create!(title: Forgery(:lorem_ipsum).words(7),
               body: Forgery(:lorem_ipsum).paragraphs(10),
               tags: 'foo,bar')
  Post.create!(title: Forgery(:lorem_ipsum).words(6),
               body: Forgery(:lorem_ipsum).paragraphs(6),
               tags: 'bar,baz')
end
