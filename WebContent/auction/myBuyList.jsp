<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="dao.AuctionArticleDao" %>
<%
	String user_id = (String)request.getSession().getAttribute("userID");
	AuctionArticleDao auctionArticleDao = new AuctionArticleDao();
%>
<c:set var="myBuyList" value="<%= auctionArticleDao.getMyBuyList(user_id) %>"/>
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
<title>내 구매내역</title>

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
		var enddate = new Date(timestamp);
		$("#"+layer_id).countdown({until:enddate, layout:'<b> {d<} <span class="timer">{dn}</span> : {d>} <span class="timer">{hn}</span> : <span class="timer">{mn}</span> : <span class="timer">{sn}<span></b>', 
		format: 'd : hh : mm : ss'}); 
	}
</script>
</head>
<body onLoad="loaded();">
	<div id="layout">
		<%@include file="../header.jsp"%>
		<article id="mainArticle">
			<div style="font-size:15pt;font-weight:bold;color:black;text-align:left;margin:10px 0;">
				내 구매내역
			</div>
			<table border="0" width="1024px" align="center" cellpadding="0"
				cellspacing="0">
				<tr>
					<th>No</th>
					<th>입찰상품</th>
					<th>배송지</th>
					<th>가격</th>
					<th>입찰시간</th>
				</tr>
				<c:forEach var="result" items="${myBuyList}" varStatus="status">
				<tr class="auctionList">
					<td style="text-align:center;">${result.article_id}</td>
					<td style="text-align:center">
						<!-- <img src="${pageContext.request.contextPath}/uploads/image.jpg" style="width: 100px; height: 100px; margin: auto; border: 2px solid #cccccc" /> -->
						<img src="${result.attachfile_src}" style="width: 100px; height: 100px; margin: auto; border: 2px solid #cccccc" />
					</td>
					<td style="text-align: left;">
						<div style="width:500px;"><b>${result.article_title}</b></div>
						<div style="width:500px;overflow:auto;">${result.article_description}</div>
					</td>
					<td style="text-align:center">
						<div>구매가</div>
						<div style="margin-bottom:20px;">
							<span class="priceNumber" style="font-weight:bold; color:red;">
								<fmt:formatNumber value="${result.bid_price}" type="CURRENCY" groupingUsed="true" />
							</span>
							
						</div>
						<div>정상가격</div>
						<div>
							<span class="realpriceNumber" style="font-weight:bold;">
								<fmt:formatNumber value="${result.article_marketprice}" type="CURRENCY" groupingUsed="true" />
							</span>
						</div>
					</td>
					<td style="text-align:center;">
						<div style="margin-bottom:20px;"><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" value="${result.article_regdate}" /></div>
						<div>판매자</div>
						<div>
							<b>${result.article_seller}</b>
						</div>
					</td>					
				</tr>
				</c:forEach>
			</table>
		</article>
		<%@ include file="../footer.html"%>
	</div>
</body>
</html>