<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language = "java" import = "java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
   String serverIP = "localhost";
   String strSID = "orcl";
   String portNum = "1521";
   String user = (String)session.getAttribute("DBID");
   String pass = (String)session.getAttribute("DBPW");
   String url = "jdbc:oracle:thin:@" + serverIP + ":"
   + portNum + ":" + strSID;
   
   Connection conn = null;
   Class.forName("oracle.jdbc.driver.OracleDriver");
   conn = DriverManager.getConnection(url, user, pass);
   Statement stmt = conn.createStatement();
   
   String userId = session.getAttribute("userId").toString();
   int bnum = (int)session.getAttribute("bnum");
   session.setAttribute("userId", userId);
   session.setAttribute("bnum", bnum);
   
   String store_name = new String(request.getParameter("store_name").getBytes("8859_1"),"KSC5601");   
   String store_type = request.getParameter("store_type");
   int seat_number = Integer.parseInt(request.getParameter("seat_number"));
   String location = new String(request.getParameter("location").getBytes("8859_1"),"KSC5601");   
   
   String sql = "update store set store_name='" + store_name + "', store_type='" + store_type + "', seat_number=" +
            seat_number + " ,location='" + location + "'  where breg_number=" + bnum;
   
   int res = stmt.executeUpdate(sql);
   if(res > 0){
      response.sendRedirect("StoreState.jsp");
   }
   
   conn.close();
   stmt.close();
%> 
</body>
</html>