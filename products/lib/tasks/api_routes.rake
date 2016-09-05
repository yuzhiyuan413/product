desc "API Routes"
task :api_routes => :environment do
   ApplicationAPI.routes.each do |api|
    prefix = '/api'
    method = api.request_method.ljust(10)
    path = api.path
    puts "     #{method} #{prefix}#{path}"
  end
end