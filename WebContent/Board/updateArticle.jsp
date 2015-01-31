<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="org.owasp.esapi.ESAPI" %>
<%@ page import="dao.BoardArticleDao" %>
<%@ page import="bean.BoardArticle" %>
<%@ page import="bean.User" %>
<%
	BoardArticleDao boardArticleDao = new BoardArticleDao();
	request.setCharacterEncoding("utf-8");
	
	int article_id = Integer.parseInt(request.getParameter("article_id"));
	BoardArticle article = boardArticleDao.getArticle(article_id);
	
	if(request.getSession().getAttribute("userType").equals("") && (request.getSession().getAttribute("userID") == null || !((String)request.getSession().getAttribute("userID")).equals(article.getWriter()))){
		throw new Exception("Error");
	}
	
	int listId = Integer.parseInt(request.getParameter("listId"));
	
	String userID = (String) request.getSession().getAttribute("userID");
	String writer = ESAPI.encoder().encodeForHTML((String)request.getSession().getAttribute("userID"));
	String title = ESAPI.encoder().encodeForHTML(request.getParameter("title"));
	String content = request.getParameter("contents");
	
	article.setTitle(title);
	article.setContent(content);
	
	boolean updated = false;
	if (userID.equals(writer) || request.getSession().getAttribute("userType").equals(User.TYPE_ADMIN)) {
		if(boardArticleDao.updateArticle(article) > 0){
			updated = true;
		} else{
			updated = false;
		}
	}
%>
<c:set var="updated" value="<%= updated %>"/>
<c:set var="article_id" value="<%= article_id %>"/>

<c:if test="${updated}}">
	<script>alert("글 수정 성공!");<script>
</c:if>
<c:if test="${!updated}">
	<script>alert("글 수정 실패...");</script>
</c:if>

<script>location.href="./articleDetail.jsp?article_id="+"${article_id}";</script>