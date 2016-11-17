# encoding: utf-8
class Pass::Part
	attr_accessor :id, :name, :controller, :action, :url, :hidden, :controllers, :subsystem, :selected, :icon_class
	def attributes attrs
		raise ArgumentError, "Part的id不能为空" if attr[:id].to_i == 0
		raise ArgumentError, "part:#{attr[:id]}" if Pass::System.parts.any? { |s| s.id.to_i == attr[:id].to_i }
		attrs.each do |k,v| 
			self.send("#{k}=",v) if v.present?
		end
	end

	def define_controller attr
		c = Pass::Controller.new attr
    c.part = self
    Pass::System.controllers << c
    instance_eval(c)
	end
end