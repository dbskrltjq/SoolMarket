<%@page import="vo.Order"%>
<%@page import="dao.OrderDao"%>
<%@page import="vo.User"%>
<%@page import="util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bootstrap demo</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="common/nav.jsp">
	<jsp:param name="menu" value="OCancleComplete"/>
</jsp:include>
<div class="container">
   	<%
		String fail = request.getParameter("fail");
	
		if ("invalid".equals(fail)) {
	%>
		<div class="alert alert-danger">
			<strong>오류</strong>유효한 요청이 아닙니다. 
		</div>	
	<%
		} else if("deny".equals(fail)) {
	%>
		<div class="alert alert-danger">
			<strong>거부</strong> 로그인 해주세요.
		</div>
	<%
		}
	%>
		
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
		 	<h3 class="mt-5"><%=user.getName()%> 고객님의</h3>
		 	<h2><strong><%=order.getTitle() %></strong></h2>
		 	<h3>이 취소되었습니다.</h3>
	      		<a href="myCancelDetail.jsp?orderNo=<%=order.getNo()%>" id="mycancle-go-link" class="btn btn-outline-secondary mt-4">취소 내역 보기</a>
	      		<a href="home.jsp" id="shop-go-link" class="btn btn-primary mt-4">홈으로 가기</a>
    	</div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>