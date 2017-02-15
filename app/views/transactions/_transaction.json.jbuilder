json.extract! transaction, :id, :type, :amount, :status, :from, :to, :start_date, :eff_date, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)