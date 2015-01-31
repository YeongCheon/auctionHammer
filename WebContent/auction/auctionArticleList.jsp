<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="bean.AuctionArticle" %>
<%@ page import="bean.AuctionAttachFile" %>
<%@ page import="dao.AuctionBidDao" %>
<%@ page import="dao.AuctionArticleDao" %>
<%@ page import="dao.AuctionAttachFileDao" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
AuctionBidDao AuctionBidDao = new AuctionBidDao();
AuctionArticleDao auctionArticleDao = new AuctionArticleDao();
AuctionAttachFileDao auctionAttachFileDao = new AuctionAttachFileDao();

int article_type = AuctionArticleDao.ARTICLE_TYPE_UP;
if(request.getParameter("article_type") != null){
	article_type = Integer.parseInt(request.getParameter("article_type"));
}

List<AuctionArticle> articles = null;
List<AuctionAttachFile> images = new ArrayList<AuctionAttachFile>();
String search_type = request.getParameter("search_type");
String keyword = request.getParameter("searchBox");

if(search_type != null && search_type.equals("keyword")){
	try {
		keyword = new String(request.getParameter("searchBox").getBytes(
				"8859_1"), "UTF-8");
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	articles = auctionArticleDao.getAuctionArticleListToKeyword(keyword);
	System.out.println("toKeyword");
} else if(search_type != null && search_type.equals("category")){
	int category = Integer.parseInt(request.getParameter("category"));
	articles = auctionArticleDao.getAuctionArticleListToCategory(category);
	System.out.println("toCategory");
} else{
	articles =auctionArticleDao.getAuctionArticleList(article_type);
	System.out.println("default");
}

for(AuctionArticle article : articles){
	if(AuctionBidDao.getMaximumBid(article.getArticle_id()) != null){
		article.setArticle_startprice(AuctionBidDao.getMaximumBid(article.getArticle_id()).getBid_price());
	}
}




for(AuctionArticle article: articles){
	images.add(auctionAttachFileDao.getAttachFile(article.getArticle_id()));
}
%>
<c:set var="keyword" value="<%= keyword %>"/>
<c:set var="articleList" value="<%= articles %>"/>
<c:set var="imageList" value="<%= images %>"/>
<c:set var="article_type" value="<%= article_type %>"/>
<c:set var="totalCount" value="<%= auctionArticleDao.getAuctionArticleTotalCount() %>"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/button.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mainMenu.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sideMenu.css">

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/countdown/jquery.plugin.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/countdown/jquery.countdown.js"></script>
<title>경매목록</title>

<style type="text/css">
  	.timer{
		background: #4c4c4c; /* Old browsers */
		background: -moz-linear-gradient(top,  #4c4c4c 0%, #595959 3%, #666666 8%, #474747 12%, #474747 12%, #474747 15%, #2c2c2c 22%, #000000 38%, #111111 60%, #2b2b2b 75%, #1c1c1c 91%, #131313 100%); /* FF3.6+ */
		background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#4c4c4c), color-stop(3%,#595959), color-stop(8%,#666666), color-stop(12%,#474747), color-stop(12%,#474747), color-stop(15%,#474747), color-stop(22%,#2c2c2c), color-stop(38%,#000000), color-stop(60%,#111111), color-stop(75%,#2b2b2b), color-stop(91%,#1c1c1c), color-stop(100%,#131313)); /* Chrome,Safari4+ */
		background: -webkit-linear-gradient(top,  #4c4c4c 0%,#595959 3%,#666666 8%,#474747 12%,#474747 12%,#474747 15%,#2c2c2c 22%,#000000 38%,#111111 60%,#2b2b2b 75%,#1c1c1c 91%,#131313 100%); /* Chrome10+,Safari5.1+ */
		background: -o-linear-gradient(top,  #4c4c4c 0%,#595959 3%,#666666 8%,#474747 12%,#474747 12%,#474747 15%,#2c2c2c 22%,#000000 38%,#111111 60%,#2b2b2b 75%,#1c1c1c 91%,#131313 100%); /* Opera 11.10+ */
		background: -ms-linear-gradient(top,  #4c4c4c 0%,#595959 3%,#666666 8%,#474747 12%,#474747 12%,#474747 15%,#2c2c2c 22%,#000000 38%,#111111 60%,#2b2b2b 75%,#1c1c1c 91%,#131313 100%); /* IE10+ */
		background: linear-gradient(to bottom,  #4c4c4c 0%,#595959 3%,#666666 8%,#474747 12%,#474747 12%,#474747 15%,#2c2c2c 22%,#000000 38%,#111111 60%,#2b2b2b 75%,#1c1c1c 91%,#131313 100%); /* W3C */
		filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#4c4c4c', endColorstr='#131313',GradientType=0 ); /* IE6-9 */;
		color:white;
		padding:10px;
		border-radius: 5px;
	}

	th{
		background-color:#EEE;
		padding:5px 0;
	}
	
	td{
		border-bottom:solid #DDD 1px;
	}
	
	.auctionList{
		height:130px;
		background-color:white;
	}
</style>
<script type="text/javascript">
	function loaded(){
		<c:forEach var="result" items="${articleList}" varStatus="status">
			startCountdown('${result.article_enddate}','leftTime${status.index}');
		</c:forEach>
	}
  
	function startCountdown(timestamp, layer_id){
		var year = timestamp.substr(0,4);
		var month = timestamp.substr(5,2);
		var day = timestamp.substr(8,2);
		var hour = timestamp.substr(11,2);
		var minute = timestamp.substr(14,2);
		var second = timestamp.substr(17,2);
		
		var enddate = new Date();
		enddate.setFullYear(year);
		enddate.setMonth(month-1);
		enddate.setDate(day);
		enddate.setHours(hour);
		enddate.setMinutes(minute);
		enddate.setSeconds(second);
		
		$("#"+layer_id).countdown({until:enddate, layout:'<b> {d<} <span class="timer">{d10}</span> : {d>} <span class="timer">{hn}</span> : <span class="timer">{mn}</span> : <span class="timer">{sn}<span></b>', 
		format: 'd : hh : mm : ss'}); 
	}
</script>
</head>
<body onLoad="loaded();">
	<div id="layout">
		<%@include file="../header.jsp"%>
		<article id="mainArticle">
			<div style="font-size:15pt;font-weight:bold;color:black;text-align:left;margin:10px 0;">
				진행중인 경매
			</div>		
			<table border="0" width="1024px" align="center" cellpadding="0"
				cellspacing="0">
				<tr>
					<th>No</th>
					<th>입찰상품</th>
					<th>상품설명</th>
					<th>가격</th>
					<th>남은시간</th>
					<th>등록일</th>
				</tr>
				<c:forEach var="result" items="${articleList}" varStatus="status">
				<tr class="auctionList">
					<td style="text-align:center;">${result.article_id}</td>
					<td style="text-align:center">
						<!-- <img src="${pageContext.request.contextPath}/uploads/image.jpg" style="width: 100px; height: 100px; margin: auto; border: 2px solid #cccccc" /> -->
						<div style="background:#F2FFF2;font-weight:bold;text-align:left;margin-left:5px">
							<c:if test="${result.article_type == 1 }">
								상향식
							</c:if>
							<c:if test="${result.article_type == 2 }">
								하향식
							</c:if>
							<c:if test="${result.article_type == 3 }">
								private
							</c:if>
						</div>
						<img src="${imageList[status.index].attachfile_src}" style="width: 100px; height: 100px; margin: auto; border: 2px solid #cccccc" />
					</td>
					<td style="text-align: left;">
						<div style="width:500px;"><b>${result.article_title}</b></div>
						<div style="width:500px;overflow:auto;">${result.article_description}</div>
					</td>
					<td style="text-align:center">
						<div>현재가</div>
						<div style="margin-bottom:20px;">
							<span class="priceNumber" style="font-weight:bold; color:red;">
								<fmt:formatNumber value="${result.article_startprice}" type="CURRENCY" groupingUsed="true" />
							</span>
							
						</div>
						<div>정상가격</div>
						<div>
							<span class="realpriceNumber" style="font-weight:bold;">
								<fmt:formatNumber value="${result.article_marketprice}" type="CURRENCY" groupingUsed="true" />
							</span>
						</div>
					</td>
					<td style="text-align:center">
						<div style="position:relative;padding-bottom:20px;">
							<span id="leftTime${status.index}"></span>
						</div>
				 		<button class="button gray big" onClick="location.href='./auctionArticleDetail.jsp?article_id=${result.article_id}'">입찰하기</button>
					</td>
					<td style="text-align:center;">
						<div style="margin-bottom:20px;"><fmt:formatDate pattern="yyyy-MM-dd" value="${result.article_regdate}" /></div>
						<div>판매자</div>
						<div><b>${result.article_seller}</b></div>
					</td>					
				</tr>
				</c:forEach>
			</table>
		</article>
		<%@ include file="../footer.html"%>
	</div>
</body>
</html>