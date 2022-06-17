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
	 .list-group-item {font-size:small; }
</style>
	
</head>

<body>
<jsp:include page="common/nav.jsp"></jsp:include>

<div class="container" style="padding: 30px;">
   <div class="row ">
      <div class="col-2">
         <h5 class="border-bottom pb-2  mb-4"><strong>마이페이지</strong></h5>

         	<p><strong class="fs-6">쇼핑정보</strong><p>
         	<div class="list-group list-group-flush mb-4">
         		<a href="#" class="list-group-item list-group-item-action">- 주문목록</a>
         		<a href="#" class="list-group-item list-group-item-action">- 취소 내역</a>
         		<a href="#" class="list-group-item list-group-item-action">- 장바구니 보기</a>
			</div>
			<p><strong class="fs-6">회원정보</strong></p>
         	<div class="list-group list-group-flush">
         		<a href="myPagePassword.jsp" class="list-group-item list-group-item-action">- 회원정보 변경</a>
         		<a href="userDelete.jsp" class="list-group-item list-group-item-action">- 회원 탈퇴</a>
         		<a href="#" class="list-group-item list-group-item-action">- 나의 상품문의</a>
			</div>
      </div>
      <div class="col-10">
         <div class="row mb-5 border-bottom">
            <div class="col-12">
               <h5><strong>회원탈퇴</strong></h5>
            </div>
         </div>
         <div class="row mb-5">
            <p>01. 회원탈퇴 안내</p>
            <div class="col-12 p-5" style="border: solid;">
            <div>
            	<p>탈퇴하지마<br>
					탈퇴하지마탈퇴하지마탈퇴하지마탈퇴하지마탈퇴하지마탈퇴하지마탈퇴하지마탈퇴하지마탈퇴하지마탈퇴하지마탈퇴하지마탈퇴하지마탈퇴하지마탈퇴하지마탈퇴하지마            	
            	</p>
            </div>
            </div>
         </div>
         <div class="row">
         	<p>02. 회원탈퇴 하기</p>
            <div class="col-12" style="border: solid;">
            
         	</div>
         <div class="row my-3">
            <div class="col-12 text-center">
               <a href="myPage.jsp" class="btn btn-outline-secondary"><strong>이전으로</strong></a>
               <button type="submit" class="btn btn-primary"><strong style="color: white;">탈퇴</strong></button>
            </div>
         </div>
         
      </div>
   </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>