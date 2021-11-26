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

  	out.println("<thead> <tr> <th scope=\"cols\"> 성 </th>  <th scope=\"cols\">  이름 </th>  <th scope=\"cols\"> 예약 시간 </th>  <th scope=\"cols\"> 예약 장소 </th> </tr> </thead>");
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
  // 예약한 음식점 띄우기 완료 //
	
	
  //음식점 검색 후 예약 하기 -> 입력받는창, 검색버튼, 쿼리 -> 체크박스, submit버튼 -> 예약되었습니다(팝업) -> 이전페이지 돌아가기
  // 음식점 이름과 위치 띄우는 쿼리 작성
  %>
  
</table>
<br/>
<br/>
검색 : <input type = "text" name = "search">
<br/>
<button type = "submit" class="snip1535"> 검색 </button>
 <!-- <input type = "submit"	value = "검색" >
-->

</form>
</body>
</html>