<%@page import="vo.Product"%>
<%@page import="dao.ProductDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>상품문의 글쓰기</title>
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
			<div class="row">
				<div class="col">
			
			<form class="border bg-light p-3" method="post" action="questionadd.jsp" onsubmit="return submitQuestionForm()">
				<input type="hidden" name="pdNo" value="<%=product.getNo() %>" />
				<div class="mb-3 p-2">
					<label class="form-label p-2">제목</label>
					<input type="text" class="form-control p-2" name="title" />
				</div>
				
				<div class="mb-3 p-2">
					<label class="form-label p-2">내용</label>
					<textarea rows="20" class="form-control p-2" name="content"></textarea>
				</div>
				
				<div class="text-end p-2 ">
					<button class="btn btn-secondary" onclick="window.close()">취소</button>
					<button type="submit" class="btn btn-primary p-2">등록</button>
				</div>
			</form>
				</div>
			</div>
		</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">

	function submitQuestionForm() {
		let titleField = document.querySelector("input[name=title]");
		if (titleField.value === '') {
			alert("제목은 필수입력값입니다.");
			titleField.focus();
			return false;
		}
		let contentField = document.querySelector("textarea[name=content]");
		if (contentField.value === '') {
			alert("내용은 필수입력값입니다.");
			contentField.focus();
			return false;
		}
		return true;
	}

</script>
</body>
</html>