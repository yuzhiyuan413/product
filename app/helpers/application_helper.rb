module ApplicationHelper
	def include_body_css
    %W{
    	users/sessions 
    	users/registrations 
    	users/passwords
    }.include?(params[:controller]) || ["bind","create_bind"].include?(params[:action]) ? 
    "loginBackground" : ""
	end

	def main_sidebar
		html = ""
		Pass::System.controllers.each do |c|
			html += '<li ><a href='+c.name+'><i class="fa fa-book"></i><span>'+c.description+'</span></a></li>'
		end
		html.html_safe
	end
end
