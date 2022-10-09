class Task < ApplicationRecord
  belongs_to :users, optional: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :detail, presence: true, length: {maximum: 100 }
end
