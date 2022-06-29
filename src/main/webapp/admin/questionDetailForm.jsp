<%@page import="dao.ProductDao"%>
<%@page import="vo.Product"%>
<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@page import="dto.QuestionDto"%>
<%@page import="dao.ProductQuestionDao"%>
<%@page import="util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="../error/500.jsp" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description" content="" />
	<meta name="author" content="" />
	<title>관리자 페이지</title>
	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
	<link href="css/styles.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
	html, body {
		height: 100%;
	}
	.container-fluid {
		height: 95%;
		border-collapse: collapse;
	}
	h3, h6 {font-weight: bold;}
	th {width: 10%;}
	#user-info td{width: 40%;}
</style>
<%
	//세션에서 로그인된 관리자정보를 조회한다.
	User admin = (User) session.getAttribute("ADMIN");
	if (admin == null) {
		throw new RuntimeException("해당 서비스는 관리자만 이용할 수 있습니다.");
	}  
%>
</head>
<%
	int questionNo = StringUtil.stringToInt(request.getParameter("questionNo"));
	int pdNo = StringUtil.stringToInt(request.getParameter("pdNo"));
	int userNo = StringUtil.stringToInt(request.getParameter("userNo"));
	
	UserDao userDao = UserDao.getInstance();
	User user = userDao.getUserByNo(userNo);
	
	ProductDao productDao = ProductDao.getInstance();
	Product product = productDao.getProductByNo(pdNo);
	
	ProductQuestionDao productQuestionDao = ProductQuestionDao.getInstance();
	QuestionDto questionDto = productQuestionDao.getProductQuestion(questionNo);
%>
<body>
	<jsp:include page="admintop.jsp"></jsp:include>
		<div class="container-fluid">
		   <div class="row h-100" id=first-row >
			   <div class="col-2 p-0" >
			   		<jsp:include page="adminleft.jsp"></jsp:include>
			   </div>
			   <div class="col-10 p-4">
			   		<div class="row m-3">
			   			<h3>문의 상세 페이지</h3>
			   		</div>
					<h6><i class="fa-solid fa-square-info"></i> 상품정보</h6>		   			
			   		<div class="container border border-secondary bg-light" > 
				   		<div class="row m-3">
				   			<div class="col-2">
				   				<a href="../product/detail.jsp?pdNo=<%=pdNo %>"><img src="../<%=product.getImageUrl() %>" alt="이미지 준비중입니다."  class="img-thumbnail"  width="150"></a>
				   			</div>
				   			<div class="col-8">
					   			<div class="row mt-5" style="font-weight: bold;">
				   					<p>상품명: <%=product.getName() %></p>
					   				<p>판매가격: <%=product.getPrice() %> 원</p>
					   			</div>
				   			</div>
				   		</div>
			   		</div>
			   		<div class="row mb-4" style="font-size: small; font-weight: bold;">
						<p><span style="color: red;">※</span> 상품이미지를 클릭하시면 상품상세페이지로 이동합니다.</p>			   				
					</div>
			   		<h6><i class="fa-solid fa-comments-question-check"></i> 문의내역</h6>
			   		<div class="container p-3">
			   		<table class="table border" id="user-info">
			   			<tr>
			   				<th class="bg-light">이름</th>
			   				<td><%=user.getName() %></td>
			   				<th class="bg-light">아이디</th>
			   				<td><%=user.getId() %></td>
			   			</tr>
			   			<tr>
			   				<th class="bg-light">이메일</th>
			   				<td><%=user.getEmail() %></td>
			   				<th class="bg-light">연락처</th>
			   				<td><%=user.getTel() %></td>
			   			</tr>
			   			<tr>
			   				<th class="bg-light">작성일</th>
			   				<td><%=questionDto.getCreatedDate() %></td>
			   				<th class="bg-light">첨부파일</th>
			   				<td></td>
			   			</tr>
			   		</table>
			   		<table class="table border">
			   			<tr>
			   				<th class="bg-light">제목</th>
			   				<td><%=questionDto.getTitle() %></td>
			   			</tr>
			   			<tr>
			   				<th class="bg-light">내용</th>
			   				<td><%=questionDto.getContent() %></td>
			   			</tr>
			   		</table>
			   		<div class="d-flex justify-content-end">
			   	<%
			   		if("N".equals(questionDto.getAnswered())) {
			   	%>
			   			<button class="btn btn-outline-secondary" data-bs-toggle='modal' data-bs-target='#question-answer-modal'>답글작성</button>
			   	<%
			   		}
			   	%>
			   		</div>
			   		</div>
			   		<h6><i class="fa-solid fa-comments-question-check"></i> 답변내역</h6>
			   		<div class="container p-3">
			   	<%
			   		if("N".equals(questionDto.getAnswered())) {
			   			
			   	%>
			   		<strong style="color: red;">!</strong> 답변을 작성해주세요
			   	<%
			   		} else {
			   	%>
			   			<table class="table border">
			   			<tr>
			   				<th class="bg-light">작성일자</th>
			   				<td><%=questionDto.getAnswerCreatedDate() %></td>
			   			</tr>
			   			<tr>
			   				<th class="bg-light">답변내용</th>
			   				<td><%=questionDto.getAnswerContent() %></td>
			   			</tr>
			   		</table>
			   		<button class="btn btn-outline-secondary" data-bs-toggle='modal' data-bs-target='#question-answer-modal'>답글수정</button>
			   	<%
			   		}
			   	%>
			   	
			   	
			   		</div>
			   </div>
			</div>
		</div>
<!-- 모달 -->
<div class="modal fade" id="question-answer-modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
	        <h5 class="modal-title" id="staticBackdropLabel">상품문의 답변쓰기</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	      
	      <div class="row">
					<div class="col-6 py-3 ">
						<div>
							<img alt="이미지 준비중입니다." src="../<%=product.getImageUrl() %>" class="img-thumbnail" width="200">
						</div>
					</div>
					<div class="col-6 p-3">
						<h3 class="fs-5 text-bold"><%=product.getName() %></h3>
						<p><%=product.getName() %></p>
					</div>
				</div>
	       		 <form class="border bg-light p-3" id="answer-form" method="post" action="addAnswer.jsp?job=question" >
					<input type="hidden" name="questionNo" value="<%=questionNo %>" />
					<div class="mb-3">
					<%
						String answerContent = questionDto.getAnswerContent();
					%>
						<label class="form-label">내용</label>	                                <!-- 답글작성과 답글수정 기능을 구분하기 위한 것입니다.  -->
						<textarea rows="5" class="form-control" id="content-form" name="content"><%= answerContent != null ? answerContent : "" %></textarea>
					</div>
				</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="btn-form-close">닫기</button>
	        <button type="button" id="registerBtn" class="btn btn-primary" onclick="submitAnswerForm();">등록하기</button>
	      </div>
    </div>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">

	function submitAnswerForm() {
		document.getElementById("answer-form").submit();
		alert("답변이 등록되었습니다");
	}
	
</script>
</body>
</html>