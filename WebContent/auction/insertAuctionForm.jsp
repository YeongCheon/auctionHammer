<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/button.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mainMenu.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sideMenu.css">
<title>상품입력</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/js/datetimepicker/jquery.datetimepicker.css"/>
<script src="${pageContext.request.contextPath}/resources/js/datetimepicker/jquery.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/datetimepicker/jquery.datetimepicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/ckeditor/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.form.min.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		$("#file_image").change(function() {
			$("#ajaxform").submit();
			document.getElementById("file_image").value = "";
		});
	});
	
	$(function(){
		$('#ajaxform').ajaxForm({
			beforeSend: function () {
				//alert("시작전");
			},
			uploadProgress: function (event, position, total, percentComplete) {
				//alert("업로드중");
			},
			complete: function (xhr) {
				//alert("완료");
				CKEDITOR.instances.article_content.setData(CKEDITOR.instances.article_content.getData()+ "<img src='"+ xhr.responseText +"'/>'");
			}
		});
	});

 $(function() { 
  $(".datetimepicker").datetimepicker({
		 lang:'kr',
		 i18n:{
		  kr:{
		   months:[
				'1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월',
		   ],
		   dayOfWeek:[
			'일','월','화','수','목','금','토',
		   ]
		  }
		 },
		 format:'Y-m-d H:i'
  });
 });
 
 function validationCheck(){
	 var result = false;
	 
	 var article_title = document.getElementById("article_title");
	 var article_description = document.getElementById("article_description");
	 var auction_image01 = document.getElementById("auction_image01");
	 var article_startdate = document.getElementById("article_startdate");
	 var article_enddate = document.getElementById("article_enddate");
	 var article_startprice = document.getElementById("article_startprice");
	 var article_marketprice = document.getElementById("article_marketprice");
	 
	 if(article_title.value == ""){
		 alert("상품명을 입력해주세요.");
		 article_title.focus();
		 result = false;
	 } else if(article_description.value == ""){
		 alert("개요를 입력해주세요.");
		 article_description.focus();
		 result = false;
	 } else if(auction_image01.value == ""){
		 alert("이미지를 올려주세요.");
		 auction_image01.focus();
		 result = false;
	 } else if(article_startdate.value == ""){
		 alert("경매 시작일을 입력해주세요.");
		 article_startdate.focus();
		 result = false;
	 } else if(article_enddate.value == ""){
		 alert("경매 종료일을 입력해주세요.");
		 article_enddate.focus();
		 result = false;
	 } else if(article_startprice.value == ""){
		 alert("시작 가격을 입력해주세요.");
		 article_startprice.focus();
		 result = false;
	 } else if(article_marketprice.value == ""){
		 alert("시중 판매가를 입력해주세요.");
		 article_marketprice.focus();
		 result = false;
	 } else{
		 result = true;
	 }
	 
	 return result;
 }
</script>

<style type="text/css">
th{
	tex-align:right;
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
</style>
</head>
<body>
	<div id="layout">
		<%@include file="../header.jsp"%>
		<article id="mainArticle">
			<form action="./insertAuction.jsp" method="post" enctype="multipart/form-data" onsubmit="return validationCheck()">
				<table border="0">
					<tr>
						<th>상품명</th>
						<td><input type="text" id="article_title" name="article_title" /></td>
					</tr>
					<tr>
						<th>개요</th>
						<td><textarea rows="5" cols="150" id="article_description" name="article_description"></textarea></td>
					</tr>
					<tr>
						<th>경매방식</th>
						<td>
							<input type="radio" name="article_type" value="1" checked/>상향식 경매 
							<input type="radio" name="article_type" value="2"/>하향식 경매
							<input type="radio" name="article_type" value="3"/>private 경매
						</td>
					</tr>			
					<tr>
						<th>이미지</th>
						<td>
							<input type="file" name="auction_image01" id="auction_image01"/>
						</td>
					</tr>
					<tr>
						<th>상품분류</th>
						<td>
							<table>
								<tr>
									<th>패션의류</th>
									<th>패션잡화/명품</th>
									<th>뷰티헤어</th>
									<th>유아동/출산</th>
									<th>식품</th>
									<th>가구/침구</th>
								</tr>
								<tr>
									<td>
										<ul>
											<li><input type="checkbox" name="product_kind" value="1"/>여성의류</li>
											<li><input type="checkbox" name="product_kind" value="2"/>남성의류</li>
											<li><input type="checkbox" name="product_kind" value="3" />스몰/빅사이즈</li>
											<li><input type="checkbox" name="product_kind" value="4" />언더웨어/잠옷</li>
										</ul>
									</td>
									<td>
										<ul>
											<li><input type="checkbox" name="product_kind"  value="5"/>신발</li>
											<li><input type="checkbox" name="product_kind"  value="6"/>가방/패션잡화</li>
											<li><input type="checkbox" name="product_kind"  value="7"/>주얼리/시계</li>
											<li><input type="checkbox" name="product_kind"  value="8"/>수입명품</li>
										</ul>
									</td>
									<td>
										<ul>
											<li><input type="checkbox" name="product_kind"  value="9"/>화장품/향수</li>
											<li><input type="checkbox" name="product_kind"  value="10"/>바디/헤어</li>
										</ul>
									</td>
									<td>
										<ul>
											<li><input type="checkbox" name="product_kind" value="11"/>기저귀/분유</li>
											<li><input type="checkbox" name="product_kind" value="12"/>물티슈/생리대</li>
											<li><input type="checkbox" name="product_kind" value="13"/>출산/유아용품</li>
											<li><input type="checkbox" name="product_kind" value="14"/>장난감</li>
											<li><input type="checkbox" name="product_kind" value="15"/>유아동 의류</li>
											<li><input type="checkbox" name="product_kind" value="16"/>유아동 신발/잡화
											</li>
										</ul>
									</td>
									<td>
										<ul>
											<li><input type="checkbox" name="product_kind" value="17"/>신선식품</li>
											<li><input type="checkbox" name="product_kind" value="18"/>가공/즉석식품</li>
											<li><input type="checkbox" name="product_kind" value="19"/>건강식품</li>
											<li><input type="checkbox" name="product_kind" value="20"/>커피음료</li>
										</ul>
									</td>
									<td>
										<ul>
											<li><input type="checkbox" name="product_kind" value="21"/>가구/DIY</li>
											<li><input type="checkbox" name="product_kind" value="22"/>침구/커튼</li>
											<li><input type="checkbox" name="product_kind" value="23"/>조명/인테리어</li>
										</ul>
									</td>
								</tr>
								<tr>
									<th>생활/주방/문구</th>
									<th>스포츠/레저</th>
									<th>자동차/공구</th>
									<th>취미</th>
									<th>컴퓨터</th>
									<th>디지털</th>
								</tr>
								<tr>
									<td>
										<ul>
											<li><input type="checkbox" name="product_kind" value="24"/>생활용품</li>
											<li><input type="checkbox" name="product_kind" value="25"/>주방용품</li>
											<li><input type="checkbox" name="product_kind" value="26"/>화장지/세제</li>
											<li><input type="checkbox" name="product_kind" value="27"/>건장/의료용품</li>
											<li><input type="checkbox" name="product_kind" value="28"/>문구/사무용품</li>
										</ul>
									</td>
									<td>
										<ul>
											<li><input type="checkbox" name="product_kind" value="29"/>스포츠의류/운동화
											</li>
											<li><input type="checkbox" name="product_kind" value="30"/>휘트니스/수영</li>
											<li><input type="checkbox" name="product_kind" value="31"/>구기/라켓스포츠
											</li>
											<li><input type="checkbox" name="product_kind" value="32"/>골프</li>
											<li><input type="checkbox" name="product_kind" value="33"/>자전거/스키</li>
											<li><input type="checkbox" name="product_kind" value="34"/>캠핑/낚시</li>
										</ul>
									</td>
									<td>
										<ul>
											<li><input type="checkbox" name="product_kind" value="35"/>자동차/오토바이용품
											</li>
											<li><input type="checkbox" name="product_kind" value="36"/>블랙박스/네비게이션
											</li>
											<li><input type="checkbox" name="product_kind" value="37"/>공구/산업자재</li>
										</ul>
									</td>
									<td>
										<ul>
											<li><input type="checkbox" name="product_kind" value="38"/>애완용품</li>
											<li><input type="checkbox" name="product_kind" value="39"/>꽃/이벤트용품</li>
											<li><input type="checkbox" name="product_kind" value="40"/>악기/보드게임</li>
										</ul>
									</td>
									<td>
										<ul>
											<li><input type="checkbox" name="product_kind" value="41"/>노트북/데스크탑
											</li>
											<li><input type="checkbox" name="product_kind" value="42"/>모니터/프린터</li>
											<li><input type="checkbox" name="product_kind" value="43"/>컴퓨터부품/액세서리
											</li>
											<li><input type="checkbox" name="product_kind" value="44"/>저장장치</li>
										</ul>
									</td>
									<td>
										<ul>
											<li><input type="checkbox" name="product_kind" value="45"/>휴대폰/액세서리
											</li>
											<li><input type="checkbox" name="product_kind" value="46"/>카메라/액세서리
											</li>
											<li><input type="checkbox" name="product_kind" value="47"/>태블릿/음향기기
											</li>
										</ul>
									</td>
								</tr>
								<tr>
									<th>가전</th>
									<th>도서</th>
								</tr>
								<tr>
									<td>
										<ul>
											<li><input type="checkbox" name="product_kind" value="48"/>대형가전</li>
											<li><input type="checkbox" name="product_kind" value="49"/>주방가전</li>
											<li><input type="checkbox" name="product_kind" value="50"/>계절가전</li>
											<li><input type="checkbox" name="product_kind" value="51"/>생활/이미용가전
											</li>
											<li><input type="checkbox" name="product_kind" value="52"/>건강가전</li>
										</ul>
									</td>
									<td>
										<ul>
											<li><input type="checkbox" name="product_kind" value="53"/>학습/사전/참고서
											</li>
											<li><input type="checkbox" name="product_kind" value="54"/>문학/과학/경영
											</li>
											<li><input type="checkbox" name="product_kind" value="55"/>월간/계간/잡지
											</li>
											<li><input type="checkbox" name="product_kind" value="56"/>여행/취미/요리
											</li>
											<li><input type="checkbox" name="product_kind" value="57"/>예술/디자인도서
											</li>
											<li><input type="checkbox" name="product_kind" value="58"/>컴퓨터/인터넷도서
											</li>
											<li><input type="checkbox" name="product_kind" value="59"/>아동/어린이도서
											</li>
											<li><input type="checkbox" name="product_kind" value="60"/>소설/만화책</li>
											<li><input type="checkbox" name="product_kind" value="61"/>전집</li>
										</ul>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<th>경매 시작일</th>
						<td>
							<input type="text" name="article_startdate" id="article_startdate" class="datetimepicker" length="10" readonly/>
						</td>
					</tr>
					<tr>
						<th>경매 종료일</th>
						<td>
							<input type="datetime" name="article_enddate" id="article_enddate" class="datetimepicker" length="10" readonly/>
						</td>
					</tr>					
					<tr>
						<th>시작 가격</th>
						<td>
							<input type="text" name="article_startprice" id="article_startprice">원
						</td>
					</tr>
					<tr>
						<th>시중 판매가</th>
						<td><input type="text" name="article_marketprice" id="article_marketprice">원</td>
					</tr>
					<tr>
						<th style="vertical-align:top">상풍설명</th>
						<td style="vertical-align:top">
							<div style="text-align:left;">
								<button type="button" onClick="document.getElementById('file_image').click();" class="button orange small" >이미지 삽입</button>
							</div>
							<textarea rows="5" cols="150" id="article_content" name="article_content"  class="ckeditor"></textarea>
						</td>
				</table>
				<button>확인</button>
			</form>
			<form id="ajaxform" action="./uploadContentImage.jsp" method="post"	enctype="multipart/form-data">
					<input type="file" id="file_image" name="file_image" accept="image/*" style="display:none"/>
				</form>
		</article>
		<%@ include file="../footer.html"%>
	</div>
</body>
</html>