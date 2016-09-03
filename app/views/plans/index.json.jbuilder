json.array!(@plans) do |plan|
  json.extract! plan, :id, :name, :lessons, :price, :start_hour, :end_hour
  json.url plan_url(plan, format: :json)
end
