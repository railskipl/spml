json.array!(@meter_statuses) do |meter_status|
  json.extract! meter_status, :billing_meter_status
  json.url meter_status_url(meter_status, format: :json)
end