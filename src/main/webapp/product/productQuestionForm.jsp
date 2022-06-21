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
					<p><%=product.getName() %></p>
				</div>
			</div>
			<form class="row" method="post" action="questionRegister.jsp" enctype="multipart/form-data">
			<table >
				<tbody>
					<tr>
						<th class="p-2">말머리</th>
						<td class="p-2">
							<select class="form-select" aria-label="Default select example">
								  <option value="1">상품</option>
								  <option value="2">배송</option>
								  <option value="3">반품/환불</option>
								  <option value="4">교환/변경</option>
								  <option value="5">기타</option>
							</select>
						</td>
					</tr>
					<tr>
						<th class="p-2">작성자</th>
						<td class="p-2"><%=user.getName() %></td>
					</tr>
					<tr>
						<th class="p-2">제목</th>
						<td class="p-2"></td>					
					</tr>
				</tbody>
			</table>
			</form>
		</div>
</body>
</html>