<%@page import="dto.QuestionDto"%>
<%@page import="java.util.List"%>
<%@page import="vo.Pagination"%>
<%@page import="dao.ProductQuestionDao"%>
<%@page import="util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>상품문의 전체보기</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="common/nav.jsp">
	<jsp:param name="menu" value="qlist"/>
</jsp:include>

		<%
			int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);
			int rows = StringUtil.stringToInt(request.getParameter("rows"), 5);
			
			ProductQuestionDao questionDao = ProductQuestionDao.getInstance();
			
			int totalRows = 0;
			
			totalRows = questionDao.getTotalRows();
			
			Pagination pagination = new Pagination(rows, totalRows, currentPage);
			
			List<QuestionDto> questionList = null;
			questionList = questionDao.getQuestions(pagination.getBeginIndex(), pagination.getEndIndex());
		%>

<div class="container mt-3 mb-5">
		<div class="row mb-5">
			<div>
				<h1 class="fs-4 border p-2 ">상품문의 목록</h1>
				<hr>
			</div>
		</div>
		
		<table class="table">
			<colgroup>
				<col width="10%">
				<col width="15%">
				<col width="%">
				<col width="10%">
				<col width="10%">
			</colgroup>
			<thead>
					<tr>
						<th>문의날짜</th>
						<th>문의 번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>문의상태</th>
					</tr>
				</thead>
				<tbody class="table-group-divider">
			<%
				for(QuestionDto question : questionList) {
			%>
					<tr>
						<td><%=question.getCreatedDate() %></td>
						<td><%=question.getNo() %></td>
						<td><%=question.getTitle() %></td>
						<td><%=question.getAnswerContent() %></td>
						<td><%=question.getUserName() %></td>
						
					</tr>
			<%
				}
			%>
		</table>
		
</div>
		
		

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
</script>
</body>
</html>