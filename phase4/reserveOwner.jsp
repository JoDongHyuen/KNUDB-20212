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
<h2>���ִ��� �������� ������ ������� ����Դϴ�.</h2>
<table class="type11">
<%
	String serverIP = "localhost";
	String strSID = "orcl";
	String portNum = "1521";
	String user = (String)session.getAttribute("DBID");
	String pass = (String)session.getAttribute("DBPW");
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
	//�ϴ� Bnum �� ������
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

	out.println("<thead> <tr> <th scope=\"cols\"> �� </th>  <th scope=\"cols\">  �̸� </th>  <th scope=\"cols\">  ���� </th> <th scope=\"cols\">  ���� </th> <th scope=\"cols\"> " 
	+ "���� �ð� </th> </tr> </thead>");
  	while (rs.next()) {
  		out.println("<tr>");
		out.println("<td>" + rs.getString(1) + "</td>");
		out.println("<td>" + rs.getString(2) + "</td>");
		String ss = rs.getString(3);
		if(ss.equals(" male"))
			out.println("<td> ���� </td>");
		else
			out.println("<td> ���� </td>");
		//out.println("<td>" + rs.getString(3) + "</td>");
		out.println("<td>" + rs.getString(4) + "</td>");
		out.println("<td>" + rs.getString(5) + "</td>");
		out.println("</tr>");
  	}
	out.println("</table>");

	rs.close();
	stmt.close();
	conn.close();
%>
<br/><br/><br/>
<br/><br/><br/> https://nanati.me/html_css_table_design/ ���� ǥ ������ ������
</center>
</body>
</html>