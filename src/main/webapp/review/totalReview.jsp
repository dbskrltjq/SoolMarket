<%@page import="dto.ReviewDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.ReviewDao"%>
<%@page import="util.StringUtil"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bootstrap demo</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="../common/nav.jsp">
	<jsp:param name="menu" value="login"/>
</jsp:include>
<div class="container">
	<div class="row border-bottom">
	<% 
		User user = (User) session.getAttribute("LOGINED_USER");
	%>
		<div class="col-11 text-start"><h4><strong>전체후기</strong></h4></div>
		<div class="col-1">
			<a href="" class="btn btn-primary btn-sm  <%=user == null ? "disabled" : "" %>" onclick=""> 리뷰등록</a>
		</div>
	</div>
	<div class="row p-4 border-bottom">
		<div class="col">
			<select class="form-select form-select-sm" id="" onchange="">
				<option value="" selected="selected" disabled="disabled">카테고리선텍</option>
				<option value=""></option> 
				<option value=""></option> 
				<option value=""></option> 
			</select>
		</div>
		<div class="col">
			<select class="form-select form-select-sm" id="" onchange="">
				<option value="" selected="selected" disabled="disabled">카테고리선텍</option>
				<option value=""></option> 
				<option value=""></option> 
				<option value=""></option> 
			</select>
		</div>
		<div class="col">
			<input class="form-control form-control-sm" type="text" name="keyword" value="" placeholder="검색어를 입력하세요."/>
		</div>
		<div class="col-1">
			<button type="button" class="btn btn-secondary btn-sm" onclick="">검색</button>
		</div>
	</div>
	
	<%
		ReviewDao reviewDao = ReviewDao.getInstance();
	
		int rows = 5;
		int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);
		
		int pages = 5;
		int counts = reviewDao.getTotalRows();
		
		int totalPages = (int) (Math.ceil((double) counts/rows));
		int totalBlocks = (int) (Math.ceil((double) totalPages/pages));
		
		if (currentPage <= 0 || currentPage > totalPages) {
			response.sendRedirect("totalReview.jsp?page=1");
			return;
		}
		
		int currentBlock = (int) (Math.ceil((double) currentPage/pages));
		
		int beginPage = (currentBlock - 1) * pages + 1;
		int endPage = (currentBlock == totalBlocks ? totalPages : currentBlock*pages);
		
		int beginIndex = (currentPage - 1)*rows + 1;
		int endIndex = currentPage*rows;
		
		List<ReviewDto> reviews = reviewDao.getReviews(beginIndex, endIndex);
	
	%>
	<%
		for(ReviewDto review : reviews) {
	%>
	
	<div class="row border-bottom mb-3">
		<div class="col-2 py-2 ">
			<div>
				<img alt="" src="../images/sample1.jpg" class="img-thumbnail">
			</div>
			<p class="text-muted mb-1"><%=review.getCreatedDate() %></p>
			<p class="text-muted"><%=review.getUserId() %></p>
		</div>
		<div class="col-10 p-3">
			<h3 class="fs-5 text-bold"><%=review.getPdName() %> </h3>
			<p class="small"><%=review.getContent() %></p>
			<div>
				<img alt="" src="../images/sample1.jpg" class="img-thumbnail" width="100">
			</div>
			<p><a href="">1</a>개의 댓글이 있습니다. <span class="text-info">추천 </span> : <span class="test-info">1</span> <a href="" class="btn btn-info btn-sm">추천하기</a></p>
		</div>
	</div>
	<%
		}
	%>
	<div class="row">
		<div class="col">
			<nav>
				<ul class="pagination justify-content-center">
					<li class="page-item"><a class="page-link <%=currentPage == 1 ?"disabled" : "" %>" href="list.jsp?page=<%=currentPage-1 %>">이전</a></li>
					
					<%
						for(int num = beginPage; num <= endPage; num++) {
					%>
					<li class="page-item <%=currentPage == num ? "active" : "" %>">
						<a class="page-link" href="totalReview.jsp?page=<%=num%>"><%=num%></a></li>
					<%
						}
					%>
					
					<li class="page-item">
						<a class="page-link <%=currentPage >= totalPages ? "disabled" : "" %>" href="list.jsp?page=<%=currentPage +1 %>">다음</a></li>
				</ul>
			</nav>
		</div>
	</div>
	


</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>