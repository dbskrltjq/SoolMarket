<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>

 <%
 	Map<String, Object> result = new HashMap<>();
 	Gson gson = new Gson();

 	String inputEmail = request.getParameter("email");
    String job = request.getParameter("job");
    
 	UserDao userDao = UserDao.getInstance(); 	
 	User savedUser = userDao.getUserByEmail(inputEmail); 	 	
    
    // myPageUpdateForm에서 이메일 변경시 (기존 이메일 제외)이메일중복 체크할 때 
    if (job != null && "update".equals(job)) {				// 단일책임의 원칙! 비슷한 기능인데 구분해야할 경우에만 어떤 작업인지 알려주는 요청파라미터를 보내준 것
    	User user = (User) session.getAttribute("LOGINED_USER");
    	
    	if (user != null && inputEmail.equals(user.getEmail())) {
    		result.put("exist", false);			
		 	String jsonText = gson.toJson(result);
		 	out.write(jsonText);
		 	return;
    	}
    }
    
    // findId.jsp에서 
    if(job != null && "findId".equals(job)) {
    	
    	String inputName = request.getParameter("name");
    	
    	if(savedUser != null && inputName.equals(savedUser.getName()) && "N".equals(savedUser.getDeleted())) {
    		result.put("pass", true);
    		result.put("foundId", savedUser.getId());
    		result.put("name", savedUser.getName());
    		
    	} else if(!"N".equals(savedUser.getDeleted())) {
			
			result.put("deleted", true);
			result.put("pass", false);
		} else {
			
			result.put("pass", false);
		}
		
		String jsonText = gson.toJson(result);
	 	out.write(jsonText);
	 	return;
	}
    
 	
 	if (savedUser != null) {
	 	result.put("exist", true); 			
 		
 	} else {
 		result.put("exist", false);	
 	}
 	
 	String jsonText = gson.toJson(result);
 	out.write(jsonText);
 	return;
 %>