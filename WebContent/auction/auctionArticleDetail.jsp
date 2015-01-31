<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="bean.AuctionArticle" %>
<%@ page import="bean.AuctionAttachFile" %>
<%@ page import="bean.AuctionBid" %>
<%@ page import="dao.AuctionBidDao" %>
<%@ page import="dao.AuctionArticleDao" %>
<%@ page import="dao.AuctionAttachFileDao" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%
AuctionBidDao AuctionBidDao = new AuctionBidDao();
AuctionArticleDao auctionArticleDao = new AuctionArticleDao();
AuctionAttachFileDao auctionAttachFileDao = new AuctionAttachFileDao();

int article_id = Integer.parseInt(request.getParameter("article_id"));
AuctionArticle article = auctionArticleDao.getAuctionArticle(article_id);
AuctionAttachFile thumnail = auctionAttachFileDao.getAttachFile(article_id);

AuctionBid bid_maximum = AuctionBidDao.getMaximumBid(article_id);
if(bid_maximum != null){
	article.setArticle_startprice(bid_maximum.getBid_price());
}

%>
<c:set var="article" value="<%= article %>"/>
<c:set var="thumnail" value="<%= thumnail %>"/>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/button.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mainMenu.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sideMenu.css">

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/countdown/jquery.plugin.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/countdown/jquery.countdown.js"></script>
<title>상품명 : ${article.article_title }</title>
<script type="text/javascript">
	function insertBid(article_id){
		if(confirm('정말 입찰하시겠습니까?')){
			$.ajax({
				url : './insertBid.jsp?article_id='+article_id,
				dataType : 'JSON',
				type : 'get',
				success : function(result) {
					alert(result.price +"원에 입찰하셨습니다.");
					$("#startprice").html(result.price);
					$("#hidden_startprice").val(result.price_number);
					calcProfit();
				},
				error: function(xhr, status, error){
					alert("error : " + error);
				}
			});
		}
	}
	
	function calcProfit(){
		var profit = document.getElementById("profit");
		var startprice = document.getElementById("hidden_startprice").value;
		var marketprice = document.getElementById("hidden_marketprice").value;
		profit.innerHTML = commaNum(marketprice - startprice);
	}
	
	function startCountdown(timestamp){
		var year = timestamp.substr(0,4);
		var month = timestamp.substr(5,2);
		var day = timestamp.substr(8,2);
		var hour = timestamp.substr(11,2);
		var minute = timestamp.substr(14,2);
		var second = timestamp.substr(17,2);
		
		var enddate = new Date();
		enddate.setFullYear(year);
		enddate.setMonth(month-1);
		enddate.setDate(day);
		enddate.setHours(hour);
		enddate.setMinutes(minute);
		enddate.setSeconds(second);
		
		$("#leftTime").countdown({until:enddate, layout:'<b> {d<} <span class="timer">{d10}</span> : {d>} <span class="timer">{hn}</span> : <span class="timer">{mn}</span> : <span class="timer">{sn}<span></b>', padZeroes: true}); 
	}
	
	function commaNum(num) {  
        var len, point, str;  
  
        num = num + "";  
        point = num.length % 3  
        len = num.length;  
  
        str = num.substring(0, point);  
        while (point < len) {  
            if (str != "") str += ",";  
            str += num.substring(point, point + 3);  
            point += 3;  
        }  
        return str;  
    }  
	
	function loaded(){
		startCountdown('${article.article_enddate}');
		calcProfit();
	}
</script>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/jwebsocket.css">
<script src="${pageContext.request.contextPath}/resources/js/jWebSocket.js" type="text/javascript"></script>
<script type="text/javascript" language="JavaScript">
	var lJWSID = "jWebSocket Chat",
	lWSC = null,
	eLog = null,
	eUsername = null,
	ePassword = null,
	ePool = null,
	eMessage = null,
	eTarget = null,
	eDebug = null,
	eKeepAlive = null;

	var IN = 0;
	var OUT = 1;
	var EVT = 2;
	var SYS = "SYS";
	var USR = null;

	// append a line to the log text area
	function log( aUsername, aEvent, aString ) {
		var lFlag;
		switch( aEvent ) {
			case IN: lFlag = "<"; break;
			case OUT: lFlag = ">"; break;
			case EVT: lFlag = "*"; break;
			default: lFlag = "?";
		}
		// set a default user name if not yet logged in
		if( !aUsername ) {
			aUsername = lWSC.getUsername();
		}
		if( !aUsername ) {
			aUsername = "USR";
		}
		eLog.innerHTML +=
			aUsername + " " +
			lFlag + " " +
			aString + "<br>";
		if( eLog.scrollHeight > eLog.clientHeight ) {
			eLog.scrollTop = eLog.scrollHeight - eLog.clientHeight;
		}
	}

	function clearLog() {
		eLog.innerHTML = "";
		eLog.scrollTop = 0;
	}

	function doFocus( aElement ) {
		aElement.focus();
		//aElement.select();
		document.getElementById("stxaMsg").value = "";
	}

	function logon() {
		// URL is ws[s]://[hostname|localhost]:8787[/context][/servlet/][;args...]
		// you can also use getDefaultSSLServerURL for secured connections
		var lURL = jws.getDefaultServerURL(); // + "/;timeout=360000";
		log( SYS, OUT, "Connecting to " + lJWSID + " at " + lURL + "..." );

		// try to establish connection to jWebSocket server
		lWSC.logon( lURL, eUsername.value, ePassword.value, {

			// OnOpen callback
			OnOpen: function( aEvent ) {
				log( SYS, IN, "Connection to " + lJWSID + " established." );
				// start keep alive if user selected that option
				checkKeepAlive({ immediate: false });
				jws.$("simgStatus").src = "${pageContext.request.contextPath}/resources/image/connected.png";
			},

			// OnMessage callback
			OnMessage: function( aEvent, aToken ) {
				// for debug purposes
				if( eDebug.checked ) {
					log( SYS, EVT, "<font style='color:#888'>" +
						( aToken ? aToken.type : "-" ) + ": " +
						aEvent.data + "</font>");
				}
				if( lWSC.isLoggedIn() ) {
					jws.$("simgStatus").src = "${pageContext.request.contextPath}/resources/image/authenticated.png";
				} else {
					jws.$("simgStatus").src = "${pageContext.request.contextPath}/resources/image/connected.png";
				}
				jws.$("slblClientId").innerHTML =
					"&nbsp;Client&#x2011;Id:&nbsp;"
					+ lWSC.getId() + "&nbsp;"
					+ ( jws.browserSupportsNativeWebSockets ? "(native)" : "(flashbridge)" );
				if( aToken ) {
					// is it a response from a previous request of this client?
					if( aToken.type == "response" ) {
						// figure out of which request
						if( aToken.reqType == "login" ) {
							if( aToken.code == 0 ) {
								log( SYS, IN, "Welcome '" + aToken.username + "'" );
								// select message field for convenience
								doFocus( eMessage );
								// call getAuthClients method from
								// jWebSocket System Client Plug-In
								lWSC.getAuthClients({
									pool: null
								});
							} else {
								log( SYS, IN, "Error logging in '" + eUsername.value + "': " + aToken.msg );
								// select username again for convenience
								doFocus( eUsername );
							}
						} else if( aToken.reqType == "getClients" ) {
							log( SYS, IN, "Clients (" + aToken.count + "): " + aToken.clients );
						}
						// is it an event w/o a previous request ?
					} else if( aToken.type == "event" ) {
						// interpret the event name
						// :
					} else if( aToken.type == "goodBye" ) {
						log( SYS, IN, lJWSID + " says good bye (reason: " + aToken.reason + ")!" );
						doFocus( eUsername );
						// is it any token from another client
					} else if( aToken.type == "broadcast" ) {
						if( aToken.data ) {
							log( aToken.sender, IN, aToken.data );
						}
					}
				}
			},

			// OnClose callback
			OnClose: function( aEvent ) {
				lWSC.stopKeepAlive();
				log( SYS, IN, "Disconnected from " + lJWSID + "." );
				jws.$("simgStatus").src = "${pageContext.request.contextPath}/resources/image/disconnected.png";
				jws.$("slblClientId").innerHTML = "&nbsp;Client&#x2011;Id:&nbsp;-";
				doFocus( eUsername );
			}
			
		});
	}

	function getClients() {
		var lRes = lWSC.getAuthClients({
			pool: null
		});
		log( SYS, OUT, "getClients: " + lRes.msg );
	}

	function logoff() {
		// disconnect automatically logs out!
		lWSC.stopKeepAlive();
		var lRes = lWSC.close({
			// wait a maximum of 3 seconds for server good bye message
			timeout: 3000
		});
		log( SYS, OUT, "logout: " + lRes.msg );
	}

	function broadcast() {
		var lMsg = eMessage.value;
		var lTarget = eTarget.value;
		if( lMsg.length > 0 ) {
			log( USR, OUT, lMsg );
			var lRes;
			if( !lTarget || lTarget == "*") {
				lRes = lWSC.broadcastText(
					"",			// broadcast to all clients (not limited to a certain pool)
					lMsg		// broadcast this message
				);
			} else {
				lRes = lWSC.sendText(
					lTarget,	// broadcast to all clients (not limited to a certain pool)
					lMsg		// broadcast this message
				);
			}
			// log error only, on success don't confuse the user
			if( lRes.code != 0 ) {
				log( SYS, OUT, "broadcast: " + lRes.msg );
			}
			// eMessage.value = "";
		}
		doFocus( eMessage );
	}

	function checkKeepAlive( aOptions ) {
		if( !aOptions ) {
			aOptions = {};
		}
		aOptions.interval = 30000;
		if( eKeepAlive.checked ) {
			lWSC.startKeepAlive( aOptions );
		} else {
			lWSC.stopKeepAlive();
		}
	}

	function usrKeyDnLsnr( aEvent ) {
		// on enter in username field try to login
		if( aEvent.keyCode == 13 ) {
			logon();
		}
	}

	function msgKeyDnLsnr( aEvent ) {
		// on enter in message field send broadcast the message
		if( !aEvent.shiftKey && aEvent.keyCode == 13 ) {
			broadcast();
		}
	}

	function elemFocusLsnr( aEvent ) {
		// on focus select full text of element (for username and message)
		jws.events.getTarget( aEvent ).select();
	}

	var lNextWindowId = 1;

	function openSubWindow() {
		window.open(
		// "http://www.jwebsocket.org/demos/chat/chat.htm"
		"demos/chat/chat.htm",
		"chatWindow" + lNextWindowId,
		"width=900,height=700,left=" + (50 + lNextWindowId * 30) + ",top=" + (50 + lNextWindowId * 25)
	);
		lNextWindowId++;
		if( lNextWindowId > 10 ) {
			lNextWindowId = 1;
		}
	}

	function initPage() {
		// get some required HTML elements
		eLog = jws.$( "sdivChat" );
		eUsername = jws.$( "stxfUsername" );
		ePassword = jws.$( "spwfPassword" );
		ePool = jws.$( "stxfPool" );
		eReceiver = jws.$( "stxfReceiver" );
		eMessage = jws.$( "stxaMsg" );
		eTarget = jws.$( "stxfTarget" );
		eDebug = jws.$( "schkDebug" );
		eKeepAlive = jws.$( "schkKeepAlive" );
			
		// check if WebSockets are supported by the browser
		if( jws.browserSupportsWebSockets() ) {
			// instaniate new TokenClient, either JSON, CSV or XML
			lWSC = new jws.jWebSocketJSONClient();
			// lWSC = new jws.jWebSocketCSVClient();

			jws.events.addEventListener( eUsername, "keydown", usrKeyDnLsnr );
			jws.events.addEventListener( eMessage, "keydown", msgKeyDnLsnr );
			jws.events.addEventListener( eMessage, "keyup", clrMsg );
			jws.events.addEventListener( eUsername, "focus", elemFocusLsnr );
			jws.events.addEventListener( eMessage, "focus", elemFocusLsnr );
			/*
			eUsername.addEventListener( "keydown", usrKeyDnLsnr, false );
			eMessage.addEventListener( "keydown", msgKeyDnLsnr, false );
			eUsername.addEventListener( "focus", elemFocusLsnr, false );
			eMessage.addEventListener( "focus", elemFocusLsnr, false );
			 */
			eUsername.focus();
			eUsername.select();
		} else {
			jws.$( "sbtnSend" ).setAttribute( "disabled", "disabled" );
			jws.$( "sbtnLogin" ).setAttribute( "disabled", "disabled" );
			jws.$( "sbtnLogout" ).setAttribute( "disabled", "disabled" );
			jws.$( "sbtnGetClients" ).setAttribute( "disabled", "disabled" );
			jws.$( "sbtnClearLog" ).setAttribute( "disabled", "disabled" );
			
			eDebug.setAttribute( "disabled", "disabled" );
			eKeepAlive.setAttribute( "disabled", "disabled" );
			eUsername.setAttribute( "disabled", "disabled" );
			eMessage.setAttribute( "disabled", "disabled" );
			eTarget.setAttribute( "disabled", "disabled" );
			
			var lMsg = jws.MSG_WS_NOT_SUPPORTED;
			alert( lMsg );
			log( SYS, IN, lMsg );
		}
		
		logon();
	}

	function exitPage() {
		// this allows the server to release the current session
		// immediately w/o waiting on the timeout.
		if( lWSC ) {
			lWSC.close({
				// force immediate client side disconnect
				timeout: 0
			});
		}
	}
	
	function clrMsg(aEvent){
		if( !aEvent.shiftKey && aEvent.keyCode == 13 ) {
			document.getElementById("stxaMsg").value = "";
		}		
	}

</script>

<style type="text/css">
  	.timer{
		background: #4c4c4c; /* Old browsers */
		background: -moz-linear-gradient(top,  #4c4c4c 0%, #595959 3%, #666666 8%, #474747 12%, #474747 12%, #474747 15%, #2c2c2c 22%, #000000 38%, #111111 60%, #2b2b2b 75%, #1c1c1c 91%, #131313 100%); /* FF3.6+ */
		background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#4c4c4c), color-stop(3%,#595959), color-stop(8%,#666666), color-stop(12%,#474747), color-stop(12%,#474747), color-stop(15%,#474747), color-stop(22%,#2c2c2c), color-stop(38%,#000000), color-stop(60%,#111111), color-stop(75%,#2b2b2b), color-stop(91%,#1c1c1c), color-stop(100%,#131313)); /* Chrome,Safari4+ */
		background: -webkit-linear-gradient(top,  #4c4c4c 0%,#595959 3%,#666666 8%,#474747 12%,#474747 12%,#474747 15%,#2c2c2c 22%,#000000 38%,#111111 60%,#2b2b2b 75%,#1c1c1c 91%,#131313 100%); /* Chrome10+,Safari5.1+ */
		background: -o-linear-gradient(top,  #4c4c4c 0%,#595959 3%,#666666 8%,#474747 12%,#474747 12%,#474747 15%,#2c2c2c 22%,#000000 38%,#111111 60%,#2b2b2b 75%,#1c1c1c 91%,#131313 100%); /* Opera 11.10+ */
		background: -ms-linear-gradient(top,  #4c4c4c 0%,#595959 3%,#666666 8%,#474747 12%,#474747 12%,#474747 15%,#2c2c2c 22%,#000000 38%,#111111 60%,#2b2b2b 75%,#1c1c1c 91%,#131313 100%); /* IE10+ */
		background: linear-gradient(to bottom,  #4c4c4c 0%,#595959 3%,#666666 8%,#474747 12%,#474747 12%,#474747 15%,#2c2c2c 22%,#000000 38%,#111111 60%,#2b2b2b 75%,#1c1c1c 91%,#131313 100%); /* W3C */
		filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#4c4c4c', endColorstr='#131313',GradientType=0 ); /* IE6-9 */;
		color:white;
		padding:10px;
		border-radius: 5px;
	}
	th{
		text-align:right;
	}
</style>
</head>
<body onLoad="loaded();initPage();" onunload="exitPage();">
	<div id="layout">
		<%@include file="../header.jsp"%>
		<article id="mainArticle">
			<div style="clear:both">
				<div style="float:left">
					<div>
						<img src="${thumnail.attachfile_src}" style="width:250px; height:250px;"/>
						<!-- <img src="http://placehold.it/250x250"> -->
					</div>
				</div>
				<div style="float: left">
					<table style="width:300px; height:250px;margin-left:20px;">
						<tr>
							<th>상품명</th>
							<td style="text-align:right;font-size:14pt;"><b>${article.article_title }</b></td>
						</tr>
						<tr>
							<th>현재가</th>
							<td style="text-align:right">
								<span id="startprice" style="color:red;font-weight:bold"><fmt:formatNumber value="${article.article_startprice}" type="CURRENCY" groupingUsed="true" /></span>
								<input type="hidden" id="hidden_startprice" value="${article.article_startprice}"/>
							</td>
						</tr>
						<tr>
							<th>마감일</th>
							<td style="text-align:right"><span style="font-weight:bold;"><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" value="${article.article_enddate}" /></span></td>
						</tr> 
						<tr>
							<th>남은시간</th>
							<td style="text-align:right"><span id="leftTime"></span></td>
						</tr>
						<tr>
							<td colspan="2"><button type="button" class="button red" onClick="insertBid(${article.article_id});">입찰하기</button>
						</tr>
						<tr>
							<th>소비자 가격</th>
							<td style="text-align:right;tex"><span id="marketprice" style="font-weight:bold"><fmt:formatNumber value="${article.article_marketprice}" type="CURRENCY" groupingUsed="true" /></span></td>
							<input type="hidden" id="hidden_marketprice" value="${article.article_marketprice}"/>
						</tr>
						<tr>
							<th>예상 이익</th>
							<td style="text-align:right"><span id="profit" style="font-weight:bold;">000000</span>원</td>
						</tr>
					</table>
				</div>
				<div style="width:400px;float:left;margin-left:20px;">
					<table class="tblHeader" width="100%" cellspacing="0" cellpadding="0">
						<tr>
							<td class="tdHeader" width="">권모술수</td>
							<td class="tdHeader" width="1%"><img id="simgStatus" src="${pageContext.request.contextPath}/resources/image/disconnected.png" align="right"/></td>
							<td class="tdHeader" width="1%"><span id="slblClientId">&nbsp;Client&#x2011;Id:&nbsp;-</span></td>
						</tr>
					</table>
					<div class="sdivContainer" style="display:none">
						<table class="stlbDlg" border="0" cellpadding="3" cellspacing="0" width="100%">
							<tr class="strDlg">
								<td class="stdDlg" width="5">Username</td>
								<td class="stdDlg" width="5">
									<input class="stxfDlg" id="stxfUsername" type="text" value="guest" style="width:150px"
										   title="jWebSocket username or 'Guest' for demo.">
								</td>
								<td class="stdDlg" width="5">
									<input class="sbtnDlg" id="sbtnLogon" type="button" value="Login" onclick="logon();"
										   title="Authenticates you against the jWebSocket Server.">
								</td>
								<td class="stdDlg" width="5">
									<input class="sbtnDlg" id="sbtnClear" type="button" value="Clear Log" onclick="clearLog();"
										   title="Clears the result and event log above.">
								</td>
								<td class="stdDlg" width="" align="right">
									<input id="schkKeepAlive" type="checkbox" value="off" onclick="checkKeepAlive();">&nbsp;Keep-Alive&nbsp;
									<input id="schkDebug" type="checkbox" value="on">&nbsp;Debug&nbsp;
									<input class="sbtnDlg" id="sbtnClearLog" type="button" value="Clear Log" onclick="clearLog();">
								</td>
							</tr>
			
							<tr>
								<td class="stdDlg" width="5">Password</td>
								<td class="stdDlg" width="5">
									<input class="spwfDlg" id="spwfPassword" type="password" value="guest" style="width:150px"
										   title="jWebSocket password or 'guest' for demo."></td>
								<td class="stdDlg" width="5">
									<input class="sbtnDlg" id="sbtnLogoff" type="button" value="Logout" onclick="logoff();"
										   title="Logs you out and disconnects from the jWebSocket server."></td>
								<td class="stdDlg" width="5">
									<input class="sbtnDlg" id="sbtnGetClients" type="button" value="Clients" onclick="getClients();"
										   title="Retrieve all clients that are currently connected to the chat."
										   ></td>
								<td class="stdDlg" width="">&nbsp;</td>
							</tr>
						</table>
					</div>
		<div id="sdivChat" class="sdivContainer" style="position:relative; height:300px; overflow:auto;text-align:left">
		</div>
		<div class="sdivContainer">
			<table class="stlbDlg" border="0" cellpadding="3" cellspacing="0" width="100%">
				<tr class="strDlg">
					<td valign="top" class="stdDlg" width="5">Message</td>
					<td valign="top" class="stdDlg" width="" style="padding-right:12pt"><textarea class="stxaDlg" id="stxaMsg" cols="255 "rows="2" style="width:100%" placeholder="Please type your message here!"></textarea></td>
					<td><input class="sbtnDlg" id="sbtnSend" type="button" value="Send" onclick="broadcast();" style="margin-left:6pt"></td>
				</tr>
			</table>
		</div>
		<div style="display:none">
			<input class="stxfDlg" id="stxfTarget" type="text" value="*" onclick="send();" size="0">
			<input class="sbtnDlg" id="sbtnSend" type="button" value="Send" onclick="broadcast();" style="margin-left:6pt">
		</div>
		</div>
			</div>
			<div style="clear:left;margin-top:280px;">
				<div style="text-align:left; font-size:15pt;"><b>상품<span style="color:red">소개</span> <small style="color:gray;font-size:10pt;">Product Info</small></b></div>
				<div>
					${article.article_content}
				</div>
			</div>
		</article>
		<%@ include file="../footer.html"%>
	</div>
</body>
</html>