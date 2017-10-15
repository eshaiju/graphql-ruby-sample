class Article < ApplicationRecord
  has_many :comments

  DEFAULT_LIMIT = 15
end
