module ApplicationHelper
	def include_body_css
    %W{
    	users/sessions 
    	users/registrations 
    	devise/passwords
    }.include?(params[:controller]) ? 
    "loginBackground" : ""
	end
end
