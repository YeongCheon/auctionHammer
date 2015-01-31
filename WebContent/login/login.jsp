<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="bean.User" %>
<%@ page import="dao.UserDao" %>
<%
	UserDao userDao = new UserDao();

	String id = request.getParameter("userID");
	String pwd = util.Sha256Util.getEncrypt(request.getParameter("userPwd"));
	User user = userDao.userGet(id, pwd);
	
	boolean result = false;
	
	
	if(user != null){
		session.setAttribute("userID", user.getUser_id());
		session.setAttribute("userName", user.getUser_name());
		session.setAttribute("userNicname", user.getUser_nicname());
		session.setAttribute("userType", user.getUser_type());
		
		result = true;
	} 	
	
%>
<c:set var="logined" value="<%= result %>"/>
<c:choose>
	<c:when test="${logined == true }">
		<script>alert('환영합니다 ${sessionScope.userName} 님');location.href="../index.jsp";</script>	
	</c:when>
	<c:otherwise>
		<script>alert('아이디 혹은 패스워드가 잘못되었습니다.');location.href="./loginForm.jsp";</script>	
	</c:otherwise>
</c:choose>