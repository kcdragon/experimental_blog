class PostDecorator < Draper::Decorator
  delegate_all

  def date
    created_at.strftime "%-m/%-d/%Y"
  end
end
