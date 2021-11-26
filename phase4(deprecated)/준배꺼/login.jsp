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
	String url = "jdbc:oracle:thin:@" + serverIP + ":"
	+ portNum + ":" + strSID;
	
	Connection conn = null;
	PreparedStatement pstmt, pstmt2, pstmt3;
	Statement stmt = null;
	ResultSet rs, rs2, rs3;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	
	String cmpId = request.getParameter("id");
	String passWord = request.getParameter("passWord");
	
	//cmpId = " " + compId; // 공백처리
	String sql = "select * from information";
	String sql2 = "select fname, lname, phone_number, customer_email, age from customer where CUSTOMER_EMAIL=";
	String sql3 = "select fname, lname, phone_number, owner_email, age, bnum from owner where OWNER_EMAIL=";
	
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	String type = "";
	String id = null;
	String pw = null;
	int flag = 0; // flag 1 -> 로그인 정보 일치 // flag 2 -> 로그인 정보 불일치
					// flag 0 -> 아이디 없음
	while (rs.next()) { // 이메일 맨 처음에 공백이 있음을 생각
		id = rs.getString(1);
		pw = rs.getString(2);
		type = rs.getString(3);
		String newId = "";
		int i = 0;
		
		id= id.substring(1, id.length());
		
		if (cmpId.equals(id)) {
			if (pw.equals(passWord))
				flag = 1;
			else
				flag = 2;
			break;
		}
		
	}
	rs.close();
	pstmt.close();
	
	if (flag == 0) { // 아이디 없음
		response.sendRedirect("homepage.jsp");
	} else if (flag == 1) { // 로그인 성공
		if(type.equals("customer")) {
			sql2 = sql2 + "' " + id + "'";
			pstmt2 = conn.prepareStatement(sql2);
			rs2 = pstmt2.executeQuery();
			while(rs2.next())
			{
				String fname = rs2.getString(1);
				String lname = rs2.getString(2);
				String phone_number = rs2.getString(3);
				String customer_email = rs2.getString(4);
				int age = rs2.getInt(5);
				session.setAttribute("fname", fname);
				session.setAttribute("lname", lname);
				session.setAttribute("phone_number", phone_number);
				session.setAttribute("customer_email", customer_email);
				session.setAttribute("age", age);
			}
			rs2.close();
			session.setAttribute("userType", "customer");
			session.setAttribute("userId", id);
			pstmt2.close();
		}
		else if(type.equals("owner")) {
			sql3 = sql3 + "' " + id + "'";
			pstmt3 = conn.prepareStatement(sql3);
			rs3 = pstmt3.executeQuery();
			while(rs3.next())
			{
				String fname = rs3.getString(1);
				String lname = rs3.getString(2);
				String phone_number = rs3.getString(3);
				String owner_email = rs3.getString(4);
				int age = rs3.getInt(5);
				int bnum = rs3.getInt(6);
				
				session.setAttribute("fname", fname);
				session.setAttribute("lname", lname);
				session.setAttribute("phone_number", phone_number);
				session.setAttribute("owner_email", owner_email);
				session.setAttribute("age", age);
				session.setAttribute("bnum", bnum);
			}
			rs3.close();
			session.setAttribute("userType", "owner");
			session.setAttribute("userId", id);
			pstmt3.close();
		}
		else {
			session.setAttribute("userType", "admin");
		}
		response.sendRedirect("homepage.jsp");
	} else if (flag == 2) { // 로그인 정보 불일치
		response.sendRedirect("homepage.jsp");
	}
%>



</body>
</html>