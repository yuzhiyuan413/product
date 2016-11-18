class CacheConf
	def initialize(path = nil)
		file_path = path.nil? ? "config/cache.yml" : path
		@cache_conf = YAML.load_file(Rails.root.join(file_path))
	end
end