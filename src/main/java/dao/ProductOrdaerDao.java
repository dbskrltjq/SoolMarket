package dao;

import java.sql.SQLException;

import helper.DaoHelper;

public class ProductOrdaerDao {
	
	private static ProductOrdaerDao instance = new ProductOrdaerDao();
	private ProductOrdaerDao() {}
	public static ProductOrdaerDao getInstance() {
		return instance;
	}
	
	private DaoHelper helper = DaoHelper.getInstance();
	
	public int getOrderCount(int productNo,int userNo) throws SQLException {
		String sql = "select count(*) cnt "
				+ "from sul_orders O, sul_order_items I "
				+ "where O.order_no = I.order_no "
				+ "and I.pd_no = ? "
				+ "and O.user_no = ? ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
			
		},productNo,userNo);
	}
}
