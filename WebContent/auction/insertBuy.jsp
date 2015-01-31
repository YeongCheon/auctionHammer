<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.AuctionArticleDao" %>
<%@ page import="bean.Buy" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	AuctionArticleDao auctionArticleDao = new AuctionArticleDao();

	request.setCharacterEncoding("utf-8");
	Buy buy = new Buy();
	boolean inserted = false;
	
	
	buy.setBuy_article_id(Integer.parseInt(request.getParameter("article_id")));
	buy.setUser_id((String)request.getSession().getAttribute("userID"));
	buy.setBuy_zipcode(request.getParameter("user_zipcode01") + "user_zipcode02");
	buy.setAddr1(request.getParameter("user_addr01"));
	buy.setAddr2(request.getParameter("user_addr02"));
	
	if(auctionArticleDao.insertBuy(buy) >= 1){
		inserted = true;
	} else{
		inserted = false;
	}
%>
<c:set var="inserted" value="<%= inserted %>"/>

<c:choose>
	<c:when test="${inserted}">
		<script>alert('구매 완료!!!');location.href="./auctionArticleList.jsp";</script>	
	</c:when>
	<c:otherwise>
		<script>alert('구매실패!!');location.href="./insertAuctionForm.jsp";</script>	
	</c:otherwise>
</c:choose>