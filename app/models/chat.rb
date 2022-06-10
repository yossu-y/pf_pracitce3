class Chat < ApplicationRecord
  
  belongs_to :group, dependent: :destroy
  
end
