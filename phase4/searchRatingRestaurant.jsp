<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ page language = "java" import = "java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<style type = "text/css">
body{
background-color: #f9edff;
}
</style>
<meta charset="EUC-KR">
<link rel="stylesheet" href="css/custom.css">
<title>Insert title here</title>
</head>
<body>
 <form action="ratingProcess.jsp" method="post">
<h1> 식당 리스트 </h1>
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

	//String search = String.valueOf(session.getAttribute("search"));
	String search = new String(request.getParameter("search").getBytes("8859_1"), "EUC-KR");
	
	String query = "select store_name from store where store_name like '%" + search + "%'";
	
	pstmt = conn.prepareStatement(query);
	//pstmt.setString(1, search);
	rs = pstmt.executeQuery();

	int i=1;
	while(rs.next()){
		String st = rs.getString(1);
		//<input type="radio" id="st1" value = "경대맛집"> 경대맛집 " + i + "
		out.print("<input type=\"radio\" name=\"rst\" id=\"rst\" value = \""
		+ st + "\">" + st);
		out.print("<br/>");
		
		i++;
	}
	
	session.setAttribute("userId", session.getAttribute("userId"));
	//stmt.close();
	pstmt.close();
	rs.close();
	conn.close();
	
%>
<br/>
0~5 까지 평점 매기기, 소숫점 첫째자리까지 가능
<br/>
<input type = "text" name = "rating" size = 2>
<br/>
<button type = "submit" class="snip1535"> 입력 </button>
<br/><br/><br/> https://nanati.me/html_css_table_design/ 에서 검색 디자인 가져옴
 </form>
</body>
</html>