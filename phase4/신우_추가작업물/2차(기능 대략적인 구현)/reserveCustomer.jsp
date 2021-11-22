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
<form action = "searchRestaurant.jsp" method = "post">
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
    
  	String fname = String.valueOf(session.getAttribute("fname"));
  	out.println(fname);
  	String lname = String.valueOf(session.getAttribute("lname"));
    	out.println(lname);
    session.setAttribute("fname", fname);
    session.setAttribute("lname", lname);
    	
  	String query = "SELECT C.Fname, C.Lname, TO_CHAR(B.Time, 'YYYY-MM-DD HH24:MI:SS'), S.Store_name "
  	+ "FROM CUSTOMER C,  CUST_BOOKS_STR B, STORE S "
  	//+ "WHERE C.Fname = '" + fname + "' "
  	+ "WHERE C.Fname = ? "
  	+ "AND C.Lname = ? "
  	+ "AND C.Customer_email = B.Cemail "
  	+ "AND B.Bnum = S.Breg_number "
  	+ "ORDER BY B.time";
  	
  	pstmt = conn.prepareStatement(query);
    	pstmt.setString(1, fname);
    	pstmt.setString(2, lname);
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
�˻� : <input type = "text" name = "search">
<br/>
<button type = "submit" class="snip1535"> �˻� </button>
 <!-- <input type = "submit"	value = "�˻�" >
-->

</form>
</body>
</html>