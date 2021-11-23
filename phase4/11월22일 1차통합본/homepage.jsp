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
			session.setAttribute("DBID", "term");
			session.setAttribute("DBPW", "term");
			if(session.getAttribute("userType") == null) {
		%>
			<form action="login.jsp" method="post">
				<!-- 
@
<select id="email" name="email" size="1">
			<option value="">select</option>
			<option value="1">�����Է�</option>
			<option value="nano">nano.com</option>
			<option value="naver">naver.com</option>
			<option value="daum">daum.net</option>
			<option value="google">gmail.com</option>
		</select>
-->
				<!--  1. id �Է¹��� �� ����Ʈ �ڽ� �����ϴ� ��
	
		
		�̰� 2�� ���߿� �ð� ������ �����ϰ� ¥���� �õ��غ���.
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
				�������!<br>
				<%=session.getAttribute("fname") %><%=session.getAttribute("lname") %>��
			</div><br>
			<input type="button" class="btn" value="���� ���� ����" onclick="location.href='updateCustomer.jsp'">
			<input type="button" class="btn" value="�����ϱ�" onclick="location.href='reserveCustomer.jsp'">
			<input type="button" class="btn" value="���ϱ�" onclick="location.href='reserveCustomer.jsp'">
			<input type="button" class="btn" value="Log Out" onclick="location.href='logout.jsp'">
		</div>
		
		<%
			} else if(session.getAttribute("userType").equals("owner")) {
		%>
		
		<div>
			<div class="welcome">
				�������!<br>
				<%=session.getAttribute("fname") %><%=session.getAttribute("lname") %>��
			</div><br>
			<input type="button" class="btn" value="���� ���� ����" onclick="location.href='updateOwner.jsp'">
			<input type="button" class="btn" value="���� ����" onclick="location.href='OwnerFunc.jsp'">
			<input type="button" class="btn" value="���� ����" onclick="location.href='reserveOwner.jsp'">
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
		<a href='https://kr.freepik.com/vectors/city'>City ���ʹ� upklyak - kr.freepik.com�� ������</a>
	</div>
</body>
</html>