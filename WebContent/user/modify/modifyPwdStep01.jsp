<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String loginID = (String) session.getAttribute("userID");
	String auth = (String) session.getAttribute("modify_auth");
	if (loginID == null || auth == null) {
		response.sendRedirect("../../index.jsp");
%>
<script type="text/javascript">
	alert('비정상적인 방법으로 접근하셨습니다.');
	location.href = "../../index.jsp";
</script>
<%
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>비밀번호 변경</title>
	<script type="text/javascript">
		function validationCheck(){
			var result = true;
			
			var user_password = frm.user_password.value;
			var user_passwordRepeat = frm.user_passwordRepeat.value;
		
			if (user_password.length < 7) {
				document.getElementById("error_user_password").innerHTML = "비밀번호를 7자 이상 입력해주세요.";
				result = false;
			} else if (user_password != user_passwordRepeat) {
				document.getElementById("error_user_password").innerHTML = "비밀번호와 비밀번호 확인이 일치하지 않습니다.";
				result = false;
			} else {
				document.getElementById("error_user_password").innerHTML = "";
			}
		
			if (user_passwordRepeat == "") {
				document.getElementById("error_user_passwordRepeat").innerHTML = "비밀번호 확인을 입력해주세요.";
				result = false;
			} else {
				document.getElementById("error_user_passwordRepeat").innerHTML = "";
			}
			
			return result;
		}

	</script>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/button.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mainMenu.css">	
	<style type="text/css">
		#div_title {
			margin: 30px auto 0 auto;
			padding: 5px 0 0 5px;
			background-color: #4b545f;
			color: #ffffff;
			font-size: 14pt;
			width: 605px;
			height: 50px;
			text-align: left;
		}	
		th{
			text-align:right;
		}
		td{
			text-align:left;
		}
		
		.modifySideMenu{
			background:none;
			display:block; 
			float:left; 
			width:200px;
			height:100%; 
			border:1px solid #4b545f; 
			margin:0px;
		}
		
		.modifySideMenu li{
			margin: 20px 0;
		}
	</style>
</head>
<body>
	<div id="layout" style="margin-bottom:50px;">
		<%@include file="../../header.jsp"%>
		<article id="mainArticle" style="height:450px;margin-top:5px;">
			<%@include file="./module_leftMenu.jsp"%>	
			<div style="position:relative;width:800px;float:right;z-index:0;border:1px solid #4b545f;padding-bottom:10px;height:100%">
				<form name="frm" method="post" action="./submitPwdModify.jsp" onsubmit="return validationCheck();">
					<div class="div_title">비밀번호 수정</div>
					<table border="0" align="center" style="margin-top:150px;">
						<tr>
							<th>비밀번호</th>
							<td>
								<input type="password" name="user_password" />
								<div id="error_user_password" class="div_error"></div>
							</td>
						</tr>
						<tr>
							<th>비밀번호 확인</th>
							<td>
								<input type="password" name="user_passwordRepeat" />
								<div id="error_user_passwordRepeat" class="div_error"></div>
							</td>
						</tr>
					</table>
					<button class="button white" style="margin-top:10px;">확인</button>
				</form>
			</div>
		</article>
		
		<%@ include file="../../footer.html"%>
	</div>
</body>
</html>