Pass::System.define_subsystem "商铺" do 
	attributes id: 10, controller: "", action: "left", sort: "1", hidden: 0, icon_class: "" 
	define_part "商铺" do 
		attributes id: 11, controller: "", action: "index", sort: "10", hidden: 0, icon_class: "" 
		define_controller name: "", description: "商铺", part_id: 11
	end

	define_part "产品" do 
		attributes id: 12, controller: "", action: "index", sort: "10", hidden: 0, icon_class: "" 
		define_controller name: "", description: "产品", part_id: 12
	end

	define_part "订单" do 
		attributes id: 13, controller: "", action: "index", sort: "10", hidden: 0, icon_class: "" 
		define_controller name: "", description: "订单", part_id: 13
	end
end