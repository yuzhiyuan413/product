class ApplicationAPI < Grape::API
  include APIGuard
  version "v1", :using => :path
  format :json
  	# guard_all!
  rescue_from :all
  error_formatter :json, ->(message, backstrace, options, env) do
	{
		status: 'failed',
		message: message,
		# error_code: '0000'
	}
  end
  mount Pd::CommonAPI
  
end
