<%@page import="vo.Pagination"%>
<%@page import="vo.Category"%>
<%@page import="dao.CategoryDao"%>
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
	<div class="row border-bottom p-5">
	<%
		User user = (User) session.getAttribute("LOGINED_USER");
	%>
		<div class="col-11 text-start"><h4><strong>전체후기</strong></h4></div>
		<div class="col-1">
			<a href="" class="btn btn-primary btn-sm  <%=user == null ? "disabled" : "" %>" onclick=""> 리뷰등록</a>
		</div>
	</div>
	
	<%
		CategoryDao categoryDao = CategoryDao.getInstance();
		List<Category> categories = categoryDao.getCategories();
		ReviewDao reviewDao = ReviewDao.getInstance();
		
		int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);
		int rows = StringUtil.stringToInt(request.getParameter("rows"), 5);
		String keyword = StringUtil.nullToBlank(request.getParameter("keyword"));
		int categoryNo = StringUtil.stringToInt(request.getParameter("category"));
		String arrangement = request.getParameter("arrangement");

		// 전체 데이터 갯수 조회
		int totalRows = 0;
		if (keyword.isEmpty()) {
			totalRows = reviewDao.getTotalRows();
		} else {
			totalRows = reviewDao.getTotalRows(keyword);
		}
		
		
		// 페이징처리에 필요한 정보를 제공하는 객체 생성
		Pagination pagination = new Pagination(rows, totalRows, currentPage);
		
	
		List<ReviewDto> reviews = null;
		
		if (categoryNo == 0) {
			if(keyword.isEmpty()) {
				if ("date".equals(arrangement)) {
					reviews = reviewDao.getReviewsOrderByDate(pagination.getBeginIndex(), pagination.getEndIndex());
				} else if ("score".equals(arrangement)) {
					reviews = reviewDao.getReviewsOrderByScore(pagination.getBeginIndex(), pagination.getEndIndex());
				} else if ("likeCount".equals(arrangement)) {
					reviews = reviewDao.getReviewsOrderByLikeCount(pagination.getBeginIndex(), pagination.getEndIndex());
				} else {
					reviews = reviewDao.getReviewsOrderByDate(pagination.getBeginIndex(), pagination.getEndIndex());
				}
			} else {
				if ("date".equals(arrangement)) {
					reviews = reviewDao.getReviewsOrderByDate(pagination.getBeginIndex(), pagination.getEndIndex(), keyword);
				} else if ("score".equals(arrangement)) {
					reviews = reviewDao.getReviewsOrderByScore(pagination.getBeginIndex(), pagination.getEndIndex(), keyword);
				} else if ("likeCount".equals(arrangement)) {
					reviews = reviewDao.getReviewsOrderByLikeCount(pagination.getBeginIndex(), pagination.getEndIndex(), keyword);
				} else {
					reviews = reviewDao.getReviewsOrderByDate(pagination.getBeginIndex(), pagination.getEndIndex(), keyword);
				}
			}
		} else {
			if(keyword.isEmpty()) {
				if ("date".equals(arrangement)) {
					reviews = reviewDao.getReviewsUseCategoryNoOrderByDate(pagination.getBeginIndex(), pagination.getEndIndex(), categoryNo);
				} else if ("score".equals(arrangement)) {
					reviews = reviewDao.getReviewsUseCategoryNoOrderByScore(pagination.getBeginIndex(), pagination.getEndIndex(), categoryNo);
				} else if ("likeCount".equals(arrangement)) {
					reviews = reviewDao.getReviewsUseCategoryNoOrderByLikeCount(pagination.getBeginIndex(), pagination.getEndIndex(), categoryNo);
				} else {
					reviews = reviewDao.getReviewsUseCategoryNoOrderByDate(pagination.getBeginIndex(), pagination.getEndIndex(), categoryNo);
				}
			} else {
				if ("date".equals(arrangement)) {
					reviews = reviewDao.getReviewsUseCategoryNoOrderByDate(pagination.getBeginIndex(), pagination.getEndIndex(), categoryNo, keyword);
				} else if ("score".equals(arrangement)) {
					reviews = reviewDao.getReviewsUseCategoryNoOrderByScore(pagination.getBeginIndex(), pagination.getEndIndex(), categoryNo, keyword);
				} else if ("likeCount".equals(arrangement)) {
					reviews = reviewDao.getReviewsUseCategoryNoOrderByLikeCount(pagination.getBeginIndex(), pagination.getEndIndex(), categoryNo, keyword);
				} else {
					reviews = reviewDao.getReviewsUseCategoryNoOrderByDate(pagination.getBeginIndex(), pagination.getEndIndex(), categoryNo, keyword);
				}
			}
		}
			
	%>
	
	<form id="serch-form" method="get" action="totalReview.jsp">
		<div class="row p-4 border-bottom">
			<div class="col">
				<select class="form-select form-select-sm" name="category" >
					<option value="0" selected="selected" disabled="disabled">카테고리선택</option>
				<%
					for(Category category : categories) {
				%>	
					<option value="<%=category.getNo() %>"><%=category.getName() %></option>
				<%
					}
				%>
				</select>
			</div>
			<div class="col">
				<select class="form-select form-select-sm" name="arrangement" onchange="">
					<option value="date" selected="selected" >최신순</option>
					<option value="score">평점</option> 
					<option value="likeCount">추천</option> 
				</select>
			</div>
			<div class="col">
				<input class="form-control form-control-sm" type="text" name="keyword" value="<%=keyword %>" placeholder="검색어를 입력하세요."/>
			</div>
			<div class="col-1">
				<button type="submit" class="btn btn-secondary btn-sm" onclick="serch()">검색</button>
			</div>
		</div>
	</form>
	
	
	<%
		for(ReviewDto review : reviews) {
	%>
	
	<div class="row border-bottom mb-3">
		<div class="col-2 py-2 ">
			<div>
				<img alt="" src="../images/sample1.jpg" class="img-thumbnail">
			</div>
			<p class="text-muted mb-1"><%=review.getCreatedDate() %></p>
			<p class="text-muted mb-1">평점 : <span><%=review.getScore() %></span></p>
			<p class="text-muted"><%=review.getUserId() %></p>
		</div>
		<div class="col-10 p-3">
			<h3 class="fs-5 text-bold"><%=review.getPdName() %> </h3>
			<p class="small"><%=review.getContent() %></p>
			<div>
				<img alt="" src="../images/sample1.jpg" class="img-thumbnail" width="100">
			</div>
			<p><a href="">1</a>개의 댓글이 있습니다. <span class="text-info">추천 </span> : <span class="test-info"><%=review.getLikeCount() %></span> <a href="" class="btn btn-info btn-sm">추천하기</a></p>
		</div>
	</div>
	<%
		}
	%>
	<div class="row">
		<div class="col">
			<nav>
				<ul class="pagination justify-content-center">
					<li class="page-item"><a class="page-link <%=pagination.getCurrentPage() == 1 ?"disabled" : "" %>" href="list.jsp?page=<%=pagination.getCurrentPage() -1 %>">이전</a></li>
					
					<%
						for(int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
					%>
					<li class="page-item <%=pagination.getCurrentPage() == num ? "active" : "" %>">
						<a class="page-link" href="totalReview.jsp?page=<%=num%>&keyword=<%=keyword%>&category=<%=categoryNo%>&arrangement=<%=arrangement%>"><%=num%></a></li>
					<%
						}
					%>
					
					<li class="page-item">
						<a class="page-link <%=pagination.getCurrentPage() >= pagination.getTotalPages() ? "disabled" : "" %>" href="list.jsp?page=<%=pagination.getCurrentPage() +1 %>">다음</a></li>
				</ul>
			</nav>
		</div>
	</div>
	


</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
	
	
	
</script>
</body>
</html>