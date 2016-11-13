module ApplicationHelper
	def include_body_css
    %W{
    	users/sessions 
    	users/registrations 
    	devise/passwords
    }.include?(params[:controller]) || ["bind","create_bind"].include?(params[:action]) ? 
    "loginBackground" : "skin-blue layout-top-nav"
	end
end
