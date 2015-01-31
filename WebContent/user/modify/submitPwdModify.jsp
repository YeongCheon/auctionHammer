<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import ="bean.User" %>
<%@ page import="dao.UserDao"%>
<%
	UserDao userDao = new UserDao();
	boolean updated = false;
	
	request.setCharacterEncoding("utf-8");
	
	User user = new User();
	
	String id = (String)request.getSession().getAttribute("userID");
	String password = request.getParameter("user_password");
	
	user.setUser_id(id);
	user.setUser_password(password);
	System.out.println(user.getUser_password());
	
	
	if (userDao.userModifyPassword(user) > 0) {
		updated = false;
	} else{
		updated = true;
	}
%>

<c:set var="updated" value="<%= updated %>"/>
<c:if test="${!updated}">
	<script type='text/javascript'>alert('비밀번호가 정상적으로 수정되었습니다.');location.href='${pageContext.request.contextPath}/index.jsp';</script>
</c:if>
<c:if test="${updated}">
	<script type='text/javascript'>alert('비밀번호 변경에 실패하였습니다.');location.href='${pageContext.request.contextPath}/index.jsp';</script>
</c:if>