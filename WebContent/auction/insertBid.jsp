<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="dao.AuctionBidDao" %>
<%@ page import="bean.AuctionBid" %>
<%@ page import="dao.AuctionArticleDao" %>
<%
	AuctionBidDao AuctionBidDao = new AuctionBidDao();
	AuctionArticleDao auctionArticleDao = new AuctionArticleDao();

	boolean inserted = false;
	String user_id = (String)request.getSession().getAttribute("userID");
	
	if(user_id == null){ // session 정보 없을 시 fail;

	}
	
	int article_id = Integer.parseInt(request.getParameter("article_id"));
	
	AuctionBid bid_maximum = AuctionBidDao.getMaximumBid(article_id);
	int insertPrice = 0;
	if(bid_maximum == null){
		insertPrice = auctionArticleDao.getAuctionArticle(article_id).getArticle_startprice();
	} else{
		insertPrice = bid_maximum.getBid_price();
	}
	
	insertPrice += 100;
	
	
	if(AuctionBidDao.insertBid(new AuctionBid(article_id, user_id, insertPrice)) >= 1){
		inserted = true;
	}
	
%>
<c:set var="inserted" value="<%= inserted %>"/>
<c:set var="price" value="<%= insertPrice %>"/>
{

<c:choose>
	<c:when test="${inserted == true }">
		"price" : "<fmt:formatNumber value="${price}" type="CURRENCY" groupingUsed="true" />",
		"price_number" : "${price}"
	</c:when>
	<c:otherwise>
		"price" : "0"
		"price_number" : "0"
	</c:otherwise>
</c:choose>
}