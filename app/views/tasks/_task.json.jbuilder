json.extract! task, :id, :title, :status, :url, :created_at, :updated_at
json.url task_url(task, format: :json)
