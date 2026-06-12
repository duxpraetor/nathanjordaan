json.extract! contact, :id, :full_name, :company_name, :email, :message, :created_at, :updated_at
json.url contact_url(contact, format: :json)
