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
<title>점주 정보 수정</title>
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
		<h1>점주 정보 수정</h1>
		<form method="post" action="updateOwner_ok.jsp">
			<table border = "1" style="width:600px; height=150px; background-color:#95f3c7;">
				<tr>
					<td>이름</td> 
					<td><input type="text" name="name" placeholder="이름" value="<%=fname%><%=lname%>"></td>
				</tr>
				<tr>
					<td>휴대폰 번호(dash 포함) </td>
					<td><input type = "text" name = "phone" placeholder="dash 포함" value="<%=phone_number%>"/></td>
				</tr> 
				<tr> 
					<td>나이</td>
					<td><input type="text" name="age" value="<%= age %>"></td>
		 		</tr>
		 		<tr>
					<td>비밀번호</td>
					<td><input type="password" name="pw"></td>
				</tr>
				<tr>
					<td>비밀번호 확인</td>
					<td><input type="password" name="pw_ck"></td>
				</tr>
			</table>
			<input type="submit" value="수정" class="snip1535">
			<input type="button" value="취소" onclick="history.back();" class="snip1535"/>
		</form>
	<br><br><br>
	
		<br/><br/> https://nanati.me/html_css_table_design/ 에서 검색 디자인 가져옴	
	</div>
</body>
</html>