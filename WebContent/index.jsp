<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="bean.AuctionArticle" %>
<%@ page import="bean.AuctionAttachFile" %>
<%@ page import="dao.AuctionBidDao" %>
<%@ page import="dao.AuctionArticleDao" %>
<%@ page import="dao.AuctionAttachFileDao" %>
<%
AuctionBidDao AuctionBidDao = new AuctionBidDao();
AuctionArticleDao auctionArticleDao = new AuctionArticleDao();
AuctionAttachFileDao auctionAttachFileDao = new AuctionAttachFileDao();

List<AuctionArticle> articles_up =auctionArticleDao.getAuctionArticleListToUp();
List<AuctionAttachFile> images_up = new ArrayList<AuctionAttachFile>();

List<AuctionArticle> articles_down =auctionArticleDao.getAuctionArticleListToDown();
List<AuctionAttachFile> images_down = new ArrayList<AuctionAttachFile>();

List<AuctionArticle> articles_private =auctionArticleDao.getAuctionArticleListToPrivate();
List<AuctionAttachFile> images_private = new ArrayList<AuctionAttachFile>();

 for(AuctionArticle article : articles_up){
 	if(AuctionBidDao.getMaximumBid(article.getArticle_id()) != null){
 		article.setArticle_startprice(AuctionBidDao.getMaximumBid(article.getArticle_id()).getBid_price());
	}
}
for(AuctionArticle article: articles_up){
	images_up.add(auctionAttachFileDao.getAttachFile(article.getArticle_id()));
}



for(AuctionArticle article : articles_down){
	if(AuctionBidDao.getMaximumBid(article.getArticle_id()) != null){
		article.setArticle_startprice(AuctionBidDao.getMaximumBid(article.getArticle_id()).getBid_price());
	}
}
for(AuctionArticle article: articles_down){
	images_down.add(auctionAttachFileDao.getAttachFile(article.getArticle_id()));
}



for(AuctionArticle article : articles_private){
	if(AuctionBidDao.getMaximumBid(article.getArticle_id()) != null){
		article.setArticle_startprice(AuctionBidDao.getMaximumBid(article.getArticle_id()).getBid_price());
	}
}
for(AuctionArticle article: articles_private){
	images_private.add(auctionAttachFileDao.getAttachFile(article.getArticle_id()));
}				


int totalCount =  auctionArticleDao.getAuctionArticleTotalCount();



%>
<c:set var="articleList_up" value="<%= articles_up %>"/>
<c:set var="imageList_up" value="<%= images_up %>"/>

<c:set var="articleList_down" value="<%= articles_down %>"/>
<c:set var="imageList_down" value="<%= images_down %>"/>

<c:set var="articleList_private" value="<%= articles_private %>"/>
<c:set var="imageList_private" value="<%= images_private %>"/>

<c:set var="totalCount" value="<%= totalCount %>"/>

<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="Generator" content="emacs">	
	<meta name="Author" content="">	
	<meta name="Keywords" content="">
	<meta name="Description" content="">
	
	<title>Main</title>
	<link type="text/css" rel="stylesheet" href="./resources/css/common.css">
	<link type="text/css" rel="stylesheet" href="./resources/css/button.css">
	<link type="text/css" rel="stylesheet" href="./resources/css/mainMenu.css">
	
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/countdown/jquery.plugin.js"></script> 
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/countdown/jquery.countdown.js"></script>
	
	<script src="${pageContext.request.contextPath}/resources/js/jqFancyTransitions.1.8.min.js" type="text/javascript"></script>
		
	<style type="text/css">


		#mainImage{
			width:100%;
			padding:0px;
			margin:0px;
			margin-bottom:5px;
		}
		
		#sideMenu, #mainArticle{
			font-size:12pt;
		}

		#sideMenu{
			min-width:190px;
			margin-right:10px;
			border:2px solid #55473b;
			color:#ffffff;
			min-height:500px;
		}

		#sideMenu ul{
			list-style:none;
			text-align:left;
			margin:0;
			padding:0;
			color:#000000;
		}

		#sideMenu ul li{
			margin:0;
			padding-left:10px;
			position:relative;
		}
		#sideMenu a{
			display:block;
			color:#000000;
			width:100%;
			padding-top:15px;
			height:35px;
		}
		#sideMenu a:hover{
			background:#4b545f;
			color:#ffffff;
		}

		#sideMenu ul li:hover{
			background:#4b545f;
			color:#ffffff;
		}

		#sideMenu ul ul{
			display: none;
			position:absolute;
			left:100%;
			top:0;
			width:250px;
			background:#ffffff;
			z-index:100;
		}

		#sideMenu ul ul li{
			position:relative;
			padding-left:20px;
			background:#ffffff;
			border-bottom: 1px dotted #000000;
		}

		#sideMenu ul li:hover>ul {
			display: block;
		}
		#sideMenu ul li:hover> a {
			color:#ffffff;
		}

		#mainArticle section ul{
			list-style:none;
			text-align:left;
			margin:5px 0 0 5px;
			padding:0;
		}

		.mainSection{
			min-height:740px;
			float:left;
			margin:0px 2px 0px 2px;
			min-width:150px;
			width:265px;
		}

		#section_up{
			border:2px solid #65be9f;
			
		}

		#section_down{
			border:2px solid #f0c952;
		}

		#section_private{
			border:2px solid #e0335d;
			margin:0;
			float:right;
		}

		#section_private>div{
			display:block;
			background:#e0335d;
			height:30px;
			padding-top:10px
		}

		.mainSection_title{
			margin-bottom:2px;
			margin-left:6px;
		}
		.mainSection_title a{
			color:#ffffff;
		}

		.mainSection_more{
			margin-top:2px;
			margin-right:6px;
		}
		.mainSection_more a{
			color:#ffffff;
		}

		.leftTime{
			margin:5px 0;
			width:150px;
			text-align:center;
		}

		.bg_leftTime{
			display:inline;

			background: #41d1dc;
			background: linear-gradient(top, #505050 0%, #202020 100%);
			background: -moz-linear-gradient(top, #505050 0%, #202020 100%);
			background: -webkit-linear-gradient(top, #505050 0%, #202020 100%);
			box-shadow: 0px 0px 9px rgba(0, 0, 0, 0.15);
			margin:0;
			padding: 5px 5px;
			border-radius: 2px;
			list-style: none;
			position: relative;
			display: inline-table;
			line-height:20px;
			color:#ffffff;
		}

		.div_price{
			text-align:center;
			font-weight:bold;
			font-size:14pt;
			margin-bottom:5px;
		}

		.price{
			color:#e0335d;
		}
	</style>
	<script type="text/javascript">
		$(document).ready( function(){
		    $('#slideshowHolder').jqFancyTransitions({ width: 1024, height: 370, links:true });
		});
	
		function loaded(){
			<c:forEach var="result" items="${articleList_up}" varStatus="status">
				startCountdown('${result.article_enddate}','leftTime_up${status.index}');
			</c:forEach>
			<c:forEach var="result" items="${articleList_down}" varStatus="status">
				startCountdown('${result.article_enddate}','leftTime_down${status.index}');
			</c:forEach>
			<c:forEach var="result" items="${articleList_private}" varStatus="status">
				startCountdown('${result.article_enddate}','leftTime_private${status.index}');
			</c:forEach>		
		}
	  
		function startCountdown(timestamp, layer_id){
			var year = timestamp.substr(0,4);
			var month = timestamp.substr(5,2);
			var day = timestamp.substr(8,2);
			var hour = timestamp.substr(11,2);
			var minute = timestamp.substr(14,2);
			var second = timestamp.substr(17,2);
			
			//timestamp.substr(0, 19)
			var enddate = new Date();
			enddate.setFullYear(year);
			enddate.setMonth(month-1);
			enddate.setDate(day);
			enddate.setHours(hour);
			enddate.setMinutes(minute);
			enddate.setSeconds(second);
			
			//alert(enddate);
			$("#"+layer_id).countdown({until:enddate, layout:'<b> {d<} <span class="bg_leftTime">{dn}</span>:{d>} <span class="bg_leftTime">{hn}</span>:<span class="bg_leftTime">{mn}</span>:<span class="bg_leftTime">{sn}<span></b>'}); 
		}
	</script>	
</head>
<body onLoad="loaded();">
	<div id="layout">
		<%@ include file="./header.jsp" %>
		<section id="mainImage">
			<!--<img src="./resources/image/mainImage.jpg" style="width:100%">
			<img src="http://placehold.it/700x300" style="width:100%">-->
			<div id='slideshowHolder'>
			<img src="./resources/image/mainImage01.jpg" style="width:1024px;border-radius:30px;"><a href="#"></a>
			 <img src="./resources/image/mainImage.jpg" style="width:1024px;border-radius:30px;"><a href="#"></a>
			 <img src="./resources/image/mainImage02.jpg" style="width:1024px;border-radius:30px;"><a href="./guide.jsp"></a>
			</div>
		</section>
		<div>
			<aside id="sideMenu" style="float:left;">
			<div style="display:block;background:#55473b;height:30px;padding-top:10px">Category</div>
				<ul>
					<li>
						<a href="#">패션의류</a>
						<ul>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=1">여성의류</a></li>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=2">남성의류</a></li>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=3">스몰/빅사이즈</a></li>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=4">언더웨어/잠옷</a></li>
						</ul>
					</li>
						<li>
							<a href="#">패션잡화/명품</a>
								<ul>
									<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=5">신발</a></li>
									<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=6">가방/패션잡화</a></li>
									<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=7">쥬얼리/시계</a></li>
									<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=8">수입명품</a></li>
								</ul>
						</li>
					<li>
						<a href="#">뷰티/헤어</a>
							<ul>
									<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=9">화장품/향수</a></li>
									<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=10">바디/헤어</a></li>
							</ul>
					</li>
					<li><a href="#">유아동/출산</a>
							<ul>
									<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=11">기저귀/분유</a></li>
									<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=12">물티슈/생리대</a></li>
									<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=13">출산/유아용품</a></li>
									<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=14">장난감</a></li>
									<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=15">유아동의류</a></li>
									<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=16">유아동신발/잡화</a></li>
							</ul>
					</li>
					<li><a href="#">식품</a>
							<ul>
								<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=17">신선식품</a></li>
								<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=18">가공/즉석식품</a></li>
								<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=19">건강식품</a></li>
								<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=20">커피/음료</a></li>
							</ul>
						</li>
					<li><a href="#">가구/침구</a>
						<ul>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=21">가구/DIY</a></li>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=22">침구/커튼</a></li>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=23">조명/인테리어</a></li>
						</ul>
					</li>						
					<li><a href="#">생활/주방/문구</a>
						<ul>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=24">생활용품</a></li>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=25">주방용품</a></li>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=26">화장지/세제</a></li>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=27">건강/의료용품</a></li>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=28">문구/사무용품</a></li>
						</ul>
						</li>
					<li><a href="#">스포츠/레저</a>
						<ul>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=29">스포츠의류/운동화</a></li>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=30">휘트니스/수영</a></li>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=31">구기/라켓스포츠</a></li>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=32">골프</a></li>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=33">자전거/스키</a></li>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=34">캠핑/낚시</a></li>
						</ul>
					</li>
					<li><a href="#">자동차/공구</a>
						<ul>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=35">자동차/오토바이용품</a></li>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=36">블랙박스/네비게이션</a></li>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=37">공구/산업자재</a></li>
						</ul>	
						</li>
					<li><a href="#">취미</a>
						<ul>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=38">애완용품</a></li>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=39">꽃/이벤트용품</a></li>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=40">악기/보드게임</a></li>
						</ul>
					</li>
					<li><a href="#">컴퓨터</a>
						<ul>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=41">노트북/데스크탑</a></li>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=42">모니터/프린터</a></li>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=43">컴퓨터부품/액세사리</a></li>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=44">저장장치</a></li>
						</ul>	
					</li>
					<li><a href="#">디지털</a>
						<ul>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=45">휴대폰/액세사리</a></li>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=46">카메라/액세사리</a></li>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=47">태블릿/음향기기</a></li>
						</ul>
					</li>
					<li><a href="#">가전</a>
						<ul>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=48">대형가전</a></li>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=49">주방가전</a></li>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=50">계절가전</a></li>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=51">생활/이미용가전</a></li>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=52">건강가전</a></li>
						</ul>
						</li>
					<li><a href="#">도서</a>
						<ul>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=53">학습/사전/참고서</a></li>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=54">문학/과학/경영</a></li>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=55">월간/게간/잡지</a></li>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=56">여행/취미/요리</a></li>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=57">예술/디자인도서</a></li>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=58">컴퓨터/인터넷도서</a></li>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=59">아동/어린이도서</a></li>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=60">소설/만화책</a></li>
							<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?search_type=category&category=61">전집</a></li>
						</ul>
						</li>
				</ul>
			</aside>
			<article id="mainArticle">
				<section id="section_up" class="mainSection">
					<div style="display:block;background:#65be9f;height:30px;padding-top:10px">
						<div style="float:left;" class="mainSection_title"><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?article_type=1">상향식 경매</a></div>
						<div style="float:right;" class="mainSection_more"><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?article_type=1"><small>더 보기+</small></a></div>
					</div>
					<ul>
						<c:forEach var="result" items="${articleList_up}" varStatus="status">
							<c:if test="${status.index <= 5 }">
								<li>
									<div style="clear:both">
										<div style="float:left"><img src="${imageList_up[status.index].attachfile_src}" style="width:110px; height:110px;"/></div>
										<div style="float:right">
											<div class="leftTime" id="leftTime_up${status.index}">
												<span class="bg_leftTime">99</span>
												<img src="./resources/image/doubleDot.png"/><span class="bg_leftTime">99</span>
												<img src="./resources/image/doubleDot.png"/><span class="bg_leftTime">99</span>
											</div>
											<div class="div_price"><span class="price"><fmt:formatNumber value="${result.article_startprice}" type="CURRENCY" groupingUsed="true" /></span></div>
											<div style="text-align:center;"><button class="button orange" style="width:95%" onClick="location.href='./auction/auctionArticleDetail.jsp?article_id=${result.article_id}'"><b>입찰하기</b></button></div>
										</div>
									</div>
								</li>
							</c:if>
						</c:forEach>
					</ul>
				</section>
				<section id="section_down" class="mainSection">
					<div style="display:block;background:#f0c952;height:30px;padding-top:10px">
						<div style="float:left;" class="mainSection_title"><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?article_type=2">하향식 경매</a></div>
						<div style="float:right;" class="mainSection_more"><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?article_type=2"><small>더 보기+</small></a></div>
					</div>
					<ul>
						<c:forEach var="result" items="${articleList_down}" varStatus="status">
							<c:if test="${status.index <= 5 }">
								<li>
									<div style="clear:both">
										<div style="float:left"><img src="${imageList_down[status.index].attachfile_src}" style="width:110px; height:110px;"/></div>
										<div style="float:right">
											<div class="leftTime" id="leftTime_down${status.index}">
												<span class="bg_leftTime">99</span>
												<img src="./resources/image/doubleDot.png"/><span class="bg_leftTime">99</span>
												<img src="./resources/image/doubleDot.png"/><span class="bg_leftTime">99</span>
											</div>
											<div class="div_price"><span class="price"><fmt:formatNumber value="${result.article_startprice}" type="CURRENCY" groupingUsed="true" /></span></div>
											<div style="text-align:center;"><button class="button orange" style="width:95%" onClick="location.href='./auction/auctionArticleDetail.jsp?article_id=${result.article_id}'"><b>입찰하기</b></button></div>
										</div>
									</div>
								</li>
							</c:if>
						</c:forEach>
					</ul>
				</section>
				<section id="section_private" class="mainSection">
					<div>
						<div style="float:left;" class="mainSection_title"><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?article_type=3">Private 경매</a></div>
						<div style="float:right;" class="mainSection_more"><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?article_type=3"><small>더 보기+</small></a></div>
					</div>
					<ul>
						<c:forEach var="result" items="${articleList_private}" varStatus="status">
							<c:if test="${status.index <= 5 }">
								<li>
									<div style="clear:both">
										<div style="float:left"><img src="${imageList_private[status.index].attachfile_src}" style="width:110px; height:110px;"/></div>
										<div style="float:right">
											<div class="leftTime" id="leftTime_private${status.index}">
												<span class="bg_leftTime">99</span>
												<img src="./resources/image/doubleDot.png"/><span class="bg_leftTime">99</span>
												<img src="./resources/image/doubleDot.png"/><span class="bg_leftTime">99</span>
											</div>
											<div class="div_price"><span class="price"><fmt:formatNumber value="${result.article_startprice}" type="CURRENCY" groupingUsed="true" /></span></div>
											<div style="text-align:center;"><button class="button orange" style="width:95%" onClick="location.href='./auction/auctionArticleDetail.jsp?article_id=${result.article_id}'"><b>입찰하기</b></button></div>
										</div>
									</div>
								</li>
							</c:if>
						</c:forEach>
					</ul>
				</section>
			</article>
		</div>
		<%@ include file="./footer.html" %>
	</div>
</body>
</html>