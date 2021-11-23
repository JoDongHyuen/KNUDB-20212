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
				�������!<br>
				<%=session.getAttribute("fname") %><%=session.getAttribute("lname") %>��
			</div><br>
			<input type="button" class="btn" value="���� ���� ����" onclick="location.href='updateCustomer.jsp'">
			<% 
			String fname = String.valueOf(session.getAttribute("fname"));
			//out.println(fname);
			String lname = String.valueOf(session.getAttribute("lname"));
			String userId = String.valueOf(session.getAttribute("id")); // �߰����� -- 11�� 23��
			session.setAttribute("fname", fname);
			session.setAttribute("lname", lname);
			session.setAttribute("id", userId);
			//�ؿ����� �ع����Բ�
			session.setAttribute("userId",  
						session.getAttribute("userId"));
			session.setAttribute("phone_number",  
					session.getAttribute("phone_number"));
			session.setAttribute("age",  
					session.getAttribute("age"));
			%>
			<input type="button" class="btn" value="���� �ű��" onclick="location.href='customerRating.jsp'">
			<input type="button" class="btn" value="�����ϱ�" onclick="location.href='reserveCustomer.jsp'">
			<input type="button" class="btn" value="Log Out" onclick="location.href='logout.jsp'">
		</div>
		
		<%
			} else if(session.getAttribute("userType").equals("owner")) {
				//�ع����� �ڵ� �߰�
				session.setAttribute("userId",  
						session.getAttribute("userId"));
				session.setAttribute("fname",  
						session.getAttribute("fname"));
				session.setAttribute("lname",  
						session.getAttribute("lname"));
				session.setAttribute("phone_number",  
						session.getAttribute("phone_number"));
				session.setAttribute("age",  
						session.getAttribute("age"));
				session.setAttribute("bnum",  
						session.getAttribute("bnum"));
				
				
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
				response.sendRedirect("AdminFunc.jsp");
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