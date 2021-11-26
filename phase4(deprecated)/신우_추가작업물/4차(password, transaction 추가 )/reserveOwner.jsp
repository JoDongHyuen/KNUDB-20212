<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language = "java" import = "java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<style type = "text/css">
body{
background-color: #fff4e8;
}
</style>
<link rel="stylesheet" href="css/custom.css">
<title>Insert title here</title>
</head>
<body>
<center>
<h2>점주님의 음식점을 예약한 사람들의 목록입니다.</h2>
<table class="type11">
<%
	String serverIP = "localhost";
	String strSID = "orcl";
	String portNum = "1521";
	String user = "restaurant";
	String pass = "restaurant";
	String url = "jdbc:oracle:thin:@" + serverIP + ":"
	+ portNum + ":" + strSID;
	
	String userId = String.valueOf(session.getAttribute("userId"));
	Connection conn = null;
	PreparedStatement pstmt;
	Statement stmt;
	ResultSet rs;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);

	//String search = String.valueOf(session.getAttribute("search"));
	//String search = new String(request.getParameter("search").getBytes("8859_1"), "EUC-KR");
	
	userId = " " + userId;
	String query = "";
	//일단 Bnum 을 구하자
	query = "select Bnum from store, owner where Bnum = Breg_number"
			+ " and Owner_email = '" + userId + "'";
	int Bnum = 0;
	stmt = conn.createStatement();
	rs = stmt.executeQuery(query);
	if(rs.next())
		Bnum = rs.getInt(1); 
	
	query = "select C.Fname, C.Lname, C.sex, C.age, TO_CHAR(B.Time, 'YYYY-MM-DD HH24:MI:SS') "
			+ "from cust_books_str B, customer C, owner O "
			+ "where customer_email = B.cemail "
			+ "and O.Bnum = B.Bnum "
			+ "and O.Bnum = " + Bnum;
	rs = stmt.executeQuery(query);

	out.println("<thead> <tr> <th scope=\"cols\"> 성 </th>  <th scope=\"cols\">  이름 </th>  <th scope=\"cols\">  성별 </th> <th scope=\"cols\">  나이 </th> <th scope=\"cols\"> " 
	+ "예약 시간 </th> </tr> </thead>");
  	while (rs.next()) {
  		out.println("<tr>");
		out.println("<td>" + rs.getString(1) + "</td>");
		out.println("<td>" + rs.getString(2) + "</td>");
		String ss = rs.getString(3);
		if(ss.equals(" male"))
			out.println("<td> 남자 </td>");
		else
			out.println("<td> 여자 </td>");
		//out.println("<td>" + rs.getString(3) + "</td>");
		out.println("<td>" + rs.getString(4) + "</td>");
		out.println("<td>" + rs.getString(5) + "</td>");
		out.println("</tr>");
  	}
	out.println("</table>");

	
	stmt.close();
	conn.close();
%>
<br/><br/><br/>
<br/><br/><br/> https://nanati.me/html_css_table_design/ 에서 표 디자인 가져옴
</center>
</body>
</html>