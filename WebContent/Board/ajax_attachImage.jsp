<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="util.FileUpload" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	FileUpload fileUpload = new FileUpload(request);
%>
<c:set var="src" value="<%= fileUpload.upload() %>"/>
${src}