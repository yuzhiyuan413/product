# encoding: utf-8
class Pass::Part
	attr_accessor :id, :sort, :name, :controller, :action, :url, :hidden, :controllers, :subsystem, :selected, :icon_class
	def attributes attrs
		raise ArgumentError, "Part的id不能为空" if attrs[:id].to_i == 0
		raise ArgumentError, "part:#{attrs[:id]}" if Pass::System.parts.any? { |s| s.id.to_i == attrs[:id].to_i }
		attrs.each do |k,v| 
			self.send("#{k}=",v) if v.present?
		end
	end

	def define_controller attr, &block
		c = Pass::Controller.new attr
    c.part = self
    Pass::System.controllers << c
    c.instance_eval(&block) if block_given?
	end
end