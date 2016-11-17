# encoding: utf-8
class Pass::Controller
	attr_accessor :name, :description, :part_id, :part
	def initialize attr
    raise ArgumentError, "已存在相同Controller:#{attr[:name]}" if Pass::System.controllers.any? { |c| c.name == attr[:name] }
    attr.each do |k,v|
    	self.send("#{k}=",v) if v.present??
    end
  end
end