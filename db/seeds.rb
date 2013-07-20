if Rails.env.development?
  Post.create!(title: 'First Post',
               body: Forgery(:lorem_ipsum).words(50),
               tags: 'first')
  Post.create!(title: 'Another Post',
               body: Forgery(:lorem_ipsum).words(75),
               tags: '')
  Post.create!(title: 'Hello, world.',
               body: Forgery(:lorem_ipsum).words(25),
               tags: 'hello,world')
end
