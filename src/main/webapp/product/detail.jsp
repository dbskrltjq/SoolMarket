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
<div class="container mt-3 mb-5">
	<div class="row" id="detail-row">
		<div class="col-6">
			<div>
				<img alt="" src="../images/sample1.jpg" class="img-thumbnail" >
			</div>
		</div>
		<div class="col-6">
	<%
		//로그인된 유저 객체 확인
		User user = (User) session.getAttribute("LOGINED_USER");
		
		int productNo = Integer.parseInt(request.getParameter("productNo"));
	
		ProductDao productDao = ProductDao.getInstance();
		Product product = productDao.getProductByNo(productNo);
		
		ProductReviewDao productReviewDao = ProductReviewDao.getInstance();
		List<ReviewDto> reviews = productReviewDao.getProductReviews(productNo);
		
		ProductQuestionDao productQuestionDao = ProductQuestionDao.getInstance();
		List<QuestionDto> questions = productQuestionDao.getProductQuestions(productNo);
		
		int totalpdPrice = 0;
	%>
			<h3 class="ps-2 fs-2"><%=product.getName() %></h3>
			<hr>
			<table class="table-boardless" id="product-table">
				<tbody>
					<tr>
						<th class="p-2">상품명</th>
						<td class="p-2"><%=product.getName() %></td>
					</tr>
					<tr>
						<th class="p-2">상품번호</th>
						<td class="p-2"><%=product.getNo() %></td>
					</tr>
					<tr>
						<th class="p-2">제조회사</th>
						<td class="p-2"><%=product.getCompany() %></td>
					</tr>
					<tr>
						<th class="p-2">정가</th>
						<td class="p-2 text-decoration-line-through"><%=product.getPrice() %>원</td>
					</tr>
					<tr>
						<th class="p-2">판매가</th>
						<td class="p-2"><span id="salePrice"><%=product.getSalePrice()%></span>원</td>
						<%--총상품금을 수량에 따라서 변경하기 위해 판매가에 id값을 붙인다. --%>
					</tr>
					<tr>
						<th class="p-2">수량</th>
						<td>
							<%-- productNo와 수량값을 전달해주기 위해 form을 만들고 id 값을 줍니다.
									*form은 티가 나지 않기 때문에 상품 설명란쪽에 넣어도 상관없습니다.
								form문안에 hidden으로 productNo을 뽑아낼 수 있는 input을 넣고
								고객이 입력한 상품 수량 값을 가져오는 quantity input을 넣습니다.--%>
							<form id="product-form">
							<input type="hidden" name="productNo" value="<%=product.getNo() %>" />
							<%--총상품금을 수량에 따라서 변경하기 위해 수량 input박스에 id값을 붙인다. --%>
							<input class=" p-2" name="quantity" type="number" min="1" max="100" id="productQuantity" value="1" onchange="updateTotalPrice()">
							</form>
						</td>
					</tr>
					<tr>
						<th class="p-2">총상품금액</th>
						<td class="p-2"><span id="totalPrice"><%=product.getSalePrice()%></span>원</td>
						<%--총상품금을 수량에 따라서 변경하기 위해 id값을 붙인다. --%>
					</tr>
					<tr>
				</tbody>
			</table>
			<hr />
			<%-- 버튼 형식으로 만들고 onclick기능을 넣어 클릭시 function-cart(),buy()가 실행되게 합니다. 비 로그인시 버튼이 활성화 되지 않게 했습니다. --%>
			<button type="button" onclick="cart()" class="btn btn-lg  <%=user == null ? "btn-outline-secondary disabled" : "btn-outline-primary" %>">장바구니</button>
			<button type="button" onclick="buy()" class="me-3 btn btn-lg  <%=user == null ? "btn-outline-secondary disabled" : "btn-outline-primary" %>">바로구매</button>
		</div>
	</div>
	
	<div class="row mt-5 mb-3 text-center">
		<div class="col-12">
			<nav class="nav nav-pills flex-column flex-sm-row  g-2">
			  <a class="border flex-sm-fill text-sm-center nav-link active rounded-0" aria-current="page" href="#detail-row">상세정보</a>
			  <a class="border flex-sm-fill text-sm-center nav-link rounded-0" href="#review-row">구매평</a>
			  <a class="border flex-sm-fill text-sm-center nav-link rounded-0" href="#qna-row">Q&A</a>
			</nav>
		</div>
	</div>

	<div class="row mb-3" id="review-row">
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
					
					<div class="col-11">
						<textarea rows="2" class="form-control" name="reviewContent" placeholder="전통주와 함께한 좋은 기억을 다른 분들과 나눠주세요♥" onclick="reviewCheck(<%=product.getNo() %>);" ></textarea>
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
	<div class="row mb-3" id="qna-row">
		<div class="col-12 d-flex justify-content-between">
			<h3>상품 Q&A</h3>
			<div>
				<a href="productQuestionForm.jsp?pdNo=<%=product.getNo() %>" class="btn btn-primary btn-sm  " >상품문의 글쓰기</a>
				<a href="productQuestionlist.jsp" class="btn btn-outline-secondary btn-sm  " >상품문의 전체보기</a>
			</div>
		</div>
	</div>
	<div class="row mb-5">
		<div class="col-12">
		<%
			if(questions.isEmpty()) {
				
		%>
			<div class="text-center">
				<span class="text-center">작성된 문의가 없습니다.</span>
			</div>
		<%
			} else {
		%>
			<div class="accordion" id="accordionExample">
		<%	
				 for (QuestionDto question : questions) {
					
		%>
				<div class="accordion-item">
			    	<h2 class="accordion-header" id="heading-<%=question.getNo() %>">
			      		<button class="accordion-button  collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse-<%=question.getNo() %>" aria-expanded="true" aria-controls="collapse-<%=question.getNo() %>">
			         		<span class="me-3"><%=question.getNo() %></span>
					 		<strong class="me-5"><%=question.getTitle() %></strong>
					 		<span class="me-5"><%=question.getUserName() %></span>
					 		<span><%=question.getCreatedDate() %></span>
			      		</button>
			    	</h2>
			    	<div id="collapse-<%=question.getNo() %>" class="accordion-collapse collapse" aria-labelledby="heading-<%=question.getNo() %>" data-bs-parent="#accordionExample">
			      		<div class="accordion-body">
			        		<strong>Q.<%=question.getTitle() %></strong>
			        		<p><%=question.getContent() %></p>
							<strong>A.답변드립니다.</strong>
							<P><%=question.getAnswerContent() %></P>
			      		</div>
			    	</div>
			  	</div>
		<%
				 }
		%>
			</div>		
		<%
			}
		%>
		</div>
	</div>
		
		
		
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">

	function questionUserCheck(productNo) {
		let islogin = document.quertSelector("#is-login").value
		if (islogin === "no") {
			alert("쇼핑몰 회원님만 글작성 가능합니다.")
			return;
		}
	}
	
	// 바로구매 클릭시 활성화되는 기능입니다. 꼭 기억하기
	function buy() {
		let form = document.getElementById("product-form");
		// form에서 id를 통해 값을 가져옵니다.
		form.setAttribute("action","orderForm.jsp");
		// setAttribute를 통해 action 기능을 넣고 orderForm.jsp 페이지로 넘어가게 만들었습니다.
		form.submit();
		// 제출
	}
	// 장바구니 클릭시 활성화되는 기능입니다.
	function cart() {
		let form = document.getElementById("product-form");
		// form에서 id를 통해 값을 가져옵니다.
		form.setAttribute("action","cartItemAdd.jsp");
		// setAttribute를 통해 action 기능을 넣고 orderForm.jsp 페이지로 넘어가게 만들었습니다.
		form.submit();
		// 제출
	}
	// 수량을 조절할 경우 활성화되는 기능입니다.
	function updateTotalPrice() {
		let span1 = document.getElementById("salePrice");
		let input = document.getElementById("productQuantity");
		let span2 = document.getElementById("totalPrice");
		
		let price = parseInt(span1.textContent);
		// 태그 사이의 값은 textContent로 뽑아온다.
		let quantity = parseInt(input.value);
		// input안의 값은 value로 뽑아온다.
		let totalPrice = price * quantity;
		
		span2.textContent = totalPrice;
	}
	
	function reviewCheck(productNo) {
		// 리뷰체크 기능입니다.
		let xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if (xhr.readyState === 4 && xhr.status === 200) {
				let jsonText = xhr.responseText;
				let result = JSON.parse(jsonText);
				if (result.msg === "logout") {
					// 비로그인시
					alert("쇼핑몰 회원님만 글작성 가능합니다.")
					//리뷰관련된 모든 기능을 중단합니다.
					document.querySelector("textarea[name=reviewContent]").readOnly=true;
					document.querySelector("button[name=reviewBotten]").disabled=true;
					document.querySelector("input[name=reviewFileName]").disabled=true;
					document.querySelector("select[name=reviewScore]").disabled=true;
					return;
				}
				if (result.msg === "deny") {
					alert("해당 상품을 구매하신 회원님만 글작성이 가능합니다.")
					document.querySelector("textarea[name=reviewContent]").readOnly=true;
					document.querySelector("button[name=reviewBotten]").disabled=true;
					document.querySelector("input[name=reviewFileName]").disabled=true;
					document.querySelector("select[name=reviewScore]").disabled=true;
					return;
				}
				if (result.msg === "exist") {
					alert("두개 이상의 리뷰를 작성하실 수 없습니다.")
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
	
</script>
</body>
</html>

