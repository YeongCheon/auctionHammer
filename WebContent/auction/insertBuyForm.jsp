<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="bean.AuctionArticle" %>
<%@ page import="bean.AuctionAttachFile" %>
<%@ page import="bean.AuctionBid" %>
<%@ page import="bean.User" %>
<%@ page import="dao.AuctionBidDao" %>
<%@ page import="dao.AuctionArticleDao" %>
<%@ page import="dao.AuctionAttachFileDao" %>
<%@ page import="dao.UserDao" %>
<%
	AuctionBidDao AuctionBidDao = new AuctionBidDao();
	AuctionArticleDao auctionArticleDao = new AuctionArticleDao();
	AuctionAttachFileDao auctionAttachFileDao = new AuctionAttachFileDao();
	UserDao userDao = new UserDao();

	int article_id = Integer.parseInt(request.getParameter("article_id"));
	AuctionArticle article = auctionArticleDao.getAuctionArticle(article_id);
	AuctionAttachFile thumnail = auctionAttachFileDao.getAttachFile(article_id);
	
	AuctionBid bid_maximum = AuctionBidDao.getMaximumBid(article_id);
	if(bid_maximum != null){
		article.setArticle_startprice(bid_maximum.getBid_price());
	}
	User user = userDao.userGet(AuctionBidDao.getMaximumBid(article_id).getBid_user());
	
%>
<c:set var="thumnail" value="<%= thumnail %>"/>
<c:set var="article" value="<%= article %>"/>
<c:set var="user" value="<%= user %>"/>
<c:set var="zipcode" value="${user.user_zipcode}" />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/button.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mainMenu.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sideMenu.css">
<title>낙찰상품 구매</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/js/datetimepicker/jquery.datetimepicker.css"/>
<script src="${pageContext.request.contextPath}/resources/js/datetimepicker/jquery.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/datetimepicker/jquery.datetimepicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/ckeditor/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.form.min.js"></script>

<script type="text/javascript">
	function isNumberKey(evt){
	    var charCode = (evt.which) ? evt.which : evt.keyCode;
	    if (charCode > 31 && (charCode < 48 || charCode > 57))
	        return false;
	    return true;
	}

	function zipcode_fadeIn() {
		document.getElementById("popup_zipcode").style.display = 'block';
		document.getElementById("div_fade").style.display = 'block';
	
		$("#popup_zipcode").fadeOut(0);
		$("#popup_zipcode").fadeIn(300);
	
		$("#div_fade").fadeOut(0);
		$("#div_fade").fadeIn(300);
	}
	
	function zipcode_fadeOut() {
		document.getElementById("popup_zipcode").style.display = 'block';
		document.getElementById("div_fade").style.display = 'block';
	
		$("#popup_zipcode").fadeOut(0);
		$("#div_fade").fadeOut(0);
	}
	
	
	function ajax_getZipcodeList() {
		var keyword = document.getElementById("zipcode_keyword").value;

		if (keyword.length <= 0) {
			alert("검색어를 입력해주세요");
			return;
		}

		$.ajax({ //for landNum
			url : '${pageContext.request.contextPath}/user/ajax/ajax_getLandnumZipcodeList.jsp?keyword=' + encodeURI(keyword),
			dataType : 'json',
			type : 'get',
			data : {},
			success : function(result) {
				ajax_deleteLandnumItems();
				ajax_showLandnumItems(result);
			},
			error : function(e) {
				alert("ajax Error!!");
			}
		});

		$.ajax({ //for roadName
			url : '${pageContext.request.contextPath}/user/ajax/ajax_getRoadnameZipcodeList.jsp?keyword=' + encodeURI(keyword),
			dataType : 'json',
			type : 'get',
			data : {},
			success : function(result) {
				ajax_deleteRoadnameItems();
				ajax_showRoadnameItems(result);
			},
			error : function(e) {
				alert("ajax Error!!");
			}
		});
	}

	function ajax_deleteRoadnameItems() {
		var table = document.getElementById("zipcode_searchResult_roadName");

		while (table.rows.length > 1) {
			table.deleteRow(1);
		}
	}

	function ajax_showRoadnameItems(jsonObj) {
		var list = jsonObj.list;

		var table = document.getElementById("zipcode_searchResult_roadName");

		if (list.length <= 0) {
			var row = table.insertRow(1);
			var cell01 = row.insertCell();

			cell01.colSpan = 2;
			cell01.innerHTML = "검색결과가 없습니다.";
			cell01.style.textAlign = "center";
		}

		for (var i = 0; i < list.length; i++) {

			var row = table.insertRow(1);
			row.className = "tr_zipcode";

			var zipcode = row.insertCell();
			var addr = row.insertCell();
			zipcode.className = "zipcodeNum";
			addr.className = "addr_detail";

			var data_zipcode1 = list[i].zipcode.substr(0, 3);
			var data_zipcode2 = list[i].zipcode.substr(3, 6);

			var data_addr = list[i].gugun + " " + list[i].road_nm + " "
					+ list[i].building_no + " " + list[i].building_nm;

			var onClickEvent = 'select_zipcode("' + data_zipcode1 + '","'
					+ data_zipcode2 + '","' + data_addr + '");';

			var tag_a = "<a href='javascript:void(0)' onClick='" + onClickEvent
					+ "'>";

			zipcode.innerHTML = tag_a + data_zipcode1 + "-" + data_zipcode2
					+ "</a>";
			addr.innerHTML = tag_a + data_addr + "</a>";

		}
	}

	function ajax_deleteLandnumItems() {
		var table = document.getElementById("zipcode_searchResult_landNum");

		while (table.rows.length > 1) {
			table.deleteRow(1);
		}
	}

	function ajax_showLandnumItems(jsonObj) {
		var list = jsonObj.list;

		var table = document.getElementById("zipcode_searchResult_landNum");

		if (list.length <= 0) {
			var row = table.insertRow(1);
			var cell01 = row.insertCell();

			cell01.colSpan = 2;
			cell01.innerHTML = "검색결과가 없습니다.";
			cell01.style.textAlign = "center";
		}

		for (var i = 0; i < list.length; i++) {

			var row = table.insertRow(1);
			row.className = "tr_zipcode";

			var zipcode = row.insertCell();
			var addr = row.insertCell();
			zipcode.className = "zipcodeNum";
			addr.className = "addr_detail";

			var data_zipcode1 = list[i].zipcode.substr(0, 3);
			var data_zipcode2 = list[i].zipcode.substr(3, 6);
			var data_addr = list[i].gugun + " " + list[i].dong + " "
					+ list[i].bunji;

			var onClickEvent = 'select_zipcode("' + data_zipcode1 + '","'
					+ data_zipcode2 + '","' + data_addr + '");';

			var tag_a = "<a href='javascript:void(0)' onClick='" + onClickEvent
					+ "'>";

			zipcode.innerHTML = tag_a + data_zipcode1 + "-" + data_zipcode2
					+ "</a>";
			addr.innerHTML = tag_a + data_addr + "</a>";

		}
	}

	function select_zipcode(data_zipcode1, data_zipcode2, data_addr) {
		var user_zipcode1 = document.getElementById("user_zipcode01");
		var user_zipcode2 = document.getElementById("user_zipcode02");
		var user_addr01 = document.getElementById("user_addr01");

		user_zipcode1.value = data_zipcode1;
		user_zipcode2.value = data_zipcode2;
		user_addr01.value = data_addr;

		zipcode_fadeOut();
	}

	function switchZipcode(num) {
		var div_landNum = document.getElementById("zipcode_landnum");
		var div_roadName = document.getElementById("zipcode_roadName");

		var btn_landNum = document.getElementById("btn_landNum");
		var btn_roadName = document.getElementById("btn_roadName");

		if (num == 1) {
			div_landNum.style.display = "none";
			div_roadName.style.display = "block";

			btn_roadName.className = "btn_active";
			btn_landNum.className = "btn_nonactive";
		} else {
			div_landNum.style.display = "block";
			div_roadName.style.display = "none";

			btn_roadName.className = "btn_nonactive";
			btn_landNum.className = "btn_active";
		}
	}	
</script>

<style type="text/css">
th{
	text-align:right;
	vertical-align:top;
}
td{
	vertical-align:top;
	text-align:left
}
ul{
	margin:0;
	padding:0;
}
li{
	list-style-type: none;
}





#popup_zipcode {
	display: none; /* ensures it’s invisible until it’s called */
	position: absolute;
	/* makes the div go into a position that’s absolute to the browser viewing area */
	left: 35%; /* positions the div half way horizontally */
	top: 25%; /* positions the div half way vertically */
	padding: 25px;
	border: 2px solid black;
	background-color: #ffffff;
	width: 400px;
	height: 500px;
	z-index: 100;
	/* makes the div the top layer, so it’ll lay on top of the other content */
}

#div_fade {
	display: none; /* ensures it’s invisible until it’s called */
	position: absolute;
	/* makes the div go into a position that’s absolute to the browser viewing area */
	left: 0%; /* makes the div span all the way across the viewing area */
	top: 0%; /* makes the div span all the way across the viewing area */
	background-color: black;
	-moz-opacity: 0.7;
	/* makes the div transparent, so you have a cool overlay effect */
	opacity: .70;
	filter: alpha(opacity = 70);
	width: 100%;
	height: 100%;
	z-index: 90;
	/* makes the div the second most top layer, so it’ll lay on top of everything else EXCEPT for divs with a higher z-index (meaning the #overlay ruleset) */
}

.popup_zipcodeResult {
	width: 100%;
	overflow: scroll;
	height: 350px;
	border: 1px solid #000000;
	border-top: 0;
}

.zipcode_searchResult th {
	text-align: center;
}

.zipcode_searchResult td {
	margin: 0;
	padding: 0;
}

.zipcodeNum {
	
}

.addr_detail {
	width: 300px;
}

.zipcode_searchResult a {
	display: block;
	width: 100%;
	margin: 0;
	padding: 5px;
}

.zipcode_searchResult tr {
	display: block;
	width: 100%;
	height: 30px;
	float: left;
}

#btn_landNum {
	width: 50%;
	height: 30px;
	padding-top: 20px;
	float: right;
	cursor: pointer;
}

#btn_roadName {
	width: 50%;
	height: 30px;
	padding-top: 20px;
	cursor: pointer;
}

.btn_active {
	background: white;
	border-bottom: 1px solid white;
	border: 1px solid #000000;
	border-bottom: 1px solid white;
}
</style>
</head>
<body>
	<div id="layout">
		<%@include file="../header.jsp"%>
		<article id="mainArticle">
				<div style="float:left">
					<div>
						<img src="${thumnail.attachfile_src}" style="width:250px; height:250px;"/>
						<!-- <img src="http://placehold.it/250x250"> -->
					</div>
				</div>
				<div style="float: left">
					<table style="width:300px; height:250px;margin-left:20px;">
						<tr>
							<th>상품명</th>
							<td style="text-align:right;font-size:10pt;"><b>${article.article_title }</b></td>
						</tr>
						<tr>
							<th>낙찰가</th>
							<td style="text-align:right">
								<span id="startprice" style="color:red;font-weight:bold;font-size:15pt;"><fmt:formatNumber value="${article.article_startprice}" type="CURRENCY" groupingUsed="true" /></span>
								<input type="hidden" id="hidden_startprice" value="${article.article_startprice}"/>
							</td>
						</tr>
						<tr>
							<th>마감일</th>
							<td style="text-align:right"><span style="font-weight:bold;"><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" value="${article.article_enddate}" /></span></td>
						</tr> 
						<tr>
							<th>소비자 가격</th>
							<td style="text-align:right;tex"><span id="marketprice" style="font-weight:bold"><fmt:formatNumber value="${article.article_marketprice}" type="CURRENCY" groupingUsed="true" /></span></td>
							<input type="hidden" id="hidden_marketprice" value="${article.article_marketprice}"/>
						</tr>
						<tr>
							<th>이익</th>
							<td style="text-align:right"><span id="profit" style="font-weight:bold;">000000</span>원</td>
						</tr>
					</table>
				</div>
				<div>
					<h3>배송지</h3>
					<form name="frm_buy" action="./insertBuy.jsp" method="post">
						<table align="center">
							<tr>
								<th>* 주소</th>
								<td>
									<input type="text" name="user_zipcode01"id="user_zipcode01" value="${fn:substring(zipcode, 0, 3)}" size="3" readonly /> - <input type="text" name="user_zipcode02" id="user_zipcode02" size="3" value="${fn:substring(zipcode, 3, 6)}" readonly />
									<button type="button" class="button white small"	onclick="zipcode_fadeIn();">우편번호 찾기</button> <br /> <input type="text" name="user_addr01" id="user_addr01" value="${user.user_addr1 }" size="30"
									readonly /> <br /> <input type="text" name="user_addr02" id="user_addr02" value="${user.user_addr2 }" size="30" />
									<div id="error_user_addr" class="div_error"></div></td>
							</tr>
							<tr>
								<th>결제수단</th>
								<td>
									<input type="radio" name="payment_method" value="bank" checked>실시간 계좌이체
									<input type="radio" name="payment_method" value="creditcard" disabled="disabled">신용카드
									<input type="radio" name="payment_method" value="easypay" disabled="disabled">간편결제
								</td>
							</tr>
							<tr>
								<th>은행명</th>
								<td>
									<select>
										<option value="1">우리은행</option>
										<option value="2">신한은행</option>
										<option value="3">국민은행</option>
										<option value="4">기업은행</option>
										<option value="5">씨티은행</option>
									</select>
								</td>
							<tr>
							<tr>
								<th>계좌번호</th>
								<td>
									<input type=text name=form_number size=20 maxlength=12 onkeypress='return isNumberKey(event)'>'-'없이 입력해주세요.
								</td>
							</tr>
							<tr>
								<td colspan="2" align="center" style="text-align:center;margin:20px 0; padding:20px 0;">
									<button class="button red big">구매하기</button>
								</td>
							</tr>
						</table>
						<input type="hidden" name="article_id" value="${article.article_id}"/>
					</form>
				</div>
		</article>
		<%@ include file="../footer.html"%>
	</div>
	
	
	
	
	
	
	
	
	
	<div id="popup_zipcode">
		<div style="clear: both; margin-top: 10px;">
			<b>우편번호 검색</b>
		</div>

		<div style="text-align: center;"">
			<input type="text" name="keyword" size="10" id="zipcode_keyword"
				onkeypress="{if (window.event.keyCode==13)ajax_getZipcodeList();}" />
			<input type="button" class="button white medium" value="검색"
				onClick="ajax_getZipcodeList();" />
		</div>
		<div style="clear: both; margin-top: 25px; width: 402px;">
			<div id="btn_landNum" class="btn_nonactive"
				onClick="switchZipcode(2);">지번검색</div>
			<div id="btn_roadName" class="btn_active" onClick="switchZipcode(1);">도로명
				검색</div>
		</div>

		<div style="position: relative;">
			<div id="zipcode_landnum" style="clear: both; display: none;">
				<div class="popup_zipcodeResult">
					<table id="zipcode_searchResult_landNum"
						class="zipcode_searchResult" align="center">
						<thead>
							<tr>
								<th align="center" style="text-align: center;">우편번호</th>
								<th align="center" style="text-align: center;">주소</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
			<div id="zipcode_roadName">
				<div class="popup_zipcodeResult">
					<table id="zipcode_searchResult_roadName"
						class="zipcode_searchResult" align="center">
						<thead>
							<tr>
								<th align="center" style="text-align: center;">우편번호</th>
								<th align="center" style="text-align: center;">주소</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
		<button type="button" class="button white medium"
			style="margin-top: 10px;" onClick="zipcode_fadeOut();">닫기</button>
	</div>
	<div id="div_fade" onClick="zipcode_fadeOut();"></div>
</body>
</html>