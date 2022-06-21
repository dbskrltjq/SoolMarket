<%@page import="java.util.List"%>
<%@page import="vo.User"%>
<%@page import="dao.OrderDao"%>
<%@page import="vo.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>리뷰 등록</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="../common/nav.jsp">
	<jsp:param name="menu" value="login"/>
</jsp:include>
<div class="container">
	<div class="row">
	<%
		User user = (User) session.getAttribute("LOGINED_USER");
		OrderDao orderDao = OrderDao.getInstance(); 
		List<Product> products = orderDao.getOrderProductsByUserNo(user.getNo());
	%>
		<div class="col">
			<h1 class="fs-4 border p-5">리뷰 등록페이지</h1>
		</div>
	</div>
	<div class="row">
		<div class="col">
			<form class="row g-3 border bg-light mx-1" method="post" action="add.jsp" enctype="multipart/form-data" onsubmit="return submitReviewForm">
				<div class="col-12">
					<label class="form-label">주문제품 선택</label>
					<select class="form-select" id="order-product-select">
						<option value="" selected ="selected" disabled="disabled"> 선택하세요</option>
					<%
						for(Product product : products) {
					%>	
						<option value="<%=product.getNo() %>"><%=product.getName() %></option>
					<%
						}
					%>
					</select>
				</div>
				<div class="col-9">
					<select class="form-select" name="scoreSelect">
						<option value="5" selected="selected">★★★★★</option>
						<option value="4" >★★★★</option>
						<option value="3" >★★★</option>
						<option value="2" >★★</option>
						<option value="1" >★</option>
					</select>
				</div>		
				<div class="col-3 btn-group">
					<button class="btn btn-secondary btn-sm dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">혜택안내</button>
			    	<ul class="dropdown-menu">
				    	<li><h4>구매혜택</h4></li>
						<li><p>일반리뷰:제품금액의 2% 적립<p></li>
						<li><p>포토리뷰:100원 추가적립<p></li>
					</ul>
				</div>
				<div class="col-12">
					<textarea rows="5" class="form-control" name="content" placeholder="전통주와 함께한 좋은기억을 다른분들과 나눠주세요♥"></textarea>
				</div>
				<div class="col-4">
					<input type="file" class="form-control" name="upfile" />
				</div>
				<div class="col-8 text-end">
					<button type="submit" class="btn btn-primary">리뷰등록</button>
				</div>
			</form>
		</div>
	</div>
	
	

</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
	function submitReviewForm() {
		let contentField = document.querySelector("input[name=content");
		
		if(contentField === ''){
			alert("리뷰작성칸에 리뷰를 작성해주세요.")
			contentField.focus();
			return false;
		}
		
		
		
	}

</script>
</body>
</html>