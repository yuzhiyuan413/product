# encoding: utf-8
class Pass::System

	def self.subsystems
    @subsystems ||= []
  end

  def self.parts
    @parts ||= []
  end

  def self.controllers
    @controllers ||= []
  end

	def self.define_subsystem name, &block
		raise ArgumentError, "已存在相同subsystem:#{name}" if subsystems.any? { |s| s.name == name}
		s = Pass::Subsystem.new
		s.name = name
    self.subsystems << s
		s.instance_eval(&block) if block_given?
	end
end