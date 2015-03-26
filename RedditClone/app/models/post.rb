class Post < ActiveRecord::Base
  validates :title, :postings, :author, presence: true

  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id,
    inverse_of: :posts
  )

  has_many :postings, dependent: :destroy, inverse_of: :post
  has_many :subs, through: :postings, source: :sub, inverse_of: :posts

  has_many :comments, inverse_of: :post, dependent: :destroy
  has_many :commenters, through: :comments, source: :author

  def author_name
    author.username
  end

  def sub_name
    sub.title
  end

  def author_id
    author.id
  end

  def top_level_comments
    self.comments.where(parent_id: nil)
  end

  def comments_by_parent_id
    comments = self.comments.includes(:author)

    hashed_comments = Hash.new { |h, k| h[k] = []}

    comments.each do |comment|
      hashed_comments[comment.parent_id] << comment
    end

    hashed_comments
  end

end
