<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language = "java" import = "java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>점포 수정</title>
</head>
<body>


<%
	String userId = session.getAttribute("userId").toString();
	int bnum = (int)session.getAttribute("bnum");
	session.setAttribute("userId", userId);
	session.setAttribute("bnum", bnum);
	
	session.setAttribute("userId", userId);
	String serverIP = "localhost";
	String strSID = "orcl";
	String portNum = "1521";
	String user = "restaurant";
	String pass = "restaurant";
	String url = "jdbc:oracle:thin:@" + serverIP + ":"
	+ portNum + ":" + strSID;
	
	Connection conn = null;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	Statement stmt = conn.createStatement();
	
	String sql="select * from store where breg_number = ?";
	PreparedStatement ps = conn.prepareStatement(sql);
	ps.setInt(1, bnum);
	ResultSet rs = ps.executeQuery();
	
	String store_name=null, store_type=null, location=null;
	int k,seat_number=0, flag=0;
	
	while(rs.next()){
		k = rs.getInt(1);
		store_name = rs.getString(2);
		store_type = rs.getString(3);
		seat_number = rs.getInt(4);
		location = rs.getString(5);
	}

%>
	<form method="post" action="updateOwner_ok.jsp" id="frm">
		<table>
			<tr>
				<td>가게 명: </td>
				<td><input type="text" name="store_name" value="<%=store_name %>"></td>
			</tr>
			
			<tr>
				<td>가게 타입: </td>
				<td>
					<select name="store_type">
						<option value="general" selected>일반음식점</option>
						<option value="rest">휴게음식점</option>
						<option value="bread">제과점영업</option>
					</select>
				</td>
			</tr>
			
			<tr>
				<td>좌석 수: </td>
				<td><input type="text" name="seat_number" value="<%=seat_number %>"></td>
			</tr> 
			
			<tr>
				<td>주소: </td>
				<td><input type="text" name="location" value="<%=location %>"></td>
			</tr> 

		</table>
		<input type="submit" value="수정" onclick="password_check">
		<input type="button" value="취소" onclick="priorPage();" />
	</form>
	
	<input type="button" onclick="location.href='modify_food.jsp'" value="음식 수정">
	<input type="button" onclick="location.href='modify_drink.jsp'" value="음료 수정">
</body>

<script>	
	function priorPage(){
			var frm = document.getElementById("frm");
			frm.action = 'homepage.jsp';
			frm.submit();
	}
</script>
</html>