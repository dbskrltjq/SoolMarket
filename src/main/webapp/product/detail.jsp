<%@page import="dto.QuestionDto"%>
<%@page import="dao.ProductQuestionDao"%>
<%@page import="dto.ReviewDto"%>
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
<div class="container mt-3">
	<div class="row">
		<div class="col-6">
			<div>
				<img alt="" src="../images/sample1.jpg" class="img-thumbnail" >
			</div>
		</div>
		<div class="col-6">
	<%
		User user = (User) session.getAttribute("LOGINED_USER");
		
		int productNo = Integer.parseInt(request.getParameter("productNo"));
	
		ProductDao productDao = ProductDao.getInstance();
		Product product = productDao.getProductByNo(productNo);
		
		ProductReviewDao productReviewDao = ProductReviewDao.getInstance();
		List<ReviewDto> reviews = productReviewDao.getProductReviews(productNo);
		
		ProductQuestionDao productQuestionDao = ProductQuestionDao.getInstance();
		List<QuestionDto> questions = productQuestionDao.getProductQuestions(productNo);
	%>
			<h3 class="ps-2 fs-2"><%=product.getName() %></h3>
			<hr>
			<table class="table-boardless">
				<tbody>
					<tr>
						<th class="p-2">상품명</th>
						<td class="p-2"><%=product.getName() %></td>
					</tr>
					<tr>
						<th class="p-2">정가</th>
						<td class="p-2 text-decoration-line-through"><%=product.getPrice() %></td>
					</tr>
					<tr>
						<th class="p-2">판매가</th>
						<td class="p-2"><%=product.getSalePrice() %></td>
					</tr>
					<tr>
						<th class="p-2">제조회사</th>
						<td class="p-2"><%=product.getCompany() %></td>
					</tr>
					<tr>
						<th class="p-2">수량</th>
						<td><input class=" p-2" type="number" min="1" max="100" id="" value="1"></td>
					</tr>
					<tr>
						<th class="p-2">상품번호</th>
						<td class="p-2"><%=product.getNo() %></td>
					</tr>
					<tr>
				</tbody>
			</table>
			<hr />
			<div class="p-2">
				<a href="../order.jsp?pdNo=<%=product.getNo() %>" class="me-3 btn btn-lg  <%=user == null ? "btn-outline-secondary disabled" : "btn-outline-primary" %>">바로구매</a>
				<a href="../cartitemAdd.jsp?pdNo=<%=product.getNo() %>" class="btn btn-lg  <%=user == null ? "btn-outline-secondary disabled" : "btn-outline-primary" %>">장바구니</a>
			</div>			
		</div>
	</div>
	
	<div class="row mt-5 mb-3 text-center">
		<div class="col-12">
			<nav class="nav nav-pills flex-column flex-sm-row  g-2">
			  <a class="border flex-sm-fill text-sm-center nav-link active rounded-0" aria-current="page" href="#">상세정보</a>
			  <a class="border flex-sm-fill text-sm-center nav-link rounded-0" href="#">구매평</a>
			  <a class="border flex-sm-fill text-sm-center nav-link rounded-0" href="#">Q&A</a>
			</nav>
		</div>
	</div>

	<div class="row mb-3">
		<div class="col-12">
			<div class="card-body">
				<h3>구매평</h3>

				<form class="row g-3" method="post" action="reviewRegister.jsp" enctype="multipart/form-data">
					<input type="hidden" name="productNo" value="<%=product.getNo() %>" />
					<select class="form-select form-select-sm" name="reviewScore" aria-label=".form-select-sm example">
	  					<option selected>평점을 입력해주세요</option>
	 					<option value="5">★★★★★</option>
	 					<option value="4">★★★★</option>
	  					<option value="3">★★★</option>
	  					<option value="2">★★</option>
	  					<option value="1">★</option>
					</select>
					
					<input type="hidden" id="is-login" value="<%=user == null ? "no" : "yes"%>">
					<div class="col-11">
						<textarea rows="2" class="form-control" name="reviewContent" placeholder="전통주와 함께한 좋은 기억을 다른 분들과 나눠주세요♥" onclick="reviewCheck(<%=product.getNo() %>)" ></textarea>
					</div>
					<div class="col-1">
						<button type="submit" name="reviewBotten" class="btn btn-outline-secondary w-100 h-100">리뷰등록</button>
					</div>
					<div class="form-label"></div>
					<input type=file class="form-control" name="reviewFileName" />
				</form>
			</div>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-12">
		<%
			if (reviews.isEmpty()) {
		%>
			<div class="text-center">
				<p>작성된 리뷰가 없습니다.</p>
			</div>
		<%
			} else {
				for (ReviewDto review : reviews) {
		%>
			
			<div class="row border-bottom mb-3">
   				<div class="col-2 p-3 ">
         			<p class="text-muted mb-1"><%=review.getCreatedDate() %></p>
        	 		<p class="text-muted"><%=review.getUserId() %></p>
				</div>
      			<div class="col-10 p-3">
         			<p class="small"><%=review.getContent() %> </p>
         			<p><a href="">1</a>개의 댓글이 있습니다. <span class="text-info">추천 </span> : <span class="test-info"><%=review.getLikeCount() %></span> <a href="" class="btn btn-info btn-sm">추천하기</a></p>
     		 	</div>
   			</div>
		<%
				}
			}
		%>
		</div>
	</div>
	<hr/>
	<div class="row mb-3">
		<div class="col-12 d-flex justify-content-between">
			<h3>상품 Q&A</h3>
			<div>
				<a href="productQuestionForm.jsp?pdNo=<%=product.getNo() %>" class="btn btn-primary btn-sm  " >상품문의 글쓰기</a>
				<a href="question.jsp" class="btn btn-outline-secondary btn-sm  " >상품문의 전체보기</a>
			</div>
		</div>
	</div>
	<div class="row mb-5">
		<div class="col-12">
			<table class="table">
				<colgroup>
					<col width="5%">
					<col width="%">
					<col width="10%">
					<col width="10%">
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>이름</th>
						<th>등록일</th>
					</tr>
				</thead>
				<tbody class="table-group-divider">
					<tr>
					<%
						if (questions.isEmpty()) {					
					%>
						<td colspan="4" class="text-center">등록된 상품 문의가 없습니다.</td>
					<%
						} else {
							for (QuestionDto question : questions) {
						
					%>
						<td><%=question.getNo() %></td>
						<td><%=question.getTitle() %></td>
						<td><%=question.getUserName() %></td>
						<td><%=question.getCreatedDate() %></td>
					<%
							}
						}
					%>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">

	function reviewCheck(productNo) {
		let islogin = document.querySelector("#is-login").value;
		if (islogin === "no") {
			alert("쇼핑몰 회원님만 글작성 가능합니다.")
			document.querySelector("textarea[name=reviewContent]").readOnly=true;
			document.querySelector("button[name=reviewBotten]").disabled=true;
			document.querySelector("input[name=reviewFileName]").disabled=true;
			document.querySelector("select[name=reviewScore]").disabled=true;
			return;
		}
		
		let xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if (xhr.readyState === 4 && xhr.status === 200) {
				let jsonText = xhr.responseText;
				let result = JSON.parse(jsonText);
				if (!result.exist) {
					alert("해당 상품을 구매하신 회원님만 글작성이 가능합니다.")
					document.querySelector("textarea[name=reviewContent]").readOnly=true;
					document.querySelector("button[name=reviewBotten]").disabled=true;
					document.querySelector("input[name=reviewFileName]").disabled=true;
					document.querySelector("select[name=reviewScore]").disabled=true;
					return;
				}
			}
		}
		xhr.open("GET",'reviewCheck.jsp?productNo=' + productNo)
		xhr.send();
	}
	
	function reviewUserCheck(userNo) {
		let xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if (xhr.readyState === 4 && xhr.status === 200) {
				let jsonText = xhr.responseText;
				let result = JSON.parse(jsonText);
				if (!result.exist) {
					alert("리뷰를 두개 이상 작성하실 수 없습니다.")
					return;
				}
			}
		}
		xhr.open("GET",'reviewUserCheck.jsp?userNo=' + userNo)
		xhr.send();
	}
	
</script>
</body>
</html>

