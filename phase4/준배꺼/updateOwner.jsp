<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language = "java" import = "java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>점주 정보 수정</title>
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
				<td>성명: </td> 
				<td><input type="text" name="fname" placeholder="성" value="<%=fname%>"></td>
				<td><input type="text" name="lname" placeholder="이름" value="<%=lname%>"></td>
			</tr>
			<tr>
				<td>휴대폰 번호: </td>
				<td><input type="text" name="phone1" value="<%= phone[0] %>"></td>
				<td><input type="text" name="phone2" value="<%= phone[1] %>"></td>
				<td><input type="text" name="phone3" value="<%= phone[2] %>"></td>
			 </tr>
			 
			<tr> 
				<td>나이:</td>
				<td><input type="text" name="age" value="<%= age %>"></td>
	 		</tr>
	 		<tr>
				<td>비밀번호: </td>
				<td><input type="password" name="pw"></td>
			</tr>
			<tr>
				<td>비밀번호 확인:</td>
				<td><input type="password" name="pw_ck"></td>
			</tr>
		</table>
		<input type="submit" value="수정">
		<input type="button" value="취소" onclick="history.back();" />
	</form>
</body>
</html>