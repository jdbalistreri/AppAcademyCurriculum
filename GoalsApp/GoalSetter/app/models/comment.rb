class Comment < ActiveRecord::Base
  validates :body, :author, :commentable, presence: true

  belongs_to :commentable, polymorphic: true

  belongs_to :author,
    class_name: "User",
    primary_key: :id,
    foreign_key: :author_id,
    inverse_of: :authored_comments

  def author_name
    author.username
  end
end
