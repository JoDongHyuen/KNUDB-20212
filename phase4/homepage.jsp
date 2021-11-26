<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>HomePage</title>
<link rel="stylesheet" href="css/homepage.css">
</head>
<body>
	<div id="header">
		<a href="homepage.html" class="logo">DataBase Term Project</a>
		<div class="logo-right">COMP322004</div>
	</div>
	<div id="body">
		<ul class="actions">
				<li><a href="Search_Query1.jsp" class="button alt"><b>Search</b></a></li>
		</ul>
		<div class="login-form">
		<% 
			session.setAttribute("DBID", "term");
			session.setAttribute("DBPW", "term");
			if(session.getAttribute("userType") == null) {
		%>
			<form action="login.jsp" method="post">
				<!-- 
@
<select id="email" name="email" size="1">
			<option value="">select</option>
			<option value="1">직접입력</option>
			<option value="nano">nano.com</option>
			<option value="naver">naver.com</option>
			<option value="daum">daum.net</option>
			<option value="google">gmail.com</option>
		</select>
-->
				<!--  1. id 입력받을 때 셀렉트 박스 구현하는 것
	
		
		이거 2개 나중에 시간 남으면 정교하게 짜도록 시도해보기.
 -->
				<input type="text" value="" name="id" class="text-field" placeholder="ID">
				<input type="password" value="" name="passWord" class="text-field" placeholder="PW">
				<input type="submit" value="Log In" class="btn">
				<button type="button" class="btn" value="signup" onClick="location.href='register.jsp'">Sign Up</button>
			</form>
		<% 
			} else if(session.getAttribute("userType").equals("customer")) {
		%>
		
		<div>
			<div class="welcome">
				어서오세요!<br>
				<%=session.getAttribute("fname") %><%=session.getAttribute("lname") %>님
			</div><br>
			<input type="button" class="btn" value="개인 정보 관리" onclick="location.href='updateCustomer.jsp'">
			<input type="button" class="btn" value="평점 매기기" onclick="location.href='customerRating.jsp'">
			<input type="button" class="btn" value="예약하기" onclick="location.href='reserveCustomer.jsp'">
			<input type="button" class="btn" value="Log Out" onclick="location.href='logout.jsp'">
		</div>
		
		<%
			} else if(session.getAttribute("userType").equals("owner")) {
		%>
		
		<div>
			<div class="welcome">
				어서오세요!<br>
				<%=session.getAttribute("fname") %><%=session.getAttribute("lname") %>님
			</div><br>
			<input type="button" class="btn" value="개인 정보 관리" onclick="location.href='updateOwner.jsp'">
			<input type="button" class="btn" value="점포 정보" onclick="location.href='StoreState.jsp'">
			<input type="button" class="btn" value="예약 관리" onclick="location.href='reserveOwner.jsp'">
			<input type="button" class="btn" value="Log Out" onclick="location.href='logout.jsp'">
		</div>
		
		<% 
			} else if(session.getAttribute("userType").equals("admin"))
				response.sendRedirect("AdminCustomer.jsp");
		%>
	
		</div>
	</div>
	<div id="info1">Query Result1</div>
		<div id="info2">Query Result2</div>
		<div id="info3">Query Result3</div>
	<div id="footer">
		<a href='https://kr.freepik.com/vectors/city'>City 벡터는 upklyak - kr.freepik.com가 제작함</a>
	</div>
</body>
</html>