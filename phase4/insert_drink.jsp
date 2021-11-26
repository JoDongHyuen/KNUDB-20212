<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language = "java" import = "java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>점포 음료 추가</title>
</head>
<body>
<%
	String userId = session.getAttribute("userId").toString();
	int bnum = (int)session.getAttribute("bnum");
	session.setAttribute("userId", userId);
	session.setAttribute("bnum", bnum);
%>

<form method="post" action="insert_drink_ok.jsp">
	<table>
		<tr>
			<td>음료 이름</td>
			<td><input type="text" name="d_name" placeholder="음료 이름">
		</tr>
		<tr>
			<td>가격</td>
			<td><input type="text" name="d_price" placeholder="가격">
		</tr>
		<tr>
			<td>술 여부</td>
			<td><input type="radio" name="alcohol" value="Y">Y
			<td><input type="radio" name="alcohol" value="N">N
		</tr>
	</table>
	<input type="submit" value="저장">
	<input type="button" value="취소" onclick="history.back();" />
</form>

</body>
</html>