<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language = "java" import = "java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>점포 음식 추가</title>
</head>
<body>
<%
	String userId = session.getAttribute("userId").toString();
	int bnum = (int)session.getAttribute("bnum");
	session.setAttribute("userId", userId);
	session.setAttribute("bnum", bnum);
	
	int f_price=Integer.parseInt(request.getParameter("f_price"));
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
	
	int f_id=0, origin_id=0;
	String sql = "select count(*) from food";
	ResultSet rs = stmt.executeQuery(sql);
	if(rs.next()){
		f_id = rs.getInt(1) + 1;
	}
	
	sql = "insert into food values(?, ?, ?, ?)";
	PreparedStatement ps = conn.prepareStatement(sql);
	ps.setInt(1, bnum);
	ps.setInt(2, f_id);
	ps.setInt(3, f_price);
	ps.setString(4, f_name);
	ps.executeUpdate();
	
	sql = "insert into origin values(?, ?)";
	ps = conn.prepareStatement(sql);
	ps.setInt(1, f_id);
	ps.setString(2, origin);
	ps.executeUpdate();
	
	response.sendRedirect("StoreState.jsp");
%>
</body>
</html>