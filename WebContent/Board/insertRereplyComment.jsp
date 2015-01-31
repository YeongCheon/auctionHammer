<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="org.owasp.esapi.ESAPI" %>
<%@ page import="bean.BoardComment" %>
<%@ page import="dao.BoardCommentDao" %>
<%
	BoardCommentDao commentDao = new BoardCommentDao();
	request.setCharacterEncoding("utf-8");
	
	String article_id = ESAPI.encoder().encodeForHTML(request.getParameter("article_id"));
	String comment_writer = ESAPI.encoder().encodeForHTML((String)request.getSession().getAttribute("userID"));
	String comment_memo = ESAPI.encoder().encodeForHTML(request.getParameter("comment_memo"));
	String comment_ip = ESAPI.encoder().encodeForHTML(request.getRemoteAddr());
	String comment_rereply = ESAPI.encoder().encodeForHTML(request.getParameter("comment_rereply"));
	
	BoardComment comment = new BoardComment();
	
	comment.setArticle_id(Integer.parseInt(article_id));
	comment.setComment_writer(comment_writer);
	comment.setComment_memo(comment_memo);
	comment.setComment_ip(comment_ip);
	comment.setComment_rereplay(Integer.parseInt(comment_rereply));
	
	boolean inserted = false;
	if(commentDao.insertRereplayComment(comment)> 1){
		inserted = true;
	}else{
		inserted = false;
	}
%>
<c:set var="article_id" value="<%= article_id  %>"/>
<c:set var="inserted" value="<%= inserted %>"/>

<c:if test="${!inserted}">
	<script>alert("댓글작성 성공!");</script>
</c:if>
<c:if test="${inserted}">
	<script>alert("댓글작성 실패...");</script>
</c:if>

<script>location.href="./articleDetail.jsp?article_id="+"${article_id}";</script>