<%@page import="java.net.URLEncoder"%>
<%@page import="util.PasswordUtil"%>
<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 요청 파라미터 값 조회
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String tel = request.getParameter("tel");
	String postcode = request.getParameter("postcode");
	String addr = request.getParameter("addr");
	String detailAddr = request.getParameter("detailAddr");
	
	UserDao userDao = UserDao.getInstance();
	
	// 중복된 아이디 존재여부 확인
	User savedUser = userDao.getUserById(id);
	if (savedUser != null) {
		response.sendRedirect("registerform.jsp?fail=id&id=" + id);
		return;
	}
	
	savedUser = userDao.getUserByEmail(email);
	if (savedUser != null) {
		response.sendRedirect("registerform.jsp?fail=email&email=" + email);
	}
	
	String secretPassword = PasswordUtil.generateSecretPassword(id, password);
	
	User user = new User();
	
	user.setId(id);
	user.setPassword(secretPassword);
	user.setName(name);
	user.setEmail(email);
	user.setTel(tel);
	user.setPostCode(postcode);
	user.setAddress(addr);
	user.setDetailAddress(detailAddr);
	
	userDao.insertUser(user);
	
	// 회원가입이 완료되면 회원가입롼료 화면에 이름을 표시한다. 한글을 요청파라미터로 보낼 때, 깨지므로 인코딩 사용
	response.sendRedirect("registerComplete.jsp?name=" + URLEncoder.encode(name, "utf-8"));
	



%>

















