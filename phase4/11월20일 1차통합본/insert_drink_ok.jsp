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
	String d_name = new String(request.getParameter("d_name").getBytes("8859_1"),"KSC5601");  
	String alcohol = new String(request.getParameter("alcohol").getBytes("8859_1"),"KSC5601");  
	
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
	
	int d_id=0, origin_id=0;
	String sql = "select count(*) from beverage";
	ResultSet rs = stmt.executeQuery(sql);
	if(rs.next()){
		d_id = rs.getInt(1) + 1;
	}
	
	sql = "insert into beverage values(?, ?, ?, ?, ?)";
	PreparedStatement ps = conn.prepareStatement(sql);
	ps.setInt(1, bnum);
	ps.setInt(2, d_id);
	ps.setString(3, alcohol);
	ps.setString(4, d_name);
	ps.setInt(5, d_price);
	ps.executeUpdate();

	response.sendRedirect("modify_drink.jsp");
%>
<%=bnum %>
<%=d_id %>
<%=d_price %>
<%=d_name %>
<%=alcohol %>
</body>
</html>