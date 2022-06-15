<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@page import="util.PasswordUtil"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<% 
	User user = (User) session.getAttribute("LOGINED_USER");
	String userId = user.getId();
	

	// 사용자가 입력한 비밀번호를 암호화한 것
	String inputPassword =PasswordUtil.generateSecretPassword(userId, request.getParameter("password"));
	
	UserDao userDao = UserDao.getInstance();
	
	String password = user.getPassword();
	
	Map<String, Boolean> result = new HashMap<>();
	
	// DB에 저장된 사용자의 번호와 일치하면 {check: true}, 불일치하면 {check: false} 를 저장한다.
	if (!inputPassword.equals(password)) {
		result.put("check", false);
	} else {
		result.put("check", true);
	}

 	
 	Gson gson = new Gson();
 	String jsonText = gson.toJson(result);
 	out.write(jsonText);
 %>