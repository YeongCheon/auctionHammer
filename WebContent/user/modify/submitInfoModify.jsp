<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import ="bean.User" %>
<%@ page import="dao.UserDao"%>
<%
	UserDao userDao = new UserDao();
	request.setCharacterEncoding("utf-8");
	
	boolean isUpdated = false;
	
	User user = new User();
	
	String id = request.getParameter("user_id");
	String pwdHint = request.getParameter("user_pwdHint");
	String answer = request.getParameter("user_answer");
	String name = request.getParameter("user_name");
	String nicname = request.getParameter("user_nicname");
	String gender = request.getParameter("user_gender");
	String birthday = request.getParameter("birthday_year") + request.getParameter("birthday_month") + request.getParameter("birthday_day");
	String emailID = request.getParameter("user_emailID");
	String emailDomain = request.getParameter("user_emailDomain");
	String localNum = request.getParameter("user_localNum");
	String callNum = request.getParameter("user_callNum01")
			+ request.getParameter("user_callNum02"); // !!!
	String phone = request.getParameter("user_phone01")
			+ request.getParameter("user_phone02")
			+ request.getParameter("user_phone03");
	String zipcode = request.getParameter("user_zipcode01")
			+ request.getParameter("user_zipcode02"); // !!!
	String addr1 = request.getParameter("user_addr01");
	String addr2 = request.getParameter("user_addr02");
	
	/*		
	id = ESAPI.encoder().encodeForHTML(id);
	pwdHint = ESAPI.encoder().encodeForHTML(pwdHint);
	answer = ESAPI.encoder().encodeForHTML(answer);
	name = ESAPI.encoder().encodeForHTML(name);
	nicname = ESAPI.encoder().encodeForHTML(nicname);
	gender = ESAPI.encoder().encodeForHTML(gender);
	birthday = ESAPI.encoder().encodeForHTML(birthday); //new Column
	emailID = ESAPI.encoder().encodeForHTML(emailID);
	emailDomain = ESAPI.encoder().encodeForHTML(emailDomain);
	localNum = ESAPI.encoder().encodeForHTML(localNum);
	callNum = ESAPI.encoder().encodeForHTML(callNum);
	phone = ESAPI.encoder().encodeForHTML(phone);
	zipcode = ESAPI.encoder().encodeForHTML(zipcode);
	addr1 = ESAPI.encoder().encodeForHTML(addr1);
	addr2 = ESAPI.encoder().encodeForHTML(addr2);
	*/
	user.setUser_id(id);
	user.setUser_pwdHint(pwdHint);
	user.setUser_answer(answer);
	user.setUser_name(name);
	user.setUser_nicname(nicname);
	user.setUser_gender(gender);
	user.setUser_birthday(birthday);
	user.setUser_emailID(emailID);
	user.setUser_emailDomain(emailDomain);
	user.setUser_localNum(localNum);
	user.setUser_callNum(callNum);
	user.setUser_phone(phone);
	user.setUser_zipcode(zipcode);
	user.setUser_addr1(addr1);
	user.setUser_addr2(addr2);
	
	
	if (userDao.userModify(user) > 0) {
		isUpdated = true;
	} else {
		isUpdated = false;
	}
%>
<c:set var="isUpdated" value="<%= isUpdated %>"/>

<c:if test="${!updated}">
	<script type='text/javascript'>alert('정보가 정상적으로 수정되었습니다.');location.href='${pageContext.request.contextPath}/index.jsp';</script>
</c:if>
<c:if test="${updated}">
	<script type='text/javascript'>alert('정보수정에 실패하였습니다.');location.href='${pageContext.request.contextPath}/index.jsp';</script>
</c:if>