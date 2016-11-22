Pass::System.define_subsystem "商铺" do 
	attributes id: 10, controller: "/products", action: "left", sort: "1", hidden: 0, icon_class: "" 
	define_part "商铺" do 
		attributes id: 11, controller: '/shops', action: "index", sort: "10", hidden: 0, icon_class: "" 
		define_controller name: '/shops', description: "商铺", part_id: 11
	end

	define_part "产品" do 
		attributes id: 12, controller: '/products', action: "index", sort: "10", hidden: 0, icon_class: "" 
		define_controller name: '/products', description: "产品", part_id: 12
	end

	define_part "订单" do 
		attributes id: 13, controller: '/orders', action: "index", sort: "10", hidden: 0, icon_class: "" 
		define_controller name: '/orders', description: "订单", part_id: 13
	end
end