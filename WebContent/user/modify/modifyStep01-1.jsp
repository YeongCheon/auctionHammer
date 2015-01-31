<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="util.Sha256Util" %>
<%@ page import ="bean.User" %>
<%@ page import="dao.UserDao"%>
<%
	UserDao userDao = new UserDao();

	String userID = (String)request.getSession().getAttribute("userID");
	String userPwd = request.getParameter("userPwd");
	
	boolean isOk = false;
	
	request.setCharacterEncoding("UTF-8");
	
	User user = null;
	
	user = userDao.userGet(userID, Sha256Util.getEncrypt(userPwd));
	
	if(user != null){
		request.getSession().setAttribute("modify_auth", "pass");
		request.getSession().setAttribute("password", user.getUser_password());
		isOk = true;
	}else{		
		isOk = false;
	}
%>
<c:set var="isOk" value="<%= isOk %>"/>

<<c:if test="${isOk}">
	<script>alert('인증 성공');location.href='./modifyStep02.jsp';</script>
</c:if>
<<c:if test="${!isOk}">
	<script>alert('인증 실패');location.href='./modifyStep01.jsp';</script>
</c:if>
	
