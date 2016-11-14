module ApplicationHelper
	def include_body_css
    %W{
    	users/sessions 
    	users/registrations 
    	users/passwords
    }.include?(params[:controller]) || ["bind","create_bind"].include?(params[:action]) ? 
    "loginBackground" : "hold-transition skin-blue sidebar-mini"
	end
end
