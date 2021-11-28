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
	String pw = request.getParameter("pw");
	String pw_ck = request.getParameter("pw_ck");
	String name = new String(request.getParameter("name").getBytes("8859_1"),"KSC5601");
	
	String fname = name.substring(0, 1);
	String lname = name.substring(1, name.length());
	
	String phone_number = request.getParameter("phone");
	String temp = request.getParameter("age");
	int age = Integer.parseInt(temp);
	
	String sql = "update owner set fname='" + fname + "', lname='" + lname + "', phone_number='" +
				phone_number + "', age=" + age + " where owner_email like '%" + userId + "%'";
	
	String sql2 = "update information set pass_word='" + pw + "' where email like '%" +  userId + "%'";
	int res;
	
	if(!pw.equals(pw_ck)){
		out.println("<script type='text/javascript'>");
		out.println("alert('비밀번호 불일치!');");
				out.println("history.back();");
				out.println("</script>");		
	}
	
	else if(!pw.equals(""))
		 res = stmt.executeUpdate(sql2);
	
	res = stmt.executeUpdate(sql);
	if(res > 0){
		session.setAttribute("userId", userId);
		session.setAttribute("fname", fname);
		session.setAttribute("lname", lname);
		session.setAttribute("phone_number", phone_number);
		session.setAttribute("age", age);
		
		response.sendRedirect("homepage.jsp");
	}
	
	conn.close();
	stmt.close();
%> 
</body>
</html>