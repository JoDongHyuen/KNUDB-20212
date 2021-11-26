<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language = "java" import = "java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>점포 음료 수정</title>
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
	
	String sql = "select price, drink_name, alcohol, id from beverage where bnum=?";
	PreparedStatement ps = conn.prepareStatement(sql);
	ps.setInt(1, bnum);
	ResultSet rs = ps.executeQuery();
	String[] d_name = new String[5], alcohol = new String[5];
	int[] d_price = new int[5], d_id = new int[5];
	int i=0;
	
	while(rs.next()){
		d_price[i]=rs.getInt(1);
		d_name[i]=rs.getString(2);
		alcohol[i]=rs.getString(3);
		d_id[i]=rs.getInt(4);
		
		i++;
	}
%>
	<table>
		<tr>
			<th></th>	
			<th>음료</th>
			<th>가격</th>
			<th>주류 여부(Y or N)</th>
		</tr>
		<% for(int j=0; j<i; j++) {
			if(d_price[j] != 0) { %>
				<form method="post" id="updateOrDeleteFrm">
					<tr>
						<td><input type="hidden" name="d_id" value="<%=d_id[j] %>"></td>
						<td><input type="text" name="d_name" value="<%=d_name[j] %>"></td>
						<td><input type="text" name="d_price" value="<%=d_price[j] %>"></td>
						<td><input type="text" name="alcohol" value="<%=alcohol[j] %>"></td>
						<td>
							<input type="submit" formaction="update_drink.jsp" value="저장">
							<input type="submit" formaction="delete_drink.jsp" value="삭제">
						</td>
					</tr>
				</form>
		<%}} %>
	</table>
	<input type="button" onclick="location.href='insert_drink.jsp'" value="추가하기">
	<input type="button" value="취소" onclick="location.href='OwnerFunc.jsp'" />
	
	<script type="text/javascript">
	function fnUserModify(pageUrl) { 
		var frm = document.getElementById("updateOrDeleteFrm"); 
		frm.action = pageUrl;
		frm.submit(); 
	} 
	function priorPage(){
		var frm = document.getElementById("updateOrDeleteFrm");
		frm.action = 'OwnerFunc.jsp';
		frm.submit();
	}
	</script>
</body>
</html>