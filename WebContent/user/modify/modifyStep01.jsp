<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>개인정보 수정</title>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/button.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mainMenu.css">
	<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>
	<div id="layout">
		<%@include file="../../header.jsp"%>
		<article id="mainArticle" style="height:250px;padding-top:200px;">
			<form name="" method="post" action="modifyStep01-1.jsp">
				비밀번호를 입력하세요.<input type="password" name="userPwd" />
				<button class="button black small">확인</button>
			</form>
		</article>
		<%@ include file="../../footer.html"%>		
	</div>
</body>
</html>