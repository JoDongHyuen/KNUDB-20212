<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ page language = "java" import = "java.text.*, java.sql.*, java.util.*" %>
<!doctype html>
<html>
  <head>
  <style type = "text/css">
body{
background-color: #e0fdff;
}
</style>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <link rel="stylesheet" href="css/custom.css">
    <title>����ȭ��</title>
  </head>
  <body>
  <form action="reservation.jsp" method="post"> 
  <center>
	<h2> �������� �� �� ���� �ð��� ���ϰ� ���� ��ư�� ��������</h2>
	</center>
	<br/>
	<br/>
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
		//<input type="radio" id="st1" value = "������"> ������ " + i + "
		out.print("<input type=\"radio\" name=\"rst\" id=\"rst\" value = \""
		+ st + "\">" + st);
		out.print("<br/>");
		
		i++;
	}
	//stmt.close();
	pstmt.close();
	rs.close();
	conn.close();
	
%>

<!-- ex) 2021�� 10�� 4�� 15�� 41�� 35���ΰ��
<br/>
2021-10-04 
<br/>
15:41:35-->

<center>
<br/>
�ð��� �Է��ϼ��� (24�ð� ���� ����3�� -> 15��)
<br/>
<input type = "number" name = "year" size="4"> �� 
<input type = "number" name = "month" size="2"> ��
<input type = "number" name = "day" size="2"> ��
 <br/>
<input type = "number" name = "hour" size="2"> �� 
<input type = "number" name = "minute" size="2"> ��
<input type = "number" name = "second" size="2"> ��

<br/>
<button type = "submit" class="snip1535"> ���� </button>
		<br/>
<br/><br/><br/> https://nanati.me/html_css_table_design/ ���� ���� ��ư ������ ������
</center>
</form>
  </body>
</html>