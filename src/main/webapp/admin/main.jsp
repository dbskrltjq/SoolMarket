<!DOCTYPE html>
<%@page import="vo.User" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="../error/500.jsp"%>
<%
	//세션에서 로그인된 관리자정보를 조회한다.
	User admin = (User) session.getAttribute("ADMIN");
	if (admin == null) {
	throw new RuntimeException("해당 서비스는 관리자만 이용할 수 있습니다.");
}      
%>
<html lang="ko">
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
	
	</style>
</head>
<body>
<jsp:include page="admintop.jsp"></jsp:include>
<div class="container-fluid">
	<div class="row h-100">
		<div class="col-2 p-0">
			<jsp:include page="adminleft.jsp"></jsp:include>
		</div>
		<div class="col-10">
 			<div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">SulMarket 관리자 페이지입니다.</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">Dashboard</li>
                        </ol>
                     </div>
                </main>
                
            </div>
   		</div>
			<jsp:include page="adminbottom.jsp"></jsp:include>
	</div>
</div>
</body>
</html>