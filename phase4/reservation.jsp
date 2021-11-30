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
		int seatNum = 0;
		while(rs.next()){
			bNum = rs.getInt(1);
		}

		String fname = String.valueOf(session.getAttribute("fname"));
		String lname = String.valueOf(session.getAttribute("lname"));
		String id = String.valueOf(session.getAttribute("userId"));
		
		//seats_number 불러오는 작업
		sql = "select Seat_number from store where Breg_number = " + bNum;
		rs = stmt.executeQuery(sql);
		if(rs.next())
			seatNum = rs.getInt(1);
		
		//cust_books_str 에서 bnum 를 통해 예약 갯수 불러오기
		sql = "select * from cust_books_str where Bnum = " + bNum;
		rs = stmt.executeQuery(sql);
		int num = 0;
		while(rs.next())
			num++;
		
		sql = "insert into cust_books_str values(' " + id + "', " + bNum + ", " + time + ", 'YYYY-MM-DD HH24:MI:SS'))";
		
		try{
			if(num <= seatNum){ // 좌석수 >= 예약 -> ok
				stmt.executeUpdate(sql);
			}
			else{ // 예약이 안되도록
				conn.rollback();
				throw new SQLException();
			}
			
			out.println("<script type='text/javascript'>");
			out.println("alert('예약되었습니다!!');");
			out.println("</script>");
			
			response.sendRedirect("reserveCustomer.jsp");
			
		}catch (Exception e){
			conn.rollback();
			out.println("<script type='text/javascript'>");
			out.println("alert('해당 가게의 예약이 찼습니다.');");
			out.println("history.back();");
			out.println("</script>");

			e.printStackTrace();
		}finally{
			
			stmt.close();
			//pstmt.close();
			rs.close();
			conn.close();
		}		
		
	%>

</body>
</html>