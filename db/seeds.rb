if Rails.env.development?
  Post.create!(title: 'First Post', body: 'Here is my first post.', tags: 'first')
  Post.create!(title: 'Another Post', body: 'Here is another post.', tags: '')
  Post.create!(title: 'Hello, world.', body: 'Hello everyone.', tags: 'hello,world')
end
