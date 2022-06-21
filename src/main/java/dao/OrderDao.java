package dao;

import helper.DaoHelper;

public class OrderDao {
	public static OrderDao instance = new OrderDao();
	private OrderDao() {}
	public static OrderDao getInstance() {
		return instance;
	}
	
	DaoHelper helper = DaoHelper.getInstance();
	
	// 
}
