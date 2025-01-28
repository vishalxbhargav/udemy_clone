class Chapter < ApplicationRecord
    belongs_to :course
    has_one_attached :video
    has_many_attached :docs

   
end
