<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language = "java" import = "java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�� ���� ����</title>
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
	
	sql = "select price, food_name from food where bnum=?";
	ps = conn.prepareStatement(sql);
	ps.setInt(1, bnum);
	rs = ps.executeQuery();
	String[] f_name = new String[5];
	int[] f_price = new int[5];
	int i=0;
	
	while(rs.next()){
		f_price[i]=rs.getInt(1);
		f_name[i]=rs.getString(2);
		i++;
	}
	
	sql = "select price, drink_name, alcohol from beverage where bnum=?";
	ps = conn.prepareStatement(sql);
	ps.setInt(1, bnum);
	rs = ps.executeQuery();
	String[] d_name = new String[5], alcohol = new String[5];
	int[] d_price = new int[5];
	
	while(rs.next()){
		f_price[i]=rs.getInt(1);
		f_name[i]=rs.getString(2);
		alcohol[i]=rs.getString(3);
		i++;
	}
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