<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="css/custom.css">
</head>
<body>
<center>
	<h1>ȸ �� �� ��</h1>
	<form action = "registerCheck.jsp" method = "post">
		<table border = "1" width = "600" height = "150" bgcolor = 95f3c7>
			<tr>
				<td> �� / ���� </td>
				<td><input type = "radio" name = "typeOfP" value = "customer" checked="checked" /> ��
					<input type = "radio" name = "typeOfP" value = "owner"/> ���� </td>
			</tr>
			<tr>
				<td>�̸�</td>
				<td><input type = "text" name = "fullName"/></td>
			</tr>
			<tr>
				<td>����</td>
				<td><input type = "text" name = "age"/></td>
			</tr>
			<tr>
				<td> ���� </td>
				<td><input type = "radio" name = "gender" value = "male" checked="checked" /> ��
					<input type = "radio" name = "gender" value = "female"/> �� </td>
			</tr>
			<tr>
				<td> ��ȭ��ȣ(dash ����) </td>
				<td><input type = "text" name = "phone"/></td>
			</tr>
			<tr>
				<td>�̸���</td>
				
				<td><input type = "text" name = "email"/>

				<!--				
				 <input type = "button"
				value = "�ߺ�Ȯ��" onClick = "location.href = 'regEmailCheck.jsp'"/></td>
				 -->
			
			</tr>
			<tr>
				<td>��й�ȣ</td>
				<td><input type = "text" name = "passWord"/></td>
			</tr>
			<tr>
				<td>��й�ȣ Ȯ��</td>
				<td><input type = "text" name = "passWord2"/></td>
			</tr>
			
		</table>
		<!--  <input type = "submit"
				value = "����" >
		-->
		<button type = "submit" class="snip1535"> submit </button>
		<br/>
		<br/>
		<br/>
		<%
		//String flag = (String)session.getAttribute("flag");
		//int f = -123;
		//if(flag != null)
		//	f = Integer.parseInt(flag);
		//if(f == 1){
		%>
		<!-- <span style="color:red">�̸����� �ߺ��˴ϴ�!!</span>
	-->
	
		<%
		//}
		%>
	</form>


</center>


</body>
</html>