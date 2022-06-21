package dao;

import java.sql.SQLException;

import java.util.List;

import helper.DaoHelper;
import vo.Product;

public class OrderDao {

	private static OrderDao instance = new OrderDao();

	private OrderDao() {}
	public static OrderDao getInstance() {
		return instance;
	}
	
	private DaoHelper helper = DaoHelper.getInstance();
	
	public int getOrderCount(int userNo) throws SQLException {
		String sql = "select count(*) cnt "
					+"from sul_orders "
					+"where order_deleted = 'N' "
					+"and user_no = ? ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		}, userNo);
	}

	
	public List<Product> getOrderProductsByUserNo(int userNo) throws SQLException {
		String sql = "select p.pd_no, p.category_no, p.pd_name "
					+"from sul_orders o, sul_order_items i, sul_products p "
					+"where o.order_no = i.order_no "
					+"and i.pd_no = p.pd_no "
					+"and o.user_no = ? "
					+"and o.order_deleted = 'N' "
					+"and i.order_item_deleted = 'N' ";
		
		return helper.selectList(sql, rs -> {
			Product product = new Product();
			product.setNo(rs.getInt("pd_no"));
			product.setCategoryNo(rs.getInt("category_no"));
			product.setName(rs.getString("pd_name"));
			
			return product;
		}, userNo);
	}

}
