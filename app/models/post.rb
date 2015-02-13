class Post < ActiveRecord::Base
  validates :title, :sub, :author, presence: true
  validates :title, uniqueness: { scope: :sub_id }
  belongs_to :sub, inverse_of: :posts
  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id,
    inverse_of: :posts
  )

  def author_name
    author.username
  end

  def sub_name
    sub.title
  end

  def author_id
    author.id
  end
end
