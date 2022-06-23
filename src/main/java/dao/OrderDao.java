package dao;

import java.sql.SQLException;

import java.util.List;

import helper.DaoHelper;
import vo.Order;
import vo.OrderItem;
import vo.Product;

public class OrderDao {

	private static OrderDao instance = new OrderDao();

	private OrderDao() {}
	public static OrderDao getInstance() {
		return instance;
	}
	
	private DaoHelper helper = DaoHelper.getInstance();
	
	// userNo를 받아 해당 유저가 주문한 횟수를 얻는다. (deleted된 주문 제외)
	public int getOrderCount(int userNo) throws SQLException {
		String sql = "select count(*) cnt "
					+"from sul_orders "
					+"where order_deleted = 'N' "
					+"and user_no = ? ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		}, userNo);
	}

	// userNo를 받아 해당 유저가 주문한 물건 리스트를 받는다. (상품번호, 카테고리 번호, 상품 이름)
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
	
	public int getSequence() throws SQLException {
		String sql = "select SUL_ORDER_ITEMS_SEQ.nextval seq from dual";
		return helper.selectOne(sql, rs -> rs.getInt("seq"));
	}
	
	// order 받아 ORDER 테이블에 insert하는 sql문 ~~~> 걍 객체를 받으면 된다
	public void insertOrder(Order order) throws SQLException {
		String sql = "insert into SUL_ORDERS "
					+ "(ORDER_NO, USER_NO, ORDER_TOTAL_PRICE, ORDER_USED_POINT, ORDER_PAYMENT_PRICE, ORDER_DEPOSITE_POINT, ORDER_TOTAL_QUANTITY, ORDER_TITLE, "
					+ "RECEIVE_NAME, RECEIVE_ADDRESS, RECEIVE_DETAIL_ADDRESS, RECEIVE_DELIVERY_MESSAGE, ORDER_PAYMENT, RECEIVE_POSTCODE) "
					+ "values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";
		
		helper.insert(sql, order.getNo(), order.getUserNo(), order.getTotalPrice(), order.getUsedPoint(), order.getPaymentPrice(), order.getDepositPoint(), order.getTotalQuantity(), order.getTitle(), 
				      order.getReceiveName(), order.getReceiveAddress(), order.getReceiveDetailAddress(), order.getDeliveryMemo(), order.getPayment(), order.getReceivePostCode());
	}
	
	// orderItem에 insert하는 sql문?
	public void insertOrderItem(OrderItem orderItem) throws SQLException {
		String sql = "insert into SUL_ORDER_ITEMS "
				+ "(ORDER_ITEM_NO, ORDER_NO, PD_NO, ORDER_ITEM_PRICE, ORDER_ITEM_QUANTITY) "
				+ "values (SUL_ORDER_ITEMS_SEQ.nextval, ?, ?, ?, ?) ";
		
		helper.insert(sql, orderItem.getOrderNo(), orderItem.getPdNo(), orderItem.getPrice(), orderItem.getQuantity());

	}
	
	// pointhistory & user 포인트 수정하는 sql문
	
	// 주문 여부를 확인하는 sql
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
