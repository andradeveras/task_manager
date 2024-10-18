class Task < ApplicationRecord
  after_create :send_notification
  after_update :send_notification
  enum status: { pending: 0, in_progress: 1, completed: 2, failed: 3 }

  validates :title, presence: true
  validates :url, presence: true

  def send_notification

    notification_data = {
      notification: {
        title: self.title,
        status: self.status,
        url: self.url
      }
    }

    HTTParty.post('http://localhost:3002/notifications', body: notification_data.to_json, headers: { 'Content-Type' => 'application/json' })
  end
end
