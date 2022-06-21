package dao;

import java.sql.SQLException;

import helper.DaoHelper;

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
}
