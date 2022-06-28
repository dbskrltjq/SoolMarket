<%@page import="vo.Order"%>
<%@page import="dao.OrderDao"%>
<%@page import="vo.User"%>
<%@page import="util.StringUtil"%>
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
	#cancel1 {
    		font-size: 20px; 		
	}
	
	#cancel2 {
    		font-size: 25px; 	
	}
</style>
</head>
<body>
<jsp:include page="common/nav.jsp">
	<jsp:param name="menu" value="OCancleComplete"/>
</jsp:include>
<div class="container">

	<% 	
		User user = (User) session.getAttribute("LOGINED_USER");
		if (user==null) {
			response.sendRedirect("loginform.jsp?fail=deny"); 
			return;
		}
	%>
	
	<%
		int orderNo = StringUtil.stringToInt(request.getParameter("orderNo"));
	
		OrderDao orderDao = OrderDao.getInstance();	
		Order order = orderDao.getOrderByOrderNo(orderNo);
	%>
	
	<div class="row mb-3"> 
		<div class="col">
		    <div class="card mt-5 mb-5">
				<div class="card-body p-5">
					<p>
						<span id="cancel1"><%=user.getName()%> 고객님의</span>
					</p>
					<p>
						<span id="cancel2"><strong><%=order.getTitle() %></strong></span>
					</p>
					<p>
						<span id="cancel1">주문이 취소되었습니다.</span>
					</p>
	      		<a href="myCancelDetail.jsp?orderNo=<%=order.getNo()%>" id="mycancle-go-link" class="btn btn-outline-secondary mt-4">취소 내역 보기</a>
	      		<a href="home.jsp" id="shop-go-link" class="btn btn-primary mt-4">홈으로 가기</a>
    			</div>
        	</div>
   		</div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>