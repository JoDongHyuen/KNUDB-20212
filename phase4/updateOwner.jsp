<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<style type = "text/css">
body{
	background-color: #f7fff8;
}
</style>
<meta charset="EUC-KR">
<title>���� ���� ����</title>
<link rel="stylesheet" href="css/custom.css">
</head>

<%
	String userId = session.getAttribute("userId").toString();
	String fname = session.getAttribute("fname").toString();
	String lname = session.getAttribute("lname").toString();
	String phone_number = session.getAttribute("phone_number").toString();
	
	int age = (int)(session.getAttribute("age"));
	
	session.setAttribute("userId", userId);
%>

<body>

	<div style="text-align:center;">
		<h1>���� ���� ����</h1>
		<form method="post" action="updateOwner_ok.jsp">
			<table border = "1" style="width:600px; height=150px; background-color:#95f3c7;">
				<tr>
					<td>�̸�</td> 
					<td><input type="text" name="name" placeholder="�̸�" value="<%=fname%><%=lname%>"></td>
				</tr>
				<tr>
					<td>�޴��� ��ȣ(dash ����) </td>
					<td><input type = "text" name = "phone" placeholder="dash ����" value="<%=phone_number%>"/></td>
				</tr> 
				<tr> 
					<td>����</td>
					<td><input type="text" name="age" value="<%= age %>"></td>
		 		</tr>
		 		<tr>
					<td>��й�ȣ</td>
					<td><input type="password" name="pw"></td>
				</tr>
				<tr>
					<td>��й�ȣ Ȯ��</td>
					<td><input type="password" name="pw_ck"></td>
				</tr>
			</table>
			<input type="submit" value="����" class="snip1535">
			<input type="button" value="���" onclick="history.back();" class="snip1535"/>
		</form>
	<br><br><br>
	
		<br/><br/> https://nanati.me/html_css_table_design/ ���� �˻� ������ ������	
	</div>
</body>
</html>