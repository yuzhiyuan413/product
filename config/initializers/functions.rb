Pass::System.define_subsystem "商铺" do 
	attributes id: 10, controller: "/products/index", action: "left", sort: "1", hidden: 0, icon_class: "" 
	define_part "商铺" do 
		attributes id: 11, controller: '/shops/index', action: "index", sort: "10", hidden: 0, icon_class: "" 
		define_controller name: '/shops/index', description: "商铺", part_id: 11
	end

	define_part "产品" do 
		attributes id: 12, controller: '/products/index', action: "index", sort: "10", hidden: 0, icon_class: "" 
		define_controller name: '/products/index', description: "产品", part_id: 12
	end

	define_part "订单" do 
		attributes id: 13, controller: '/orders/index', action: "index", sort: "10", hidden: 0, icon_class: "" 
		define_controller name: '/orders/index', description: "订单", part_id: 13
	end
end