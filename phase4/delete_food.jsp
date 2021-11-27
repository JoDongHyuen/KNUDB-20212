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

	String f_name = new String(request.getParameter("f_name").getBytes("8859_1"),"KSC5601");   
	String origin = new String(request.getParameter("origin").getBytes("8859_1"),"KSC5601"); 

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
	
	int f_id = Integer.parseInt(request.getParameter("f_id"));
	String sql="delete from food where id = ?";
	PreparedStatement ps = conn.prepareStatement(sql);
	ps.setInt(1, f_id);
	int rs = ps.executeUpdate();
	
	ps.close();
	conn.close();
	
	response.sendRedirect("StoreState.jsp");
%>
</body>
</html>