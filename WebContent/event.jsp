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

<title>ᅟEvent</title>

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
				<img src="http://www.hopestart.or.kr/wp-content/uploads/2014/01/%EC%9D%B4%EB%B2%A4%ED%8A%B8A-copy1.jpg"/>
			</div>
		</article>
		<%@ include file="./footer.html"%>
	</div>
</body>
</html>