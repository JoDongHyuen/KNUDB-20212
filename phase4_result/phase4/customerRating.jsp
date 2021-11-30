<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ page language = "java" import = "java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<style type = "text/css">
body{
background-color: #F8FFE0;
}
</style>
<meta charset="EUC-KR">
<link rel="stylesheet" href="css/custom.css">
<title>Insert title here</title>
</head>
<body>
 <form action="searchRatingRestaurant.jsp" method="post"> 

<div align="center">
<h1> 평점 매기기</h1>
	<br/>
	<h2> 내가 쓴 평점들</h2>
	<table class="type11">
	<%
	String serverIP = "localhost";
  	String strSID = "orcl";
  	String portNum = "1521";
  	String user = (String)session.getAttribute("DBID");
	String pass = (String)session.getAttribute("DBPW");
  	String url = "jdbc:oracle:thin:@" + serverIP + ":"
  	+ portNum + ":" + strSID;
  	
  	Connection conn = null;
  	PreparedStatement pstmt;
  	ResultSet rs;
  	Class.forName("oracle.jdbc.driver.OracleDriver");
  	conn = DriverManager.getConnection(url, user, pass);
    
  	String fname = String.valueOf(session.getAttribute("fname"));
  	String lname = String.valueOf(session.getAttribute("lname"));
    String id = String.valueOf(session.getAttribute("userId"));
    session.setAttribute("fname", fname);
    session.setAttribute("lname", lname);
    session.setAttribute("id", id);
  	id = " " + id;
    	
  	String query = "select Fname, Lname, Store_name, Score "
  			+ "from customer, store, rating "
  			+ "where bnum = breg_number "
  			+ "and customer_email = cemail "
  			+ "and customer_email = ?";
  	pstmt = conn.prepareStatement(query);
    	pstmt.setString(1, id);
    	//pstmt.setString(2, lname);
    	rs = pstmt.executeQuery();

  	out.println("<thead> <tr> <th scope=\"cols\" scope=\"cols\"> 성 </th>  <th>  이름 </th>  <th scope=\"cols\"> 음식점_이름 </th>  <th scope=\"cols\"> 평점 </th> </tr> </thead>");
  	while (rs.next()) {
  		out.println("<tr>");
		out.println("<td>" + rs.getString(1) + "</td>");
		out.println("<td>" + rs.getString(2) + "</td>");
		out.println("<td>" + rs.getString(3) + "</td>");
		out.println("<td>" + rs.getDouble(4) + "</td>");
		out.println("</tr>");
  	} %>
	</table>
	<br/>
	<br/>
	<%
	rs.close();
	pstmt.close();
	conn.close();
	%>
	<h2> 식당을 검색하세요</h2>
	<br/>
    <input type = "text" name = "search">
<br/>
<button type = "submit" class="snip1535"> 검색 </button>
<button type = "button" class="snip1535" onClick="location.href='homepage.jsp'"> 뒤로가기 </button>
 <!-- <input type = "submit"	value = "검색" >
-->
<br/><br/><br/> https://nanati.me/html_css_table_design/ 에서 표 디자인 가져옴
<br/>https://nanati.me/css-button-design/ 에서 검색 디자인 가져옴
</div>
</form>
</body>
</html>