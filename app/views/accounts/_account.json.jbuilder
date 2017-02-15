json.extract! account, :id, :number, :status, :balance, :created_at, :updated_at
json.url account_url(account, format: :json)