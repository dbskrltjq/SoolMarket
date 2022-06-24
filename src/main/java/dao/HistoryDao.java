package dao;

import java.sql.SQLException;

import helper.DaoHelper;
import vo.PointHistory;

public class HistoryDao {
	
	private static HistoryDao instance = new HistoryDao();
	private HistoryDao() {}
	public static HistoryDao getInstance() {
		return instance;
	}
	
	private DaoHelper helper = DaoHelper.getInstance();

	// 포인트가 사용 / 적립될 때마다 사용되는 메소드이다.
	public void insertPointHistory(PointHistory history) throws SQLException {
		String sql = "insert into SUL_POINT_HISTORY "
				   + "(POINT_HISTORY_NO, USER_NO, ORDER_NO, POINT_HISTORY_REASON, POINT_AMOUNT ) "
				   + "values "
				   + "(SUL_POINT_HISTORY_SEQ.nextval, ?, ?, ?, ?) ";
		
		helper.insert(sql, history.getUserNo(), history.getOrderNo(), history.getReason(), history.getAmount());
	}
}
