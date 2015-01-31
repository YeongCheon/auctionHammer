<%@ page language="java" contentType="text/json; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="bean.LandnumZipcode" %>
<%@ page import="dao.LandnumZipcodeDao" %>
<%
	LandnumZipcodeDao LandNumZipcodeDao = new LandnumZipcodeDao();

	request.setCharacterEncoding("utf-8");

	String result = "";
	if (request.getParameter("keyword") == null) {
		return;
	}
	
	String keyword = null;

	keyword = new String(request.getParameter("keyword").getBytes(
			"8859_1"), "UTF-8");

	
	List<LandnumZipcode> zipcodeList = LandNumZipcodeDao.getZipcodeList(keyword);
	
	int size = zipcodeList.size();
	
	if (size > 0) {
		result += "{ \"list\" : [";
	
		for (int i = 0; i < size; i++) {
			LandnumZipcode zipcodeObj = zipcodeList.get(i);
	
			String zipcode = zipcodeObj.getZipcode();
			String sido = zipcodeObj.getSido();
			String gugun = zipcodeObj.getGugun();
			String dong = zipcodeObj.getDong();
			String bunji = zipcodeObj.getBunji();
			String seq = zipcodeObj.getSeq();
	
			String close = null;
			if (i == size - 1) {
				close = "}	] }";
			} else {
				close = "},";
			}
			result += "{ ";
			result += "\"number\" : \"" + i + "\", ";
			result += "\"zipcode\" : \"" + zipcode + "\", ";
			result += "\"gugun\" : \"" + gugun + "\", ";
			result += "\"dong\" : \"" + dong + "\", ";
			result += "\"bunji\" : \"" + bunji + "\", ";
			result += "\"seq\" : " + seq;
			result += close;
		}
	} else if (size <= 0) {
		result = ("{ \"list\" : []}");
	}
%>
<c:set var="result" value="<%= result %>"/>

${result}