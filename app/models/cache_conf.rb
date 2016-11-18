class CacheConf
	include Singleton
	def initialize(path = nil)
		file_path = path.nil? ? "config/cache.yml" : path
		@cache_conf = YAML.load_file(Rails.root.join(file_path))
	end

	def [](key)
		@cache_conf[Rails.env][key.to_s]
	end 
end