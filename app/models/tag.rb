class Tag < ApplicationRecord
  
  has_many :article_tags, dependent: :destroy, foreign_key: "tag_id"
  has_many :articles, through: :article_tags
  
  def self.search(search, keyword)
    if search != ""
      Tag.where(['name LIKE(?)', "%#{search}%"])
    else
      Tag.all
    end
  end
  
end
