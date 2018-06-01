class Todo < ApplicationRecord
  #validates :name, presence: true
  #validates :description, prescence: true
  
  belongs_to :user
end