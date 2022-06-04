class Tag < ApplicationRecord
  
  has_many :article_tags, dependent: :destroy, foreign_key: "tag_id"
  has_many :articles, through: :article_tags
  
  
  def self.search_books_for(content, method)
    
    if method == 'perfect'
      tags = Tag.where(name: content)
    elsif method == 'forward'
      tags = Tag.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      tags = Tag.where('name LIKE ?', '%' + content)
    else
      tags = Tag.where('name LIKE ?', '%' + content + '%')
    end
    
    return tags.inject(init = []) {|result, tag| result + tag.articles}
    
  end
  
end
