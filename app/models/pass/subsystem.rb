# encoding: utf-8
class Pass::Subsystem
	attr_accessor :id, :name, :parts, :icon_class, :controller, :action, :sort, :hidden
	def attributes attrs
		raise ArgumentError, "已存在相同subsystem:#{attr[:id]}" if Pass::System.subsystems.any? { |s| s.id.to_i == attr[:id].to_i }
		attrs.each do |k,v| 
			self.send("#{k}=",v) if v.present?
		end
	end

	def define_part name
		p = Pass::Part.new
		p.name = name
		p.subsystem = self
		parts << p
		instance_eval(p)
	end

	
end