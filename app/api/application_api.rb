class ApplicationAPI < Grape::API
  version "v1", :using => :path
  format :json
  	# guard_all!
	rescue_from :all
		error_formatter :json, ->(message, backstrace, options, env) do
			{
				status: 'failed',
				message: message,
			}
		end
  mount Pd::CommonAPI
end
