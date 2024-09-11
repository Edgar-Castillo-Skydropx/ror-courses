json.extract! question, :id, :lesson_id, :content, :created_at, :updated_at
json.url question_url(question, format: :json)
