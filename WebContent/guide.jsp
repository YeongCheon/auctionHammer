<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/button.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mainMenu.css">

<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sideMenu.css">

<title>초보자 Guide</title>

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
		<%@include file="./header.jsp"%>
		<article id="mainArticle" style="">
			<div>
				<img src="./resources/image/guideHeader.gif"/>
			</div>
			<div>
				<p style="margin-left:30px; text-align:left;font-size:15pt">1. 회원가입을 하고 로그인을 합니다.<br />
				<br />
				2. 내가 입찰하고 싶은 물건이 있나 찾아봅니다.<br />
				<br />
				3. 입찰을 합니다.<br />
				<br />
				4. 내 입찰내역으로 들어가 내가 입찰한 물건을 낙찰받았나 확인해봅니다.(낙찰받으면 구매하기 버튼이 나옵니다.)<br />
				<br />
				5. 구매하기 버튼을 눌러 결제를 진행하고 구매확인을 합니다.</p>
			</div>
		</article>
		<%@ include file="./footer.html"%>
	</div>
</body>
</html>