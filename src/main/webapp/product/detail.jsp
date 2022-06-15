<%@page import="java.util.List"%>
<%@page import="vo.Review"%>
<%@page import="dao.ProductReviewDao"%>
<%@page import="vo.User"%>
<%@page import="vo.Product"%>
<%@page import="dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>상품 상세정보</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="../common/nav.jsp">
	<jsp:param name="menu" value="product"/>
</jsp:include>
<div class="container">
   	<div class="row">
		<div class="col">
			<h1 class="fs-4 border p-2">상품 상세정보</h1>
		</div>
	</div>
	<div class="row">
		<div class="col-6">
		<div>
		<img alt="" src="../images/sample1.jpg" class="img-detailpoto" width="500">
		</div>
		</div>
	<div class="col-6">
	<%
		User user = (User) session.getAttribute("LOGINED_USER");
		
		int productNo = Integer.parseInt(request.getParameter("productNo"));
	
		ProductDao productDao = ProductDao.getInstance();
		Product product = productDao.getProductByNo(productNo);
		
		ProductReviewDao productReviewDao = ProductReviewDao.getInstance();
		List<Review> reviews = productReviewDao.getProductReviews(productNo);
	%>
	<h3><%=product.getName() %></h3>
	<table class="table">
		<tbody>
			<tr>
				<th>상품명</th>
				<td><%=product.getName() %></td>
			</tr>
			<tr>
				<th>정가</th>
				<td><%=product.getPrice() %></td>
			</tr>
			<tr>
				<th>판매가</th>
				<td><%=product.getSalePrice() %></td>
			</tr>
			<tr>
				<th>제조회사</th>
				<td><%=product.getCompany() %></td>
			</tr>
			<tr>
				<th>수량변경</th>
				<td></td>
			</tr>
			<tr>
				<th>상품번호</th>
				<td><%=product.getNo() %></td>
			</tr>
			<tr>
				<th></th>
				<td>
					<a href="../order.jsp?productNo=<%=product.getNo() %>" class="btn btn-sm <%=user == null ? "btn-outline-secondary disabled" : "btn-outline-primary" %>">바로구매</a>
					<a href="../cart.jsp?productNo=<%=product.getNo() %>" class="btn btn-sm <%=user == null ? "btn-outline-secondary disabled" : "btn-outline-primary" %>">장바구니</a>
				</td>
			</tr>				
		</tbody>
	</table>
	</div>
	</div>
	<div class="row mb-4">
		<div class="col-4">
			<P>상세정보</P>
		</div>
		<div class="col-4">
			<P>구매평</P>
		</div>
		<div class="col-4">
			<P>Q&A</P>
		</div>
	</div>
		<div class="row mb-3">
		<div class="col">
			<div class="card-body">
				<form class="row g-3">
					<div class="col-11">
						<textarea rows="2" class="form-control" placeholder="전통주와 함께한 좋은 기억을 다른 분들과 나눠주세요♥"></textarea>
					</div>
					<div class="col-1">
						<button type="submit" class="btn btn-outline-secondary w-100 h-100">등록</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div>
		<div>
		<%
			if (reviews.isEmpty()) {
		%>
			<div class="container">
				<div>
					<p>작성된 리뷰가 없습니다.</p>
				</div>
			</div>
		<%
			} else {
				for (Review review : reviews) {
		%>
			<%-- <div class="card mb-3">
				<div class="card-body">
					<div class="d-flex justify-content-between">
						<h6><%=review.getUserId() %></h6>
						<span><%=review.getCreatedDate() %></span>
					</div>
					<div class="row">
						<div class="col-9">
							<p class="mb-0"><%=review.getContent() %></p>
						</div>
						<div>
							<a href=""></a>
						</div>
					</div>
				</div>
			</div> --%>
			
	<div class="row border-bottom mb-3">
   			   <div class="col-2 py-3 ">
         <p class="text-muted mb-1"><%=review.getCreatedDate() %></p>
         <p class="text-muted"><%=review.getUserId() %></p>
      </div>
      <div class="col-10 p-3">
         <p class="small"><%=review.getContent() %> </p>
       
       
         <p><a href="">1</a>개의 댓글이 있습니다. <span class="text-info">추천 </span> : <span class="test-info">1</span> <a href="" class="btn btn-info btn-sm">추천하기</a></p>
      </div>
   </div>
		<%
				}
			}
		%>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>