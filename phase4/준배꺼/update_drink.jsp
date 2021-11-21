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
	
	int d_price=Integer.parseInt(request.getParameter("d_price"));
	int d_id=Integer.parseInt(request.getParameter("d_id"));
	String d_name = new String(request.getParameter("d_name").getBytes("8859_1"),"KSC5601");
	String alcohol = new String(request.getParameter("alcohol").getBytes("8859_1"),"KSC5601");
	
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

	String sql = "update beverage set price = ?, drink_name = ?, alcohol = ? where id = ?";
	PreparedStatement ps = conn.prepareStatement(sql);
	ps.setInt(1, d_price);
	ps.setString(2, d_name);
	ps.setString(3, alcohol);
	ps.setInt(4, d_id);
	int res = ps.executeUpdate();
	
	response.sendRedirect("modify_drink.jsp");
%>

</body>
</html>