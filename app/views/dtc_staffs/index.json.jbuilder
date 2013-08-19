json.array!(@dtc_staffs) do |dtc_staff|
  json.extract! dtc_staff, :consumer_id, :user_id
  json.url dtc_staff_url(dtc_staff, format: :json)
end