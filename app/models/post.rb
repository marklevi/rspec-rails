class Post < ActiveRecord::Base
  attr_accessible :title, :content, :is_published, :slug

  scope :recent, order: "created_at DESC", limit: 5

  before_save :titleize_title, :create_slug

  validates_presence_of :title, :content

  private

  def titleize_title
    self.title = title.titleize
  end

  def create_slug
    self.slug = title.parameterize
    # self.title = title.downcase.gsub!(/[^\w ]/,"").gsub!(/\s/,"-")
  end

end
