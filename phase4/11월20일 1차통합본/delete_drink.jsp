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
	String serverIP = "localhost";
	String strSID = "orcl";
	String portNum = "1521";
	String user = "term";
	String pass = "term";
	String url = "jdbc:oracle:thin:@" + serverIP + ":"
	+ portNum + ":" + strSID;
	
	Connection conn = null;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	Statement stmt = conn.createStatement();
	
	int d_id = Integer.parseInt(request.getParameter("d_id"));
	String sql="delete beverage food where id = ?";
	PreparedStatement ps = conn.prepareStatement(sql);
	ps.setInt(1, d_id);
	int rs = ps.executeUpdate();
	
	ps.close();
	conn.close();
	
	response.sendRedirect("modify_drink.jsp");
%>

</body>
</html>