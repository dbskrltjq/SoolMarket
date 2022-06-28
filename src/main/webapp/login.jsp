<%@page import="org.apache.catalina.authenticator.SavedRequest"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="util.PasswordUtil"%>
<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
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
<%
	String id = request.getParameter("id");    // 사용자가 입력한 아이디
	String password = request.getParameter("password");			// 사용자가 입력한 비밀번호
	String job = request.getParameter("job");		// 관리자 로그인용
	
	// 사용자가 입력한 아이디와 비밀번호로 암호비밀문을 만들고 DB에 저장되어
	// 있는 암호비밀문과 일치하는지 확인한다.
	String secretPassword = PasswordUtil.generateSecretPassword(id, password);
	UserDao userDao = UserDao.getInstance();
	
	
	if("admin".equals(job)) {
		User admin = userDao.getAdminById(id);
		
		if(admin != null && secretPassword.equals(admin.getPassword())) {
			session.setAttribute("ADMIN", admin);
			response.sendRedirect("admin/main.jsp?name=" + URLEncoder.encode(admin.getName(), "utf-8"));			// 사용자는 home.jsp, 관리자는 main.jsp
			return;
			
		} else {
			response.sendRedirect("loginform.jsp?fail=invalid");
			return;
		}
	}
	
	if("user".equals(job)) {
		
		User savedUser = userDao.getUserById(id);
		
		// 라디오박스를 회원으로 체크한 관리자일 경우
		if(savedUser != null && "Y".equals(savedUser.getIsAdmin())) {
			response.sendRedirect("loginform.jsp?fail=notUser");
			return;
		}
	
		if (savedUser == null) {
			response.sendRedirect("loginform.jsp?fail=invalid");
			return;
		}
	
	
		if(!secretPassword.equals(savedUser.getPassword())) {				
			response.sendRedirect("loginform.jsp?fail=invalid");
			return;
		}
	
		// 탈퇴한 사용자일 경우 
		if ("Y".equals(savedUser.getDeleted())) {
			response.sendRedirect("loginform.jsp?fail=deleted");
			return;
		}
	
		session.setAttribute("LOGINED_USER", savedUser);
		String saved = request.getParameter("saved");
		User user = (User)session.getAttribute("LOGINED_USER");
		
		response.sendRedirect("home.jsp");
	
	}
	
%>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
	
	<%-- <%
		if ("yes".equals(saved)) {
	%>
		let savedUserId = "<%= %>";
	
		localStorage.setItem("savedId", savedUserId);	// "savedId" : idValue 의 key : value 형식으로 localStroage에 저장한다.
		localStorage.setItem("checked", "yes");	
	<%		
	} else {
	%>
		localStorage.setItem("checked", "no");		
		localStorage.removeItem("savedId");	
	<%		
	}
	%> --%>
	
</script>
</body>
</html>