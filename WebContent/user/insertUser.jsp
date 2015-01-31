<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.owasp.esapi.ESAPI"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import ="bean.User" %>
<%@ page import="dao.UserDao"%>
<%
	UserDao userDao = new UserDao();
	request.setCharacterEncoding("utf-8");
	
	User user = new User();
	
	String id = request.getParameter("user_id");
	String password = request.getParameter("user_password");
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
	String type= request.getParameter("user_type");
	
	/*
	id = ESAPI.encoder().encodeForHTML(id);
	password = ESAPI.encoder().encodeForHTML(password);
	pwdHint = ESAPI.encoder().encodeForHTML(pwdHint);
	answer = ESAPI.encoder().encodeForHTML(answer);
	name = ESAPI.encoder().encodeForHTML(name);
	nicname = ESAPI.encoder().encodeForHTML(nicname);
	gender = ESAPI.encoder().encodeForHTML(gender);
	birthday = ESAPI.encoder().encodeForHTML(birthday);
	emailID = ESAPI.encoder().encodeForHTML(emailID);
	emailDomain = ESAPI.encoder().encodeForHTML(emailDomain);
	localNum = ESAPI.encoder().encodeForHTML(localNum);
	callNum = ESAPI.encoder().encodeForHTML(callNum);
	phone = ESAPI.encoder().encodeForHTML(phone);
	zipcode = ESAPI.encoder().encodeForHTML(zipcode);
	addr1 = ESAPI.encoder().encodeForHTML(addr1);
	addr2 = ESAPI.encoder().encodeForHTML(addr2);
	type = ESAPI.encoder().encodeForHTML(type);
	 */
	user.setUser_id(id);
	user.setUser_password(password);
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
	user.setUser_type(type);
	
	
	
	boolean result = false;
	if(userDao.userAdd(user)>0){
		result = true;	
	} else{
		result = false;	
	}
%>
<c:set var="result" value="<%= result %>"/>

<c:if test="${result == true}">
	<script type='text/javascript'>alert('회원가입이 정상적으로 완료되었습니다.환영합니다 \\n고갱님');location.href='${pageContext.request.contextPath}/index.jsp';</script>
</c:if>
<c:if test="${result == false}">
	<script type='text/javascript'>alert('회원가입에 실패하었습니다.');location.href='${pageContext.request.contextPath}/index.jsp';</script>
</c:if>