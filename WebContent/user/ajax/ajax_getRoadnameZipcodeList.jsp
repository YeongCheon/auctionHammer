<%@ page language="java" contentType="text/json; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="bean.RoadnameZipcode" %>
<%@ page import="dao.RoadnameZipcodeDao" %>
<%
	RoadnameZipcodeDao RoadNameZipcodeDao = new RoadnameZipcodeDao();
	request.setCharacterEncoding("utf-8");

	String result = "";
	String keyword = null;
	keyword = new String(request.getParameter("keyword").getBytes(
			"8859_1"), "UTF-8");
	
	List<RoadnameZipcode> zipcodeList = RoadNameZipcodeDao.getZipcodeList(keyword);
	int size = zipcodeList.size();
	
	
	if (size > 0) {
		result = "{ \"list\" : [";
	
		for (int i = 0; i < size; i++) {
			RoadnameZipcode zipcodeObj = zipcodeList.get(i);
	
			String zipcode = zipcodeObj.getRoad_zip_cd();
			String sido = zipcodeObj.getRoad_sido();
			String gugun = zipcodeObj.getRoad_gungu();
			String road_nm = zipcodeObj.getRoad_road_nm();
			String building_no = zipcodeObj.getRoad_building_no();
			String building_nm = zipcodeObj.getRoad_building_nm();
	
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
			result += "\"road_nm\" : \"" + road_nm + "\", ";
			result += "\"building_no\" : \"" + building_no + "\", ";
			result += "\"building_nm\" : \"" + building_nm + "\"";
			result += close;
		}
	}else if (size <= 0) {
		result = "{ \"list\" : []}";
	}
%>
<c:set var="result" value="<%= result %>"/>
${result}