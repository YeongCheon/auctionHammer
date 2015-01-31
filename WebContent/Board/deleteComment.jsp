<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="dao.BoardCommentDao" %>
<%@ page import="bean.User" %>
<%
	BoardCommentDao commentDao = new BoardCommentDao();
	String id = request.getParameter("comment_id");
	String articldId = request.getParameter("article_id");
	String userID = (String) request.getSession().getAttribute("userID");
	
	String writer = commentDao.getComment(Integer.parseInt(id)).getComment_writer();
	
	boolean deleted = false;
	if (userID.equals(writer) || request.getSession().getAttribute("userType").equals(User.TYPE_ADMIN)) {
		if(commentDao.deleteComment(Integer.parseInt(id))>0){
			deleted = true;
		} else{
			deleted = false;
		}
	} else{
		deleted = false;
	}
%>

<c:set var="article_id" value="<%= articldId %>"/>
<c:set var="deleted" value="<%= deleted %>"/>

<c:if test="${deleted}">
	<script>alert("삭제 성공!");</script>
</c:if>
<c:if test="${!deleted}">
	<script>alert("삭제 실패...");</script>
</c:if>

<script>location.href="./articleDetail.jsp?article_id=${article_id}";</script>