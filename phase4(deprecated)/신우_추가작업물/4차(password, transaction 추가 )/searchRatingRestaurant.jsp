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
<h1> �Ĵ� ����Ʈ </h1>
<table class="type11">
<%
	String serverIP = "localhost";
	String strSID = "orcl";
	String portNum = "1521";
	String user = "restaurant";
	String pass = "restaurant";
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
		//<input type="radio" id="st1" value = "������"> ������ " + i + "
		out.print("<input type=\"radio\" name=\"rst\" id=\"rst\" value = \""
		+ st + "\">" + st);
		out.print("<br/>");
		
		i++;
	}
	
	session.setAttribute("id", session.getAttribute("id"));
%>
<br/>
0~5 ���� ���� �ű��, �Ҽ��� ù°�ڸ����� ����
<br/>
<input type = "text" name = "rating" size = 2>
<br/>
<button type = "submit" class="snip1535"> �Է� </button>
<br/><br/><br/> https://nanati.me/html_css_table_design/ ���� �˻� ������ ������
 </form>
</body>
</html>