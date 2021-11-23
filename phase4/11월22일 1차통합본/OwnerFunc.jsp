<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language = "java" import = "java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� ����</title>
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
	String user = (String)session.getAttribute("DBID");
	String pass = (String)session.getAttribute("DBPW");
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
	
	rs.close();
	stmt.close();
	conn.close();

%>
	<form method="post" action="updateOwner_ok.jsp" id="frm">
		<table>
			<tr>
				<td>���� ��: </td>
				<td><input type="text" name="store_name" value="<%=store_name %>"></td>
			</tr>
			
			<tr>
				<td>���� Ÿ��: </td>
				<td>
					<select name="store_type">
						<option value="general" selected>�Ϲ�������</option>
						<option value="rest">�ް�������</option>
						<option value="bread">����������</option>
					</select>
				</td>
			</tr>
			
			<tr>
				<td>�¼� ��: </td>
				<td><input type="text" name="seat_number" value="<%=seat_number %>"></td>
			</tr> 
			
			<tr>
				<td>�ּ�: </td>
				<td><input type="text" name="location" value="<%=location %>"></td>
			</tr> 

		</table>
		<input type="submit" value="����" onclick="password_check">
		<input type="button" value="���" onclick="priorPage();" />
	</form>
	
	<input type="button" onclick="location.href='modify_food.jsp'" value="���� ����">
	<input type="button" onclick="location.href='modify_drink.jsp'" value="���� ����">
</body>

<script>	
	function priorPage(){
			var frm = document.getElementById("frm");
			frm.action = 'homepage.jsp';
			frm.submit();
	}
</script>
</html>