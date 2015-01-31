<%@ page language="java" contentType="text/json; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="bean.User" %>
<%@ page import="dao.UserDao" %>
<%
	UserDao userDao = new UserDao();

	String user_id = request.getParameter("user_id");
	
	User user = userDao.userGet(user_id);
	
	String result = "";
	String msg = null;
	boolean able = false;
	
	if (user == null) {
		msg = "사용가능";
		able = true;
	} else {
		msg = "사용 불가능";
		able = false;
	}
	
	result += "{";
	result += "\"msg\" : \"" + msg + "\", ";
	result += "\"able\" : \"" + able + "\"";
	result += "}";
%>
<c:set var="result" value="<%= result %>"/>
${result}