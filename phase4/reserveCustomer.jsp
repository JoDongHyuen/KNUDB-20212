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
<form action = "searchRestaurant.jsp" method = "post">
<center>
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
  	out.print("<h2>" + fname);
  	String lname = String.valueOf(session.getAttribute("lname"));
    	out.print(lname + " ���� ���� ����Ʈ �Դϴ�.</h2>");
    String id = String.valueOf(session.getAttribute("id"));
    session.setAttribute("fname", fname);
    session.setAttribute("lname", lname);
    session.setAttribute("id", id);
    	
  	String query = "SELECT C.Fname, C.Lname, TO_CHAR(B.Time, 'YYYY-MM-DD HH24:MI:SS'), S.Store_name "
  	+ "FROM CUSTOMER C,  CUST_BOOKS_STR B, STORE S "
  	+ "WHERE C.Customer_email = ? "
  	+ "AND C.Customer_email = B.Cemail "
  	+ "AND B.Bnum = S.Breg_number "
  	+ "ORDER BY B.time";
  	id = " " + id;
  	pstmt = conn.prepareStatement(query);
    	pstmt.setString(1, id);
    	//pstmt.setString(2, lname);
    	rs = pstmt.executeQuery();

  	out.println("<thead> <tr> <th scope=\"cols\"> �� </th>  <th scope=\"cols\">  �̸� </th>  <th scope=\"cols\"> ���� �ð� </th>  <th scope=\"cols\"> ���� ��� </th> </tr> </thead>");
  	while (rs.next()) {
  		out.println("<tr>");
		out.println("<td>" + rs.getString(1) + "</td>");
		out.println("<td>" + rs.getString(2) + "</td>");
		out.println("<td>" + rs.getString(3) + "</td>");
		out.println("<td>" + rs.getString(4) + "</td>");
		out.println("</tr>");
  	}
	out.println("</table>");
	out.println("<br/>");
	out.println("<br/>");
  // ������ ������ ���� �Ϸ� //
	
	
  //������ �˻� �� ���� �ϱ� -> �Է¹޴�â, �˻���ư, ���� -> üũ�ڽ�, submit��ư -> ����Ǿ����ϴ�(�˾�) -> ���������� ���ư���
  // ������ �̸��� ��ġ ���� ���� �ۼ�
  %>
  
</table>
<br/>
<br/>
<input type = "text" name = "search">
<br/>
<button type = "submit" class="snip1535"> �˻� </button>
 <!-- <input type = "submit"	value = "�˻�" >
-->
<br/><br/><br/> https://nanati.me/html_css_table_design/ ���� ǥ ������ ������
<br/>https://nanati.me/css-button-design/ ���� �˻� ������ ������

</center>
</form>
</body>
</html>