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
	String userId = session.getAttribute("userId").toString();
	int bnum = (int)session.getAttribute("bnum");
	session.setAttribute("userId", userId);
	session.setAttribute("bnum", bnum);
	
	int f_price=Integer.parseInt(request.getParameter("f_price"));
	int f_id=Integer.parseInt(request.getParameter("f_id"));
	String f_name = new String(request.getParameter("f_name").getBytes("8859_1"),"KSC5601");   
	String origin = new String(request.getParameter("origin").getBytes("8859_1"),"KSC5601");   
	
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

	String sql = "update food set price = ?, food_name = ? where id = ?";
	PreparedStatement ps = conn.prepareStatement(sql);
	ps.setInt(1, f_price);
	ps.setString(2, f_name);
	ps.setInt(3, f_id);
	ps.executeUpdate();
	
	sql = "update origin set country_name = ? where id = ?";
	ps = conn.prepareStatement(sql);
	ps.setString(1, origin);
	ps.setInt(2, f_id);
	ps.executeUpdate();

	response.sendRedirect("modify_food.jsp");
%>
</body>
</html>