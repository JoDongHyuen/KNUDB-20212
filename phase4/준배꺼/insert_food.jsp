<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language = "java" import = "java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	String userId = session.getAttribute("userId").toString();
	int bnum = (int)session.getAttribute("bnum");
	session.setAttribute("userId", userId);
	session.setAttribute("bnum", bnum);
%>

<form method="post" action="insert_food_ok.jsp">
	<table>
		<tr>
			<td>���� �̸�</td>
			<td><input type="text" name="f_name" placeholder="���� �̸�">
		</tr>
		<tr>
			<td>����</td>
			<td><input type="text" name="f_price" placeholder="����">
		</tr>
		<tr>
			<td>������</td>
			<td><input type="text" name="origin" placeholder="������">
		</tr>
	</table>
	<input type="submit" value="����">
	<input type="button" value="���" onclick="history.back();" />
</form>

</body>
</html>