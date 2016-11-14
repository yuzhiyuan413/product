module ApplicationHelper
	def include_body_css
    %W{
    	users/sessions 
    	users/registrations 
    	users/passwords
    }.include?(params[:controller]) || ["bind","create_bind"].include?(params[:action]) ? 
    "loginBackground" : "skin-blue sidebar-mini"
	end
end
