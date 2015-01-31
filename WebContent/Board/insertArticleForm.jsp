<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="bean.User" %>
<%@ page import="dao.UserDao" %>
<%
	UserDao userDao = new UserDao();

	User user = userDao.userGet((String)request.getSession().getAttribute("userID"));
	boolean isAdmin = false;
	if(user.getUser_type().equals(User.TYPE_ADMIN)){
		isAdmin = true;
	}
%>
<%
	if(session.getAttribute("userID") == null){
		out.println("<script>alert('권한이 없습니다.');location.href='./articleList.jsp';</script>");
		return;
	}
%>
<c:set var="isAdmin" value="<%= isAdmin %>"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/button.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mainMenu.css">

<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board.css">

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.form.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/ckeditor/ckeditor.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		$("#file_image").change(function() {
			$("#ajaxform").submit();
			document.getElementById("file_image").value = "";
		});
	});

	function validationCheck() {
		if (frm.title.value == '') {
			alert('제목을 입력해주세요');
			return false;
		}
		if (CKEDITOR.instances.editor1.getData() == '') {
			alert('내용을 입력해주세요');
			return false;
		}
	}
	
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
				CKEDITOR.instances.editor1.setData(CKEDITOR.instances.editor1.getData()+ "<img src='"+ xhr.responseText +"'/>'");
			}
		});
	});
</script>
<style type="text/css">

</style>
<title>게시판</title>
</head>
<body>
	<div id="layout">
		<%@include file="../header.jsp"%>
		<article id="mainArticle">
			<div class="content">
				<form id="ajaxform" action="./ajax_attachImage.jsp" method="post"	enctype="multipart/form-data">
					<input type="file" id="file_image" name="file_image" accept="image/*" style="display:none"/>
				</form>
				<form name="frm" method="post" action="./insertArticle.jsp"
					onSubmit="return validationCheck();">
					<input type="text" placeholder="제목을 입력해주세요" name="title" style="width: 100%" />
					<div style="text-align:left;margin:10px 0;">
						<c:if test="${isAdmin}">
							<input type="checkbox" name="isNotice" value="1"/>공지사항
						</c:if>
						<button type="button" onClick="document.getElementById('file_image').click();" class="button orange small" >이미지 삽입</button>
					</div>
					<textarea name="contents" class="ckeditor" id="editor1"></textarea>
					<input type="hidden" value="1" name="listId" />
					<button class="button blue" style="margin-top:10px;">글 쓰기</button>
				</form>
			</div>
		</article>
		<%@ include file="../footer.html"%>
	</div>
</body>
</html>