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
		String user = "restaurant";
		String pass = "restaurant";
		String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;

		Connection conn = null;
		Statement stmt;
		PreparedStatement pstmt;
		ResultSet rs;
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, user, pass);
		conn.setAutoCommit(false);
		

		String year = (request.getParameter("year"));
		String month = (request.getParameter("month"));
		String day = (request.getParameter("day"));
		String hour = (request.getParameter("hour"));
		String minute = (request.getParameter("minute"));
		String second = (request.getParameter("second"));
		
		if(month.length() == 1)
			month = "0" + month;
		if(day.length() == 1)
			day = "0" + day;
		if(hour.length() == 1)
			hour = "0" + hour;
		if(minute.length() == 1)
			minute = "0" + minute;
		if(second.length() == 1)
			second = "0" + second;

		
		String time = "TO_DATE('20" + year + "-" + month + "-"
		+ day + " " + hour + ":" + minute + ":" + second + "'";
		
		
		String str = new String(request.getParameter("rst").getBytes("8859_1"), "EUC-KR");
		
		
		String sql = "select breg_number from store where store_name = '" + str + "'";
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		
		int bNum = 0;
		while(rs.next()){
			bNum = rs.getInt(1);
		}

		String fname = String.valueOf(session.getAttribute("fname"));
		String lname = String.valueOf(session.getAttribute("lname"));
		String id = String.valueOf(session.getAttribute("id"));
		//String fname = "강";
		//String lname = "도원";
		/*
		sql = "select Customer_email from customer where Fname = '" + fname + "' and Lname = '" + lname + "'";

		rs = stmt.executeQuery(sql);
		rs.next();
		String email = rs.getString(1);*/

		sql = "insert into cust_books_str values(' " + id + "', " + bNum + ", " + time + ", 'YYYY-MM-DD HH24:MI:SS'))";
		int res = stmt.executeUpdate(sql);
		conn.commit();

		response.sendRedirect("reserveCustomer.jsp");
	%>

</body>
</html>