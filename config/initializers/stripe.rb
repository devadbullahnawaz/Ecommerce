Rails.configuration.stripe = {
  :publishable_key => ENV['secret'],
  :secret_key      => ENV['public']
}

Stripe.api_key = Rails.application.credentials[:stripe][:secret]
