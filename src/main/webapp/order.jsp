<%@page import="dao.HistoryDao"%>
<%@page import="dao.UserDao"%>
<%@page import="org.apache.catalina.realm.UserDatabaseRealm.UserDatabasePrincipal"%>
<%@page import="vo.PointHistory"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.lang.reflect.Array"%>
<%@page import="java.util.List"%>
<%@page import="dao.ProductDao"%>
<%@page import="vo.Product"%>
<%@page import="util.StringUtil"%>
<%@page import="dao.OrderDao"%>
<%@page import="vo.OrderItem"%>
<%@page import="vo.Order"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		throw new RuntimeException("구매는 로그인 후 사용가능한 서비스 입니다.");
	}
	
	// orderNo가 있어야 orderItem을 담을 수 있는데, 지금은 order sequence가 없다.
	// order sequence값을 담는 변수를 만들자. 대신 order sql문에서 sequence를 추가하면 안 된다. orderItems의 sql문에는 시퀀스.nextval 추가해야 한다.
	OrderDao orderDao = OrderDao.getInstance();
	int orderNo = orderDao.getSequence();
	
	// order 객체에 값들을 담고 있다. 
	// 10,000 형태의 것들은 ,를 없애준 뒤 (replace) int로 형변환해준다.
	Order order = new Order();
	
	order.setNo(orderNo);
	order.setUserNo(user.getNo());																			// 유저번호
	order.setTotalPrice(Integer.parseInt(request.getParameter("totalPrice").replace(",", "")));				// 총금액
	order.setUsedPoint(Integer.parseInt(request.getParameter("usedPoint")));								// 사용 포인트
	order.setPaymentPrice(Integer.parseInt(request.getParameter("paymentPrice").replace(",", "")));			// 실제 결제 금액
	order.setDepositPoint(Integer.parseInt(request.getParameter("depositPoint")));							// 적립 포인트	
	order.setTotalQuantity(Integer.parseInt(request.getParameter("totalQuantity")));						// 총구매갯수
	order.setReceiveName(request.getParameter("receiveName"));												// 받는 사람 이름
	order.setPayment(request.getParameter("payment"));												// 받는 사람 이름
	order.setReceiveAddress(request.getParameter("receiveAddress"));										// 받는 사람 주소
	order.setReceiveDetailAddress(request.getParameter("receiveDetailAddress"));							// 받는 사람 상세주소
	order.setReceivePostCode(Integer.parseInt(request.getParameter("receivePostcode")));					// 받는 사람 우편주소
	order.setDeliveryMemo(request.getParameter("deliveryMemo"));											// 배송메세지
	// title [좋은 마을 막걸리] 외 n개 상품 -> 이건 밑에서 한다.
	
	// 배열
	// pdNo와 quantity를 parameter로 받았다. 몇 개의 상품이 전달될 지 모르니 배열 / list로 받아야 한다. 여기선 배열 -> list로 받았다. 
	String[] productNoValues = request.getParameterValues("pdNo");
	String[] quantityValues = request.getParameterValues("quantity");
	
	// 이건 이따 orderNo 가진 거 넣은 list이다. 
	// 먼저 배열 안의 위의 값들을 for문을 돌려 orderNo 없는 orderItem에 넣는다. 
	List<OrderItem> orderItems = new ArrayList<>();
	
	// 1. for문을 돌린다. 전달되는 아이템의 갯수만큼 돌린다. 
	// 2. 상품번호, 수량은 현재 string형태로 나오고 있기에, int로 형변환해서 int 변수들에 넣는다. 
	String orderTitle = "";
	for (int i=0; i<productNoValues.length; i++) {
		int productNo = StringUtil.stringToInt(productNoValues[i]);
		int quantity = StringUtil.stringToInt(quantityValues[i]);
		
		// 여기서 제목을 뽑는다. 첫번째 상품 외 n개의 형태로 할 거라, 0번째 배열.getName을 뽑아 orderTitle에 넣는다.
		Product product = ProductDao.getInstance().getProductByNo(productNo);
		if (i == 0) {
			orderTitle = product.getName();
		}
		
		// 주문번호, 상품번호, 수량, 가격을 orderItem에 담는다. 
		// orderItem을 orderItems에 담는다. (for문 돌리고 있음)
		OrderItem orderItem = new OrderItem();
		orderItem.setOrderNo(orderNo);
		orderItem.setPdNo(productNo);
		orderItem.setQuantity(quantity);
		orderItem.setPrice(product.getSalePrice());

		orderItems.add(orderItem);
	}
	
	// 주문명 : 1개 제품 주문하면 해당 제품명만, 2개 이상 제품 주문하면 맨 처음 제품명 + (전체갯수 - 1) 종 이라고 뜬다.
	orderTitle = orderTitle + (orderItems.size() > 1 ?  " 외 " + (orderItems.size() - 1) + " 종" : "");
	order.setTitle(orderTitle);

	// order - orderNo 담긴 후부터 orderItem 담아야 한다.
	// orderNo에는 시퀀스 넣지 말고 값 바인딩하기
	orderDao.insertOrder(order);
	
	// 여기서 다시 for문 돌려서 insert하는 이유. 위에서는 orderItems 시퀀스가 없다. 
	// 위의 상품갯수(size 말하는 거임)만큼 for문 돌려서 돌려진 것 하나하나 insertOrderItems( )에 넣는다. 파라미터는 (당연히) orderItem이다.
	for (OrderItem orderItem : orderItems) {
		orderDao.insertOrderItem(orderItem);
	}
	
	// 포인트 변경한다.
	UserDao userDao = UserDao.getInstance();
	user = userDao.getUserByNo(user.getNo());

	int usedPoint = Integer.parseInt(request.getParameter("usedPoint"));			// 사용포인트
	int depositPoint = Integer.parseInt(request.getParameter("depositPoint"));		// 적립포인트
	
	PointHistory history = new PointHistory();
	HistoryDao historyDao = HistoryDao.getInstance();
	
	// 1. 사용한 포인트가 있는 경우, POINT_HISTORY에 사용 이력을 넣는다.
	if (usedPoint > 0) {
		history.setUserNo(user.getNo()); 			//최신 유저 번호 불러오기 위해 이렇게 한다.
		history.setOrderNo(orderNo);
		history.setReason("포인트 사용");
		history.setAmount(usedPoint);
		
		historyDao.insertPointHistory(history);			
	}

	// 2. 적립 포인트는 어느 경우에나 있으므로(0원 구매 불가, 전액 포인트 사용해도 적립됨) insert 한다.
	if (depositPoint > 0) {
		history.setUserNo(user.getNo()); 			//최신 유저 번호 불러오기 위해 이렇게 한다.
		history.setOrderNo(orderNo);
		history.setReason("포인트 적립");
		history.setAmount(depositPoint);
		
		historyDao.insertPointHistory(history);	
	} else {
	%>
		<script>
		alert("잘못된 접근입니다. 결제 정보를 확인해 주세요.");
		</script>
	<%
		return;
	}

	// 3. updateUserPoint를 사용해 userPoint를 업데이트 해 준다.
	user.setPoint(user.getPoint() - usedPoint + depositPoint);
	userDao.updateUserPoint(user);
	
	// orderNo를 함께 보내면 주문완료 창에서 주문 조회 가능하다.
	response.sendRedirect("orderComplete.jsp?orderNo="+orderNo);

%> 