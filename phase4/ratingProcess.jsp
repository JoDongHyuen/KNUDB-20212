<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language = "java" import = "java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="css/custom.css">
<title>Insert title here</title>
</head>
<body>

<%
	String id = String.valueOf(session.getAttribute("userId"));
	String r = String.valueOf(request.getParameter("rating"));
	String str = new String(request.getParameter("rst").getBytes("8859_1"), "EUC-KR");
	int Bnum = 0;
	double rating = Double.parseDouble(r);
	int a = 0;
	int ratingId = -1;
	
	String serverIP = "localhost";
	String strSID = "orcl";
	String portNum = "1521";
	String user = (String)session.getAttribute("DBID");
	String pass = (String)session.getAttribute("DBPW");
	String url = "jdbc:oracle:thin:@" + serverIP + ":"
	+ portNum + ":" + strSID;
	
	Connection conn = null;
	PreparedStatement pstmt;
	Statement stmt;
	ResultSet rs;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	
	stmt = conn.createStatement();
	// rating id 를 구하기 위한 작업
	String query = "select id from rating";
	rs = stmt.executeQuery(query);
	while(rs.next())
		ratingId = rs.getInt(1);
	ratingId++;
	
	query = "select Breg_number from store where store_name = '" + str + "'";
	rs = stmt.executeQuery(query);
	if(rs.next())
		Bnum = rs.getInt(1);
	id = " " + id; // 공백처리
	query = "insert into rating values(" + Bnum + ", '" +  id + "', " + rating + ", " + ratingId + ")";
	
	//System.out.println(query);
	int res = stmt.executeUpdate(query);
	
	//pstmt = conn.prepareStatement(query);
	
	//rs = pstmt.executeUpdate();
	out.println("<script type='text/javascript'>");
	out.println("alert('평점 평가 완료!!');");
	//out.println("history.back();");
	out.println("</script>");
	out.println("alert('평점 평가 완료!!');");
	response.sendRedirect("customerRating.jsp");
	
	
%>


</body>
</html>