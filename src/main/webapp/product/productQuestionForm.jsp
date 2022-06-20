<%@page import="vo.Product"%>
<%@page import="dao.ProductDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		User user = (User) session.getAttribute("LOGINED_USER");
		
		int productNo = Integer.parseInt(request.getParameter("pdNo"));
		
		ProductDao productDao = ProductDao.getInstance();
		Product product = productDao.getProductByNo(productNo);
	%>
		<div class="container mt-3">
			<h3>상품문의 글쓰기</h3>
			<hr>
			
		</div>
</body>
</html>