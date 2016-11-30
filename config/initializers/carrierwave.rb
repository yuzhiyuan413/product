CarrierWave.configure do |config|
  config.storage = :file
  config.permissions = 0600
  config.directory_permissions = 0700
  config.root = Rails.root
  config.store_dir = "uploads"
end