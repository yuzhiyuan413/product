class Student < ActiveRecord::Base
	establish_connection "pg_#{Rails.env}".to_sym
  self.table_name = "public.students"
end
