<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.owasp.esapi.ESAPI" %>
<%@ page import="dao.BoardArticleDao" %>
<%@ page import="dao.BoardCommentDao" %>
<%@ page import="bean.BoardArticle" %>
<%@ page import="bean.BoardComment" %>
<%
	BoardArticleDao boardArticleDao = new BoardArticleDao();
	BoardCommentDao commentDao = new BoardCommentDao();

	util.PageNumber pageNumber = new util.PageNumber();

	String keyword = request.getParameter("keyword");
	
	if(keyword != null){
		keyword = new String(request.getParameter("keyword").getBytes(
			"8859_1"), "UTF-8");
	}
	int search_type = BoardArticleDao.SEARCH_TYPE_DEFAULT;
	
	if(request.getParameter("search_type") != null){
		search_type = Integer.parseInt(request.getParameter("search_type"));
	}
	

	int showRecordCnt = 20;
	int pageNum = 1;
	if (request.getParameter("pageNum") != null) {
		pageNum = Integer.parseInt(request.getParameter("pageNum"));
	}

	String pages[] = pageNumber.createPageNumber(10, pageNum, boardArticleDao.getArticleCount(1, search_type, keyword), showRecordCnt,	"articleList.jsp");

	List<BoardArticle> articles = boardArticleDao.getArticleList(1, search_type, keyword, pageNum, 	showRecordCnt);
	ArrayList<Integer> replyCount = new ArrayList<Integer>();
	
	for(BoardArticle article : articles){
	replyCount.add(commentDao.getreplyCount(article.getId()));
	if(keyword != null && (search_type == BoardArticleDao.SEARCH_TYPE_TITLE || search_type == BoardArticleDao.SEARCH_TYPE_TITLE_AND_CONTENT)){
		String keywordForReg = ESAPI.encoder().encodeForHTML(keyword);
		article.setTitle(article.getTitle().replaceAll(keywordForReg, "<span style='background:yellow;margin:0;padding:0'>"+keyword+"</span>"));
	}
	}
%>

<c:set var="articleList" value="<%= articles %>"/>
<c:set var="replyCount" value="<%= replyCount %>"/>
<c:set var="pages" value="<%= pages %>"/>
<c:set var="keyword" value="<%= keyword %>"/>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/button.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mainMenu.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/listTable.css">

<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sideMenu.css">
<title>목록</title>

<style type="text/css">
.rainbow {
/*
  background-image: -webkit-gradient( linear, left top, right top, color-stop(0, #f22), color-stop(0.15, #f2f), color-stop(0.3, #22f), color-stop(0.45, #2ff), color-stop(0.6, #2f2),color-stop(0.75, #2f2), color-stop(0.9, #ff2), color-stop(1, #f22) );
  background-image: gradient( linear, left top, right top, color-stop(0, #f22), color-stop(0.15, #f2f), color-stop(0.3, #22f), color-stop(0.45, #2ff), color-stop(0.6, #2f2),color-stop(0.75, #2f2), color-stop(0.9, #ff2), color-stop(1, #f22) );
  color:transparent;
  -webkit-background-clip: text;
  background-clip: text;
*/
}
</style>
</head>
<body>
  <div id="layout">
    <%@include file="../header.jsp"%>
    <article id="mainArticle">
      <nav class="sideMenu" style="">
	<div class="div_title">Menu</div>
	<ul>
	  <li><a href="./articleList.jsp">Community</a></li>
	</ul>
	</nav>
	<div style="width:800px;float:right;">
	  <h3>Community</h3>
	  <table border="1" class='list_table' padding='0' border='0'align="center">
	    <thead>
	      <tr>
				<th width="5%">No.</th>
				<th width="60%">Title</th>
				<th width="10%">writer</th>
				<th width="20%">Date</th>
				<th width="5%">Hit</th>
			</tr>
		</thead>
		<tbody>
		  <c:forEach var="article" items="${articleList}" varStatus="status">
		  	<c:if test="${status.index % 2 == 1 }"><tr class='evenRow'></c:if>
		  	<c:if test="${status.index % 2 == 0 }"><tr class='addRow'></c:if>
			      <td><a href="./articleView.jsp?article_id= ${article.id} %>">${article.id }</a></td>
			      <td style="text-align:left">
			      	<c:if test="${article.isNotice }">
						<b style="margin:0;padding:0;"><a href="./articleDetail.jsp?article_id=${article.id }" class="rainbow">${article.title}
					  	[${replyCount[status.count-1]}]</a></b>
			      	</c:if>
			      	<c:if test="${!article.isNotice }">
						<a href="./articleDetail.jsp?article_id=${article.id }">${article.title}
					  	<b>[${replyCount[status.count-1]}]</b></a>
			      	</c:if>		      	
				  </td>
				  <td><a href="./articleDetail.jsp?article_id=${article.id}">${article.writer }</a></td>
				  <td><a href="./articleDetail.jsp?article_id=${article.id}"><fmt:formatDate pattern="yyyy-MM-dd" value="${article.regdate}" /></a></td>
				  <td><a href="./articleDetail.jsp?article_id=${article.id}">${article.hit}</a></td>
			  </tr>
			</c:forEach>
		</tbody>
			  </table>
			  <div style="text-align:right;">
			    <a href="./insertArticleForm.jsp">글쓰기</a>
			  </div>
			  <div> <!-- pages -->
			  	<c:forEach var="page" items="${pages }">
			  		${page}
			  	</c:forEach>
			    </div>
			    <div>
			      <form name="frm" method="get" action="./articleList.jsp">
				<SELECT name="search_type">
				  <option VALUE="1">-</option>
				  <option VALUE="2">글 제목</option>
				  <option VALUE="3">글 내용</option>
				  <option VALUE="4">글쓴이</option>
				  <option VALUE="5">제목 + 내용</option>
				  </SELECT>
				  <input type="text" name="keyword" value="${keyword}"/>
				  <button class="button white small">검색</button>
				  </form>
				  </div>
				  </div>
				  </article>
				  <%@ include file="../footer.html"%>
				  </div>
</body>
</html>