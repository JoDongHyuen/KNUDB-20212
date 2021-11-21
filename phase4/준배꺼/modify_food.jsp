<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language = "java" import = "java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>점포 음식 수정</title>
</head>
<body>
<%
	String userId = session.getAttribute("userId").toString();
	int bnum = (int)session.getAttribute("bnum");
	session.setAttribute("userId", userId);
	session.setAttribute("bnum", bnum);

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
	
	String sql = "select price, food_name, id from food where bnum=?";
	PreparedStatement ps = conn.prepareStatement(sql);
	ps.setInt(1, bnum);
	ResultSet rs = ps.executeQuery();
	String[] f_name = new String[5], origin = new String[5];
	int[] f_price = new int[5], f_id = new int[5];
	int k=0, n=0;
	
	while(rs.next()){
		f_price[k]=rs.getInt(1);
		f_name[k]=rs.getString(2);
		f_id[k]=rs.getInt(3);
		k++;
	}
	
	for(int i=0; i<k; i++){
		sql = "select country_name from origin where id=?";
		ps = conn.prepareStatement(sql);
		ps.setInt(1, f_id[i]);
		rs = ps.executeQuery();
		
		while(rs.next())
			origin[i] = rs.getString(1);
	}
%>

	<table>
		<tr>
			<th></th>
			<th>음식</th>
			<th>가격</th>
			<th>원산지</th>
		</tr>	
		<% for(int j=0; j<k; j++) {%>
			<form method="post" id="updateOrDeleteFrm">			
				<tr>
					<td><input type="hidden" name="f_id" value="<%=f_id[j] %>"></td>
					<td><input type="text" name="f_name" value="<%=f_name[j] %>"></td>
					<td><input type="text" name="f_price" value="<%=f_price[j] %>"></td>
					<td><input type="text" name="origin" value="<%=origin[n] %>"></td>
					
					<td>
					<input type="submit" value="저장" formaction="update_food.jsp">
					<input type="submit" value="삭제" formaction="delete_food.jsp">
					</td>
				</tr>
			</form>
		<%n++;} %>
	</table>
	
	<input type="button" onclick="fnUserModify('insert_food.jsp');" value="추가하기">
	<input type="button" value="취소" onclick="priorPage();" />
	
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