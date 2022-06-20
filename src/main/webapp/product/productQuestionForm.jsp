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
		<div class="container">
			<h3>상품문의 글쓰기</h3>
			<hr>
			<div class="row">
				<div class="col-6 py-3 ">
					<div>
						<img alt="" src="../images/sample1.jpg" class="img-thumbnail" width="200">
					</div>
				</div>
				<div class="col-6 p-3">
					<h3 class="fs-5 text-bold"><%=product.getName() %></h3>
				</div>
			</div>
		</div>
</body>
</html>