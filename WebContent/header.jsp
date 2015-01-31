<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header id="header">
	<div>
		<div id="header_logo"><a href="${pageContext.request.contextPath}/index.jsp"><img src="${pageContext.request.contextPath}/resources/image/common/logo.jpg"/></a></div>
		<div style="float:right;">
			<div id="header_action">
				<div style="float:right;">
				<%
					if(session.getAttribute("userID") == null){
				%>
					<button type="button" class="button blue small" onClick="location.href='${pageContext.request.contextPath}/login/loginForm.jsp'">로그인</button>
					<button type="button" class="button red small" onClick="location.href='${pageContext.request.contextPath}/user/insertUserForm.jsp'">회원가입</button>
				<%
					}else{
				%>
					<%= (String)session.getAttribute("userName") %>
					<button type="button" class="button white small" onClick="location.href='${pageContext.request.contextPath}/auction/myBidList.jsp';">나의 입찰내역</button>
					<button type="button" class="button white small" onClick="location.href='${pageContext.request.contextPath}/auction/myBuyList.jsp';">나의 구매내역</button>
					<button type="button" class="button white small" class="" onClick="location.href='${pageContext.request.contextPath}/user/modify/modifyStep01.jsp'">개인정보 수정</button>
					<%
						if(((String)session.getAttribute("userType")).equals("SELLER")){
					%>
					<!-- <button type="button" class="button white small">내 매장</button>  -->
					<button type="button" class="button white small" onClick="location.href='${pageContext.request.contextPath}/auction/insertAuctionForm.jsp';">경매등록</button>
					<%
						}
					%>
					<button type="button" class="button red small" class="" onClick="location.href='${pageContext.request.contextPath}/login/logout.jsp';">로그아웃</button>
				<%
					}
				%>

				</div>
				<div style="clear:both; height:45px; padding:5px 0; text-align:right;">
					<form name="frm_search" action="${pageContext.request.contextPath}/auction/auctionArticleList.jsp" method="get">
						<div style="float:right"><input type="image" src="${pageContext.request.contextPath}/resources/image/common/btn_search.png" style="padding:0; margin:0;"/></div>
						<div style="float:right"><input type="text" name="searchBox" style="height:30px; border-style: solid; border-width:6px; border-color:#dc315b; margin:0; padding:0;"/></div>
						<input type="hidden" name="search_type" value="keyword"/>
					</form>
				</div>
			</div>
		</div>
	</div>
	<nav id="mainMenu">
		<ul>
			<li><a href="#">About</a>
				<ul>
					<li><a href="#">About Site</a></li>
					<li><a href="#">About Auction</a></li>
					<!-- <li><a href="#">About Member</a></li> -->
				</ul>
			</li>
			<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?article_type=1">Auction</a>
				<ul>
					<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?article_type=1">상향식 경매</a></li>
					<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?article_type=2">하향식 경매</a></li>
					<li><a href="${pageContext.request.contextPath}/auction/auctionArticleList.jsp?article_type=3">Private 경매</a></li>
				</ul>
			</li>
			<li><a href="${pageContext.request.contextPath}/guide.jsp">Guide</a>
				<ul>
					<!-- <li><a href="#">Guide</a></li>
					<li><a href="#">Q&amp;A</a></li>  -->
				</ul>					
			</li>
			<li><a href="${pageContext.request.contextPath}/event.jsp">Event</a></li>
			<li><a href="${pageContext.request.contextPath}/Board/articleList.jsp">Community</a></li>
		</ul>
	</nav>
</header>