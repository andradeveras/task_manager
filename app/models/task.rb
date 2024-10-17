class Task < ApplicationRecord
  enum status: { pending: 0, in_progress: 1, completed: 2, failed: 3 }

  validates :title, presence: true
  validates :url, presence: true
end
