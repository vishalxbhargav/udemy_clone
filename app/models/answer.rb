class Answer < ApplicationRecord
    has_many :comments,dependent: :destroy
end
