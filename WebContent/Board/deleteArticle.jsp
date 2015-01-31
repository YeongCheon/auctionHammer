<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="dao.BoardArticleDao" %>
<%@ page import="dao.BoardCommentDao" %>
<%@ page import="bean.User" %>

<%
	BoardArticleDao boardArticleDao = new BoardArticleDao();
	BoardCommentDao commentDao = new BoardCommentDao();

	String id = request.getParameter("article_id");
	String userID = (String) request.getSession().getAttribute("userID");
	
	String writer = boardArticleDao.getArticle(Integer.parseInt(id)).getWriter();
	
	boolean deleted = false;
	if (userID.equals(writer) || request.getSession().getAttribute("userType").equals(User.TYPE_ADMIN)) {
		if(boardArticleDao.deleteArticle(Integer.parseInt(id))>0){
			deleted  = true;
		}else{
			deleted  = false;
		}
	} else{
		deleted  = false;
	}
%>
<c:set var="deleted" value="<%= deleted %>"/>

<c:if test="${deleted}">
	<script>alert("삭제 성공!");</script>
</c:if>
<c:if test="${!deleted}">
	<script>alert("삭제 실패...");</script>
</c:if>

<script>location.href="./articleList.jsp";</script>