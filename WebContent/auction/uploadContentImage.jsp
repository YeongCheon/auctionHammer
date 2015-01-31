<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="util.FileUpload" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	FileUpload fileupload = new FileUpload(request);
	String src = null;
	
	try {
		src = fileupload.upload();
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
%>
<c:set var="src" value="<%= src %>"/>
${src}