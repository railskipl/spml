json.array!(@meter_reader_statuses) do |meter_reader_status|
  json.extract! meter_reader_status, :description
  json.url meter_reader_status_url(meter_reader_status, format: :json)
end