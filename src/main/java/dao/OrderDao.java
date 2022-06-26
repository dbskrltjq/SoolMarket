package dao;

import java.sql.SQLException;

import java.util.List;

import dto.OrderItemDto;
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
	
	public List<Product> getProductsByNo(int pdNo) throws SQLException {
		
		String sql = "select * "
				   + "from sul_products "
				   + "where pd_no = ? ";
		
		return helper.selectList(sql, rs -> {
			Product product = new Product();
			product.setNo(rs.getInt("pd_no"));
			product.setCategoryNo(rs.getInt("category_no"));
			product.setName(rs.getString("pd_name"));
			product.setPrice(rs.getInt("pd_price"));
			product.setSalePrice(rs.getInt("pd_sale_price"));
			product.setStock(rs.getInt("pd_stock"));
			product.setOnSale(rs.getString("pd_onsale"));
			product.setReviewScore(rs.getInt("pd_review_score"));
			product.setReviewCount(rs.getInt("pd_review_count"));
			product.setCompany(rs.getString("pd_company"));
			product.setSaleQuantity(rs.getInt("pd_sale_quantity"));
			product.setRecommended(rs.getString("pd_recommended"));
			product.setFileName(rs.getString("pd_file_name"));
			
			return product;
		}, pdNo);
	}
	
	// OrderNow 바로구매에서 사용된다.
	public Product getProductByNo(int pdNo) throws SQLException {
		
		String sql = "select * "
				+ "from sul_products "
				+ "where pd_no = ? ";
		
		return helper.selectOne(sql, rs -> {
			Product product = new Product();
			product.setNo(rs.getInt("pd_no"));
			product.setCategoryNo(rs.getInt("category_no"));
			product.setName(rs.getString("pd_name"));
			product.setPrice(rs.getInt("pd_price"));
			product.setSalePrice(rs.getInt("pd_sale_price"));
			product.setStock(rs.getInt("pd_stock"));
			product.setOnSale(rs.getString("pd_onsale"));
			product.setReviewScore(rs.getInt("pd_review_score"));
			product.setReviewCount(rs.getInt("pd_review_count"));
			product.setCompany(rs.getString("pd_company"));
			product.setSaleQuantity(rs.getInt("pd_sale_quantity"));
			product.setRecommended(rs.getString("pd_recommended"));
			product.setFileName(rs.getString("pd_file_name"));
			
			return product;
		}, pdNo);
	}
	
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
	
	// 주문의 시퀀스번호 얻는다.
	public int getSequence() throws SQLException {
		String sql = "select SUL_ORDERS_SEQ.nextval seq from dual";
		return helper.selectOne(sql, rs -> rs.getInt("seq"));
	}
	
	// order 받아 ORDER 테이블에 insert
	public void insertOrder(Order order) throws SQLException {
		String sql = "insert into SUL_ORDERS "
				   + "(ORDER_NO, USER_NO, ORDER_TOTAL_PRICE, ORDER_USED_POINT, ORDER_PAYMENT_PRICE, ORDER_DEPOSITE_POINT, ORDER_TOTAL_QUANTITY, ORDER_TITLE, "
				   + "RECEIVE_NAME, RECEIVE_ADDRESS, RECEIVE_DETAIL_ADDRESS, RECEIVE_DELIVERY_MESSAGE, ORDER_PAYMENT, RECEIVE_POSTCODE) "
				   + "values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";
		
		helper.insert(sql, order.getNo(), order.getUserNo(), order.getTotalPrice(), order.getUsedPoint(), order.getPaymentPrice(), order.getDepositPoint(), order.getTotalQuantity(), order.getTitle(), 
				      order.getReceiveName(), order.getReceiveAddress(), order.getReceiveDetailAddress(), order.getDeliveryMemo(), order.getPayment(), order.getReceivePostCode());
	}
	
	// orderItem에 insert
	public void insertOrderItem(OrderItem orderItem) throws SQLException {
		String sql = "insert into SUL_ORDER_ITEMS "
				   + "(ORDER_ITEM_NO, ORDER_NO, PD_NO, ORDER_ITEM_PRICE, ORDER_ITEM_QUANTITY) "
				   + "values (SUL_ORDER_ITEMS_SEQ.nextval, ?, ?, ?, ?) ";
		
		helper.insert(sql, orderItem.getOrderNo(), orderItem.getPdNo(), orderItem.getPrice(), orderItem.getQuantity());

	}
	

	// orderNo로 주문정보 읽어온다. orderComplete 사용됨.
	public Order getOrderByOrderNo(int orderNo) throws SQLException {
		String sql = "select ORDER_NO, ORDER_PAYMENT_PRICE, ORDER_TOTAL_QUANTITY, ORDER_CREATED_DATE, ORDER_STATUS, ORDER_TITLE, ORDER_TOTAL_PRICE, ORDER_USED_POINT "
				+ "from SUL_ORDERS "
				+ "where order_no = ? ";
		
		return helper.selectOne(sql, rs -> {
			Order order = new Order();
			
			order.setNo(rs.getInt("ORDER_NO"));
			order.setPaymentPrice(rs.getInt("ORDER_PAYMENT_PRICE"));
			order.setTotalQuantity(rs.getInt("ORDER_TOTAL_QUANTITY"));
			order.setCreatedDate(rs.getDate("ORDER_CREATED_DATE"));
			order.setStatus(rs.getString("ORDER_STATUS"));
			order.setTitle(rs.getString("ORDER_TITLE"));
			order.setTotalPrice(rs.getInt("ORDER_TOTAL_PRICE"));
			order.setUsedPoint(rs.getInt("ORDER_USED_POINT"));
			
			return order;
		}, orderNo);
	}
	
	// userNo로 주문정보 읽어온다. myOrder 에서 사용된다.
	public List<Order> getAllOrdersByUserNo(int userNo) throws SQLException {
		String sql = "select ORDER_NO, ORDER_PAYMENT_PRICE, ORDER_TOTAL_QUANTITY, ORDER_CREATED_DATE, ORDER_STATUS, ORDER_TITLE "
				   + "from SUL_ORDERS "
				   + "where user_no = ? "
				   + "order by order_no desc";
		
		return helper.selectList(sql, rs -> {
			Order order = new Order();
			
			order.setNo(rs.getInt("ORDER_NO"));
			order.setPaymentPrice(rs.getInt("ORDER_PAYMENT_PRICE"));
			order.setTotalQuantity(rs.getInt("ORDER_TOTAL_QUANTITY"));
			order.setCreatedDate(rs.getDate("ORDER_CREATED_DATE"));
			order.setStatus(rs.getString("ORDER_STATUS"));
			order.setTitle(rs.getString("ORDER_TITLE"));
			
			return order;
		}, userNo);
	}
	
	// userNo로 30일 내의 주문정보 읽어온다. mypage의 최근주문정보에서 사용된다.
	public List<Order> getRecentOrdersByUserNo(int userNo) throws SQLException {
		String sql = "select ORDER_NO, ORDER_PAYMENT_PRICE, ORDER_TOTAL_QUANTITY, ORDER_CREATED_DATE, ORDER_STATUS, ORDER_TITLE "
				+ "from SUL_ORDERS "
				+ "where user_no = ? "
				+ "and ORDER_CREATED_DATE >= TRUNC(SYSDATE) - 30 "
				+ "order by order_no desc";
		
		return helper.selectList(sql, rs -> {
			Order order = new Order();
			
			order.setNo(rs.getInt("ORDER_NO"));
			order.setPaymentPrice(rs.getInt("ORDER_PAYMENT_PRICE"));
			order.setTotalQuantity(rs.getInt("ORDER_TOTAL_QUANTITY"));
			order.setCreatedDate(rs.getDate("ORDER_CREATED_DATE"));
			order.setStatus(rs.getString("ORDER_STATUS"));
			order.setTitle(rs.getString("ORDER_TITLE"));
			
			return order;
		}, userNo);
	}
	
	// orderNo로 orderItem들 불러온다. myOrderDetail에서 사용된다.
	public List<OrderItemDto> getOrderItemsByOrderNo(int orderNo) throws SQLException {
		String sql = "select I.ORDER_NO, P.PD_NAME, I.ORDER_ITEM_PRICE, I.ORDER_ITEM_QUANTITY, (I.ORDER_ITEM_PRICE*I.ORDER_ITEM_QUANTITY) TOTALPRICE, O.ORDER_USED_POINT, O.ORDER_PAYMENT_PRICE, I.ORDER_ITEM_CREATED_DATE,  P.PD_NO "
				+ "from SUL_ORDERS O, SUL_ORDER_ITEMS I, SUL_PRODUCTS P "
				+ "where I.ORDER_NO= ? "
				+ "and I.ORDER_NO = O.ORDER_NO "
				+ "and I.PD_NO = P.PD_NO ";
		
		return helper.selectList(sql, rs -> {
			OrderItemDto orders = new OrderItemDto();
			
			orders.setOrderNo(rs.getInt("ORDER_NO"));
			orders.setName(rs.getString("PD_NAME"));
			orders.setSalePrice(rs.getInt("ORDER_ITEM_PRICE"));
			orders.setQuantity(rs.getInt("ORDER_ITEM_QUANTITY"));
			orders.setTotalPrice(rs.getInt("TOTALPRICE"));
			orders.setUsedPoint(rs.getInt("ORDER_USED_POINT"));
			orders.setPaymentPrice(rs.getInt("ORDER_PAYMENT_PRICE"));
			orders.setCreatedDate(rs.getDate("ORDER_ITEM_CREATED_DATE"));
			orders.setPdNo(rs.getInt("PD_NO"));
			
			return orders;
		}, orderNo); 
	}
	
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
