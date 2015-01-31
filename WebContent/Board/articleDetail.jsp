<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.BoardArticleDao" %>
<%@ page import="dao.BoardCommentDao" %>
<%@ page import="bean.BoardArticle" %>
<%@ page import="bean.BoardComment" %>

<%
	BoardArticleDao boardArticleDao = new BoardArticleDao();
	BoardCommentDao commentDao = new BoardCommentDao();
	int articleId = Integer.parseInt(request.getParameter("article_id"));
	
	boardArticleDao.updateArticleHit(articleId);
	BoardArticle article = boardArticleDao.getArticle(articleId);
	List<BoardComment> comments = commentDao.getAllCommentList(articleId);
	
	boolean isWriter = false;
	if(article.getWriter().equals((String)request.getSession().getAttribute("userID"))){
		isWriter = true;
	} else{
		isWriter = false;
	}
%>
<c:set var="article" value="<%= article %>"/>
<c:set var="comments" value="<%= comments %>"/>
<c:set var="isWriter" value="<%= isWriter %>"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/button.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mainMenu.css">

<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sideMenu.css">

<title>제목 : ${article.title }</title>

<style type="text/css">
	.comment_table{
		width:100%;
		margin-top:30px;
	}
	.comment_table thead{
		text-align:center;
	}
	.comment_table tbody{
		text-align:left;
	}
	
	.reply_header{
		padding:5px 0;
		border-top:1px solid #ABAEAE;
		border-bottom:1px solid #ABAEAE;
		background:#EBEBEB;
		padding-left:10px;
	}
	
	.reply_content{
		padding:5px 0;
		margin-bottom:10px;
		padding-left:10px;
	}
	
	
</style>

<script type="text/javascript">
function viewRereplyForm(comment_id){
	document.getElementById("tr_reply"+comment_id).style.display = "table-row";
}
</script>
</head>
<body>
	<div id="layout">
		<%@include file="../header.jsp"%>
		<article id="mainArticle" style="">
			<nav class="sideMenu" style="">
				<div class="div_title">Menu</div>
				<ul>
					<li><a href="./articleList.jsp">Community</a></li>
				</ul>				
			</nav>
		<div class="content" style="width:800px;float:right;">
			<div style="border-bottom:1px dotted #000000;clear:both;padding-bottom:20px;">
				<div style="float:left;font-size:12pt;">${article.title }</div>
				<div style="text-align:right;">${article.regdate }</div>
			</div>
			<div style="text-align:left;clear:both;margin-top:15px">${article.content }</div>
				<c:if test="${isWriter || sessionScope.userType == 'ADMIN'}">
					<div style="text-align:right"><a href="./updateArticleForm.jsp?article_id=${article.id}">글 수정</a> | <a href="deleteArticle.jsp?article_id=${article.id}">글 삭제</a></div>
				</c:if>
			<div style="text-align:right;">
				<a href="./articleList.jsp">목룩</a>
			</div>
			<div>
				<table class="comment_table" cellpadding="0" cellspacing="0">
					<tbody>
						<c:forEach items="${comments}" var="comment">
							<tr>
								<td class="reply_header" style="<c:if test="${comment.comment_rereplay != ''}">padding-left:30px;</c:if>">
									${comment.comment_writer}&nbsp;&nbsp;${comment.comment_regdate}
								</td>
								<td class="reply_header" style="text-align:right;">
									<c:if test="${comment.comment_rereplay == ''}">
										<a onClick="viewRereplyForm(${comment.comment_id})">답글</a> 
									</c:if>
									<c:if test="${comment.comment_writer == sessionScope.userID || sessionScope.userType == 'ADMIN'}">
										| <!-- 수정 |  --><a href="./deleteComment.jsp?comment_id=${comment.comment_id}&article_id=${article.id}">삭제</a>
									</c:if>
																		
								</td>
							</tr>
							<tr>
								<td class="reply_content" colspan="2"  style="<c:if test="${comment.comment_rereplay != ''}">padding-left:30px;</c:if>">${comment.comment_memo}</td>
							</tr>
							<tr id="tr_reply${comment.comment_id}" style="display:none">
								<td style="padding-left:20px;">
									<form name="frm_reply${comment.comment_id}" action="./insertRereplyComment.jsp" method="post">
										<textarea cols="30" rows="3" name="comment_memo" placeholder="댓글을 입력해주세요"></textarea>
										<input type="hidden" name="article_id" value="${article.id}"/>
										<input type="hidden" name="comment_rereply" value="${comment.comment_id}"/>
										<button type="submit" class="button white small">확인</button>
									</form>								
								</td>
							</tr>
						</c:forEach>

					</tbody>
				</table>
			</div>
			<%
				if(session.getAttribute("userID") != null){
			%>
			<div>
				
				<form name="frm" action="./insertComment.jsp" method="post">
					<table align="center">
						<tr>
							<td>댓글 :</td>
							<td>
								<textarea cols="60" rows="3" name="memo" placeholder="댓글을 입력해주세요"></textarea>
								<input type="hidden" name="article_id" value="${article.id }"/>
							</td>
							<td><button type="submit" class="button white small">확인</button></td>
						</tr>
					</table>
				</form>
			</div>
			<%
				}
			%>
			</div>
		</article>
		<%@ include file="../footer.html"%>
	</div>
</body>
</html>