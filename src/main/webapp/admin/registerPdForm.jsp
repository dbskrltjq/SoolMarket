<!DOCTYPE html>
<%@page import="vo.User" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
</head>
<body>
<jsp:include page="admintop.jsp"></jsp:include>
<div class="container-fluid">
	<div class="row">
		<div class="col-2 p-0">
			<jsp:include page="adminleft.jsp"></jsp:include>
		</div>
		<div class="col-10">
 			<div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="my-4">새상품등록페이지입니다.</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active"><button type="button" class="btn btn-primary" id="registerBtn">상품등록하기</button></li>
                        </ol>
                            
                        <div class="card mb-4 mb-5">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                새로운 상품 목록
                            </div>
                            <div class="card-body">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>상품명</th>
                                            <th>제조사</th>
                                            <th>정가</th>
                                            <th>판매가격</th>
                                            <th>입고량</th>
                                            <th>입고날짜</th>
                                            <th>비고</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>막걸리</td>
                                            <td>국순당</td>
                                            <td>4000원</td>
                                            <td>3000원</td>
                                            <td>50개</td>
                                            <td>2022/06/20</td>
                                            <td></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </main>
                
            </div>
   		</div>
	</div>
</div>
<jsp:include page="adminbottom.jsp"></jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">

	document.getElementById("registerBtn").onclick = function() {
		window.open("pdPopup.html", "팝업테스트", "width=400, height=300, top=10, left=10");
	}







</script>
</body>
</html>