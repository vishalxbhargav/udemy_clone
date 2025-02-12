class Order < ApplicationRecord
  belongs_to :user
  belongs_to :course

  validates :transaction_id, presence: true
  enum :status,[:failed,:success]

  scope :last_month, -> {where('created_at >= ?',1.month.ago.beginning_of_month).where('created_at <= ?',1.month.ago.end_of_month)}
end
