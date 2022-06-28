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
<style type="text/css">
</style>
</head>
<body>
<jsp:include page="common/nav.jsp"></jsp:include>
	<div class="container"> 
		<div class="row">
			<h1>회원가입완료페이지입니다.</h1>
			<%
				String name = request.getParameter("name");
			%>
					<strong><%=name %></strong>님 환영합니다.
		
		</div>
	</div>




<div class="container" >
	
</div>
   

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
	
	
	
</script>
</body>
</html>