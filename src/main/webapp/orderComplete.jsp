<%@page import="java.util.ArrayList"%>
<%@page import="vo.Order"%>
<%@page import="java.util.List"%>
<%@page import="util.StringUtil"%>
<%@page import="dao.OrderDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error/500.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bootstrap demo</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
	#order-c1 {
    		font-size: 35px; 
    		font-weight: bold;		
    		color: #189FD8; 
	}
	
	#order-c2 {
    		font-size: 30px; 	
    		padding-bottom: 30px;
	}
</style>
</head>
<body>
<jsp:include page="common/nav.jsp">
	<jsp:param name="menu" value="orderComplete"/>
</jsp:include>
<div class="container">
	<div class="row">
		<div class="col">
			<% 	
				User user = (User) session.getAttribute("LOGINED_USER");
				if (user==null) {
					response.sendRedirect("loginform.jsp?fail=deny"); 
					return;
				}
			%>
  		</div>
    </div>
    
    <!-- table 표 형식으로 시킨 상품 보여준다. -->
    <div class="row">
    	<div class="col-10">
    		<input type="hidden" name="from" value="orderComplete" />
    			<div class="card mt-5 mb-5">
					<div class="card-body p-5">
					    <p id="order-c1">주문 완료!</p>
					    <p id="order-c2">
						    <span><strong><%=user.getName() %>님</strong></span>
						    <span>의 주문이 완료되었습니다.</span>
						</p>
						<table class="order-complete table p-3">
							<colgroup >
								<col width="10%">
								<col width="13%">
								<col width="*">
								<col width="5%">		
								<col width="10%">
								<col width="10%">
							</colgroup>
							<thead>
								<tr class="border bg-light p-3">
									<th>주문번호</th>
									<th>날짜</th>
									<th>주문정보</th>
									<th>수량</th>
									<th>주문상태</th>
									<th>결제금액</th>
								</tr>
							</thead>
							<tbody>
						<%
							OrderDao orderDao = OrderDao.getInstance();
						
							int orderNo = StringUtil.stringToInt(request.getParameter("orderNo"));		
							Order order = orderDao.getOrderByOrderNo(orderNo);
			
						%>
							<tr>
								<td><%=order.getNo() %></td>
								<td><%=order.getCreatedDate() %></td>
								<td><%=order.getTitle() %></td>
								<td><%=order.getTotalQuantity() %></td>
								<td><%=order.getStatus() %></td>
								<td><%=StringUtil.numberToString(order.getPaymentPrice()) %></td>
							</tr>
						</tbody>
					</table>
				   	<div class="row"> 
						<div class="col-6 mt-4">
				      		<a href="myOrderDetail.jsp?orderNo=<%=order.getNo() %>" id="myorder-go-link" class="btn btn-outline-secondary">내 주문정보로 가기</a>
				      		<a href="home.jsp" id="shop-go-link" class="btn btn-primary">홈으로 가기</a>
				    	</div>
				    </div>
				</div>
			</div>
		</div>
	</div>
    
    <!-- 버튼 -->
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>