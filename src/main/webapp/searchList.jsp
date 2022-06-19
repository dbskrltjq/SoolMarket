<%@page import="dao.ProductDao"%>
<%@page import="vo.Pagination"%>
<%@page import="util.StringUtil"%>
<%@page import="vo.Category"%>
<%@page import="vo.Product"%>
<%@page import="java.util.List"%>
<%@page import="dao.CategoryDao"%>
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
<jsp:include page="common/nav.jsp">
	<jsp:param name="menu" value="list"/>
</jsp:include>
<div class="container">
	<div class="text-center">
		<img src="images/cate_01.jpg">
	</div>
	
<%
	CategoryDao categoryDao = CategoryDao.getInstance();
	ProductDao productDao = ProductDao.getInstance();
	
	String keyword = request.getParameter("keyword");
	if (keyword == null || keyword.isEmpty()) {
		keyword = "안동소주";
	}
	
	String sort = request.getParameter("sort");

	int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);			// 현재페이지 지정
	int rows = StringUtil.stringToInt(request.getParameter("rows"), 5);					// 페이지에 표시될 행 개수
	
	int totalQuantity = categoryDao.getTotalQunatity(keyword);
	
	int totalRows = productDao.getTotalRows(keyword);									// 전체 행 개수(keyword 있을 경우)
	
	Pagination pagination = new Pagination(rows, totalRows, currentPage);

	List<Product> productList = null;
		
	if ("low".equals(sort)) {
		productList = categoryDao.getItemByMinPrice(keyword, pagination.getBeginIndex(), pagination.getEndIndex());
	} else if ("high".equals(sort)) {
		productList = categoryDao.getItemByMaxPrice(keyword, pagination.getBeginIndex(), pagination.getEndIndex());
	} else if ("date".equals(sort)) {
		productList = categoryDao.getItemByDate(keyword, pagination.getBeginIndex(), pagination.getEndIndex());
	} else {
		productList = categoryDao.getItemBySaleQuantity(keyword, pagination.getBeginIndex(), pagination.getEndIndex());
	}
			
%>
	<p><strong>"<%=keyword %>"" 검색결과 <%=totalQuantity %></strong></p>

	<div>
		<form>
		 <div class="row mb-3 border-top border-bottom border-1 p3">
	 		<div class="col p-2">
	 			<a href="searchList.jsp?sort=sell&rows=<%=rows %>&keyword=<%=keyword %>" class="btn btn-outline-primary">판매량순</a>	 
	 			<a href="searchList.jsp?sort=low&rows=<%=rows %>&keyword=<%=keyword %>" class="btn btn-outline-primary">낮은가격순</a>	 	
	 			<a href="searchList.jsp?sort=high&rows=<%=rows %>&keyword=<%=keyword %>" class="btn btn-outline-primary">높은가격순</a>	 	
	 			<a href="searchList.jsp?sort=date&rows=<%=rows %>&keyword=<%=keyword %>" class="btn btn-outline-primary">등록일순</a>
	 		</div>
	 		<select class="form-control form-control-sm w-25 float-end" name="rows" onchange="changeRows();">
	 			<option value="5" <%=rows == 5 ? "selected" : "" %>> 5개씩 보기</option>
	 			<option value="10" <%=rows == 10 ? "selected" : "" %>> 10개씩 보기</option>
	 			<option value="20" <%=rows == 20 ? "selected" : "" %>> 20개씩 보기</option>
	 		</select>
		 </div>
		</form>
	</div>
	<div class="row">
	<%
		for (Product product : productList) {
	%>
            <div class="col-lg-3 col-md-6 mb-4">
               <div class="card h-100">
                   <a href="product/detail.jsp?no=<%=product.getNo() %>" class="text-dark text-decoration-none"><img class="card-img-top" src="images/cate_01.jpg" alt="..." />
                   	 <div class="card-body">
                       <h5 class="card-title fs-6 text-bold"><%=product.getName() %></h5>
                       <p class="mb-1"><del><%=product.getPrice() %></del> 원</p>
                       <p><strong class="text-danger"><%=product.getSalePrice() %></strong> 원</p>
                       <p class="card-text">상품설명(생략가능)</p>
                     </div>
                     <div class="card-footer"><small class="text-muted"><%=product.getReviewScore() %></small></div>
                   	</a>
               </div>
            </div>  
    <%
		}
    %>             
	<nav>
			<ul class="pagination justify-content-center">
				<li class="page-item">
					<a class="page-link <%=pagination.getCurrentPage() == 1 ? "disabled" : "" %>" href="javascript:clickPageNo(<%=pagination.getCurrentPage() - 1 %>)">이전</a>
				</li>
		<%
			for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
		%>
				<li class="page-item">
					<a class="page-link <%=pagination.getCurrentPage() == num ? "active" : "" %>" href="javascript:clickPageNo(<%=num %>)"><%=num %></a>
				</li>
		<%
			}
		%>
				<li class="page-item">
					<a class="page-link <%=pagination.getCurrentPage() == pagination.getTotalPages() ? "disabled" : "" %>" href="javascript:clickPageNo(<%=pagination.getCurrentPage() + 1 %>)">다음</a>
				</li>
			</ul>
	</nav>
		<form id="search-form" class="row g-3" method="get" action="searchList.jsp">
			<input type="hidden" name="keyword" value=<%=keyword %> />
			<input type="hidden" name="sort" value=<%=sort %> />	
			<input type="hidden" name="page" />
			<input type="hidden" name="rows" />	
		</form>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script>
	function changeRows() {
		document.querySelector("input[name=page]").value = 1;
		document.querySelector("input[name=rows]").value = document.querySelector("select[name=rows]").value;
		document.getElementById("search-form").submit();
	}
	function clickPageNo(pageNo) {
		document.querySelector("input[name=page]").value = pageNo;
		document.querySelector("input[name=rows]").value = document.querySelector("select[name=rows]").value;
		document.getElementById("search-form").submit();
	}


</script>
</body>
</html>