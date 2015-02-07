class Article < ActiveRecord::Base
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings

  def tag_list
    tags.map{ |t| t.name }.join(", ")
  end

  def tag_list=(tags_string)
    tag_names = tags_string.split(",").collect do
      |s| s.strip.downcase
    end.uniq

    new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
    self.tags = new_or_found_tags

  end
end

article = Article.create(title: "A Sample Article for Tagging!", body: "Great article goes here", tag_list: "ruby, technology")
