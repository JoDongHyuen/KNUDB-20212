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
				<li><a href="Query.jsp" class="button alt"><b>Search</b></a></li>
		</ul>
		<div class="login-form">
		<% 
			if(session.getAttribute("userType") == null) {
		%>
			<form action="login.jsp" method="post">
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
			<% 
			String fname = String.valueOf(session.getAttribute("fname"));
			//out.println(fname);
			String lname = String.valueOf(session.getAttribute("lname"));
			String userId = String.valueOf(session.getAttribute("id")); // 추가사항 -- 11월 23일
			session.setAttribute("fname", fname);
			session.setAttribute("lname", lname);
			session.setAttribute("id", userId);
			%>
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
			<input type="button" class="btn" value="점포 정보" onclick="location.href='OwnerFunc.jsp'">
			<input type="button" class="btn" value="예약 관리" onclick="location.href='reserveOwner.jsp'">
			<input type="button" class="btn" value="Log Out" onclick="location.href='logout.jsp'">
		</div>
		
		<% 
			} else if(session.getAttribute("userType").equals("admin"))
				response.sendRedirect("AdminFunc.jsp");
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