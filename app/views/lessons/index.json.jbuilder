json.array!(@lessons) do |lesson|
  json.extract! lesson, :id, :start_date, :users_allowed, :name
  json.url lesson_url(lesson, format: :json)
end
