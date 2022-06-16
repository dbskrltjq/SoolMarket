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
			<div class="text-center" >
				
					<img src="images/cate_01.jpg">
			</div>
	
<%
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo")) ;
	String sort = request.getParameter("sort");
	
	int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);
	int rows = StringUtil.stringToInt(request.getParameter("rows"), 5);
	
	CategoryDao categoryDao = CategoryDao.getInstance();
	
	int totalRows = 0;

	String categoryName = categoryDao.getCategroyNameByNo(categoryNo);
	int pdQuantity = categoryDao.getTotalQunatity(categoryNo);
	
	List<Product> productList = null;
	if ("sell".equals(sort)) {
		productList = categoryDao.getItemBySaleQuantity(categoryNo);		
	} else if ("low".equals(sort)) {
		productList = categoryDao.getItemByMinPrice(categoryNo);
	} else if ("high".equals(sort)) {
		productList = categoryDao.getItemByMaxPrice(categoryNo);
	} else {
		productList = categoryDao.getItemByDate(categoryNo);
	}
	
%>
	<p><%=categoryName %></p>
	<p>전체상품<strong><%=pdQuantity %></strong>개</p>
	<div class="border-top border-1 border-dark"></div>
	<div>
		<form>
		 <div class="row mb-3">
	 		<div class="col">
	 			<a href="list.jsp?categoryNo=<%=categoryNo %>&sort=sell" class="btn btn-outline-primary">판매량순</a>	 
	 			<a href="list.jsp?categoryNo=<%=categoryNo %>&sort=low" class="btn btn-outline-primary">낮은가격순</a>	 	
	 			<a href="list.jsp?categoryNo=<%=categoryNo %>&sort=high" class="btn btn-outline-primary">높은가격순</a>	 	
	 			<a href="list.jsp?categoryNo=<%=categoryNo %>&sort=date" class="btn btn-outline-primary">등록일순</a>
	 		</div>
		 </div>
		</form>
	</div>
	<div class="border-top border-1"></div>
<%
%>

	<div class="row">
	<%
		for (Product product : productList) {
	%>
            <div class="col-lg-3 col-md-6 mb-4">
               <div class="card h-100">
                   <a href="detail.jsp?no=<%=product.getNo() %>" class="text-dark text-decoration-none"><img class="card-img-top" src="images/cate_01.jpg" alt="..." />
                   	 <div class="card-body">
                       <h5 class="card-title fs-6 text-bold"><%=product.getName() %></h5>
                       <p class="mb-1"><%=product.getPrice() %> 원</p>
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
    </div>
	


</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>