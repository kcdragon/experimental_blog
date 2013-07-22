if Rails.env.development?

  # see http://jroller.com/obie/entry/random_times_for_rails
  class DateTime
    def self.random(params={})
      years_back = params[:year_range] || 5
      year = (rand * (years_back)).ceil + (Time.now.year - years_back)
      month = (rand * 12).ceil
      day = (rand * 31).ceil
      series = [date = Time.local(year, month, day)]
      if params[:series]
        params[:series].each do |some_time_after|
          series << series.last + (rand * some_time_after).ceil
        end
        return series
      end
      date
    end
  end

  TAGS = ['ruby', 'rails', 'mongodb', 'mongoid', 'nosql']
  100.times do |i|
    tags = (0..(rand(3)+1)).to_a.inject(Set.new) do |set, i|
      set << TAGS[rand(TAGS.length)]
      set
    end.to_a.join(',').chomp(',')
    date = DateTime.random(year_range: 3)
    date = date.change(year: date.year - 1)
    Post.create!(title: Faker::Lorem.words(rand(5) + 5).map(&:capitalize).join(" ").chomp(" "),
                 body: Faker::Lorem.paragraphs(rand(5) + 5).join("\n\n").chomp("\n\n"),
                 tags: tags,
                 created_at: date)
  end
end
