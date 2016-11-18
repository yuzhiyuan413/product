# encoding: utf-8
class Pass::Subsystem
	attr_accessor :id, :name, :parts, :icon_class, :controller, :action, :sort, :hidden
	def attributes attrs
		raise ArgumentError, "已存在相同subsystem:#{attrs[:id]}" if Pass::System.subsystems.any? { |s| s.id.to_i == attrs[:id].to_i }
		attrs.each do |k,v| 
			self.send("#{k}=",v) if v.present?
		end
	end

	def define_part name, &block
		p = Pass::Part.new
		p.name = name
		p.subsystem = self
		Pass::System.parts << p
		p.instance_eval(&block) if block_given?
	end


end