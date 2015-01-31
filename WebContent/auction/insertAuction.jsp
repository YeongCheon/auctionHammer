<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bean.AuctionArticle" %>
<%@ page import="dao.AuctionArticleDao" %>
<%@ page import="dao.AuctionAttachFileDao" %>
<%@ page import="util.FileUpload" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="java.sql.Timestamp" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	AuctionArticleDao auctionArticleDao = new AuctionArticleDao();
	AuctionAttachFileDao auctionAttachFileDao = new AuctionAttachFileDao();
	
	request.setCharacterEncoding("UTF-8");

	
	FileUpload fileUpload = new FileUpload(request);
	MultipartRequest multiRequest = fileUpload.getMultipartRequest();
	
	Timestamp startDate = (Timestamp) Timestamp.valueOf(multiRequest.getParameter("article_startdate") + ":00");
	Timestamp endDate = (Timestamp) Timestamp.valueOf(multiRequest.getParameter("article_enddate") + ":00");
	
	String article_seller = (String)request.getSession().getAttribute("userID");
	String article_title = multiRequest.getParameter("article_title");
	int article_type = Integer.parseInt(multiRequest.getParameter("article_type"));
	Timestamp article_startdate = startDate;
	Timestamp article_enddate = endDate;
	int article_marketprice = Integer.parseInt(multiRequest.getParameter("article_marketprice"));
	int article_startprice = Integer.parseInt(multiRequest.getParameter("article_startprice"));
	String article_content =  multiRequest.getParameter("article_content");
	String article_description = multiRequest.getParameter("article_description");
	
	AuctionArticle article = new AuctionArticle();
	article.setArticle_seller(article_seller);
	article.setArticle_title(article_title);
	article.setArticle_type(article_type);
	article.setArticle_startdate(article_startdate);
	article.setArticle_enddate(article_enddate);
	article.setArticle_marketprice(article_marketprice);
	article.setArticle_startprice(article_startprice);
	article.setArticle_content(article_content);
	article.setArticle_description(article_description);
	
	boolean inserted = false;
	if(auctionArticleDao.insertArticle(article) >= 1){
		inserted = true;
	}
	
	String[] categorys = multiRequest.getParameterValues("product_kind");
	auctionArticleDao.insertAuctionCategory(auctionArticleDao.getRecentAuctionArticleId(article_seller), categorys); //category 추가
	
	try {
		String thumnail = fileUpload.upload();
		auctionAttachFileDao.insertAttachFile(auctionArticleDao.getRecentAuctionArticleId(article_seller), thumnail); //image 경로 추가
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
%>
<c:set var="inserted" value="<%= inserted %>"/>
<c:choose>
	<c:when test="${inserted == true }">
		<script>alert('상풍이 정상적으로 등록되었습니다.');location.href="./auctionArticleList.jsp";</script>	
	</c:when>
	<c:otherwise>
		<script>alert('상풍 등룩 중 문제가 발생하였습니다.');location.href="./insertAuctionForm.jsp";</script>	
	</c:otherwise>
</c:choose>