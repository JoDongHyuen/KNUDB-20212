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
			<td>음식 이름</td>
			<td><input type="text" name="f_name" placeholder="음식 이름">
		</tr>
		<tr>
			<td>가격</td>
			<td><input type="text" name="f_price" placeholder="가격">
		</tr>
		<tr>
			<td>원산지</td>
			<td><input type="text" name="origin" placeholder="원산지">
		</tr>
	</table>
	<input type="submit" value="저장">
	<input type="button" value="취소" onclick="history.back();" />
</form>

</body>
</html>