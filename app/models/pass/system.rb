# encoding: utf-8
class System

	def self.subsystems
    @subsystems ||= []
  end

  def self.parts
    @parts ||= []
  end

  def self.controllers
    @controllers ||= []
  end

	def self.define_subsystem name 
		raise ArgumentError, "已存在相同subsystem:#{name}" if subsystems.any? { |s| s.name == name}
		s = Pass::Subsystem.new
		s.name = name
		instancn_eval(s)
	end
end