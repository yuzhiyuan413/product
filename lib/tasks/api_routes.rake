# desc "API Routes"
# task :api_routes => :environment do
#    ApplicationAPI.routes.each do |api|
#     prefix = '/api'
#     method = api.request_method.ljust(10)
#     path = api.path
#     puts "     #{method} #{prefix}#{path}"
#   end
# end


desc "API Routes"
task :api_routes => :environment do
	mapping = method_mapping
	grape_klasses = ObjectSpace.each_object(Class).select { |klass| klass < Grape::API }
  routes = grape_klasses.flat_map(&:routes).
    uniq { |r| r.send(mapping[:path]) + r.send(mapping[:method]).to_s }
   #ApplicationAPI.routes.each
  routes.each do |api|
    prefix = '/api'
    method = api.request_method.ljust(10)
    path = api.path
    puts "     #{method} #{prefix}#{path}"
  end
end