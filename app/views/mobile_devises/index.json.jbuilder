json.array!(@mobile_devises) do |mobile_devise|
  json.extract! mobile_devise, :imei, :manufacturer_name, :purchase_date, :phone_no
  json.url mobile_devise_url(mobile_devise, format: :json)
end