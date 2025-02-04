class Question < ApplicationRecord
  belongs_to :user
  belongs_to :forume
  has_many :answers, dependent: :destroy
end
