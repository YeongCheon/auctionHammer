<%@page import="java.awt.Insets"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="org.owasp.esapi.ESAPI" %>
<%@ page import="dao.UserDao" %>
<%@ page import="dao.BoardArticleDao" %>
<%@ page import="bean.BoardArticle" %>
<%@ page import="bean.User" %>
<%
	BoardArticleDao boardArticleDao = new BoardArticleDao();
	UserDao userDao = new UserDao();
	request.setCharacterEncoding("utf-8");
	User user = userDao.userGet((String)request.getSession().getAttribute("userID"));
	
	int listId = Integer.parseInt(request.getParameter("listId"));
	String writer = ESAPI.encoder().encodeForHTML((String)request.getSession().getAttribute("userID"));
	String title = ESAPI.encoder().encodeForHTML(request.getParameter("title"));
	String content = request.getParameter("contents");
	boolean isNotice = false;
	if(request.getParameter("isNotice") != null && user.getUser_type().equals(User.TYPE_ADMIN)){
		isNotice = true;
	}
	
	BoardArticle boardArticle = new BoardArticle(listId,writer, title, content, isNotice);
	
	boolean inserted = false;
	if(boardArticleDao.insertArticle(boardArticle) > 0){
		inserted = true;
	} else{
		inserted = false;
	}
%>
<c:set var="inserted" value="<%= inserted %>"/>

<c:if test="${inserted}}">
	<script>alert("글작성 성공!");<script>
</c:if>
<c:if test="${!inserted}">
	<script>alert("글작성 실패...");</script>
</c:if>

<script>location.href="./articleList.jsp";</script>