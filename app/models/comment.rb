class Comment < ApplicationRecord
  belongs_to :startup
  belongs_to :user
end
