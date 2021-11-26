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
<title>Insert title here</title>
<link rel="stylesheet" href="css/custom.css">
</head>
<body>
<center>
	<h1>회 원 가 입</h1>
	<form action = "registerCheck.jsp" method = "post">
		<table border = "1" width = "600" height = "150" bgcolor = 95f3c7>
			<tr>
				<td> 고객 / 점주 </td>
				<td><input type = "radio" name = "typeOfP" value = "customer" checked="checked" /> 고객
					<input type = "radio" name = "typeOfP" value = "owner"/> 점주 </td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type = "text" name = "fullName"/></td>
			</tr>
			<tr>
				<td>나이</td>
				<td><input type = "text" name = "age"/></td>
			</tr>
			<tr>
				<td> 성별 </td>
				<td><input type = "radio" name = "gender" value = "male" checked="checked" /> 남
					<input type = "radio" name = "gender" value = "female"/> 여 </td>
			</tr>
			<tr>
				<td> 전화번호(dash 포함) </td>
				<td><input type = "text" name = "phone"/></td>
			</tr>
			<tr>
				<td>이메일</td>
				
				<td><input type = "text" name = "email"/>

				<!--				
				 <input type = "button"
				value = "중복확인" onClick = "location.href = 'regEmailCheck.jsp'"/></td>
				 -->
			
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type = "password" name = "passWord"/></td>
			</tr>
			<tr>
				<td>비밀번호 확인</td>
				<td><input type = "password" name = "passWord2"/></td>
			</tr>
			
		</table>
		<!--  <input type = "submit"
				value = "제출" >
		-->
		<button type = "submit" class="snip1535"> submit </button>
		<button type = "button" class="snip1535" onClick="location.href='homepage.jsp'"> 뒤로가기 </button>
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
		<!-- <span style="color:red">이메일이 중복됩니다!!</span>
	-->
	
		<%
		//}
		%>
		<br/><br/><br/> https://nanati.me/html_css_table_design/ 에서 검색 디자인 가져옴
	</form>


</center>


</body>
</html>