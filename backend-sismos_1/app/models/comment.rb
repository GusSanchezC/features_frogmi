class Comment < ApplicationRecord
    belongs_to :feature, foreign_key: 'feature_id', primary_key: 'id'
    validates :body, presence: true
end
