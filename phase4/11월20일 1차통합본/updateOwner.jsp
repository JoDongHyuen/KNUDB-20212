<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language = "java" import = "java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� ���� ����</title>
</head>
<body>


<%
	String userId = session.getAttribute("userId").toString();
	String fname = session.getAttribute("fname").toString();
	String lname = session.getAttribute("lname").toString();
	String phone_number = session.getAttribute("phone_number").toString();
	String[] phone = phone_number.split("-");
	
	int age = (int)(session.getAttribute("age"));
	
	session.setAttribute("userId", userId);
%>

	<form method="post" action="updateOwner_ok.jsp">
		<table>
			<tr>
				<td>����: </td> 
				<td><input type="text" name="fname" placeholder="��" value="<%=fname%>"></td>
				<td><input type="text" name="lname" placeholder="�̸�" value="<%=lname%>"></td>
			</tr>
			<tr>
				<td>�޴��� ��ȣ: </td>
				<td><input type="text" name="phone1" value="<%= phone[0] %>"></td>
				<td><input type="text" name="phone2" value="<%= phone[1] %>"></td>
				<td><input type="text" name="phone3" value="<%= phone[2] %>"></td>
			 </tr>
			 
			<tr> 
				<td>����:</td>
				<td><input type="text" name="age" value="<%= age %>"></td>
	 		</tr>
	 		<tr>
				<td>��й�ȣ: </td>
				<td><input type="password" name="pw"></td>
			</tr>
			<tr>
				<td>��й�ȣ Ȯ��:</td>
				<td><input type="password" name="pw_ck"></td>
			</tr>
		</table>
		<input type="submit" value="����">
		<input type="button" value="���" onclick="history.back();" />
	</form>
</body>
</html>