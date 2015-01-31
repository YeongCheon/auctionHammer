<%@page import="javax.naming.Context"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link type="text/css" rel="stylesheet" href="../resources/css/common.css">
	<link type="text/css" rel="stylesheet" href="../resources/css/button.css">
	<link type="text/css" rel="stylesheet" href="../resources/css/mainMenu.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>

<title>로그인</title>

<style type="text/css">
#loginForm {
	width: 400px;
	height: 200px;
	margin: 100px auto 100px auto;
	border:1px solid #4b545f;
}

th {
	text-align: right;
}

td {
	text-align: left;
}
</style>
<script type="text/javascript">
<!--
	function checkParams(){
		var userID = document.getElementById("userID");
		var userPwd = document.getElementById("userPwd");
		
		if(userID.value == "" || userID.value == null){
			alert('아이디를 입력해주세요.');
			return false;
		} else if(userPwd.value == "" || userPwd.value == null){
			alert("비밀번호를 입력해주세요.");
			return false;
		} else{
			return true;
		}
	}
-->
</script>
</head>
<body>
	<div id="layout">
		<%@include file="../header.jsp"%>
		<div id="loginForm">
			<div class="div_title">로그인</div>
			<form name="frm" method="post" action="./login.jsp" onsubmit="return checkParams();">
				<table border="0" align="center" style="margin-top:30px;">
					<tr>
						<th>아이디 :</th>
						<td><input type="text" name="userID" id="userID" tabindex="1"/></td>
						<td rowspan="2"><button class="button black"
								style="height: 100%"  tabindex="3">로그인</button></td>
					</tr>
					<tr>
						<th>비밀번호 :</th>
						<td><input type="password" name="userPwd" id="userPwd"  tabindex="2"/></td>
					</tr>
				</table>
				<div><a href="../user/insertUserForm.do">회원가입</a>&nbsp;&nbsp; | &nbsp;&nbsp;<a href="#">ID/PW찾기</a></div>

			</form>
		</div>
		<%@ include file="../footer.html"%>
	</div>
</body>
</html>

<%
	if(session.getAttribute("userID") != null){
		response.sendRedirect("../index.jsp");
	}
%>