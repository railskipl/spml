json.array!(@teams) do |team|
  json.extract! team, :team_name, :user_role_id
  json.url team_url(team, format: :json)
end