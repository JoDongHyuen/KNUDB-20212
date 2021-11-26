<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Lab #9</title>
</head>
<body>
	<h1>Lab #9: Repeating Lab #5-3 via JSP</h1>
	<%
		String serverIP = "localhost";
		String strSID = "orcl";
		String portNum = "1521";
		String user = "company";
		String pass = "company";
		String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
		
		Connection conn = null;
		PreparedStatement pstmt;
		ResultSet rs;
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, user, pass);
		String query = "select lname, minit, fname from employee e, project p "
				+ "where p.dnum = e.dno "
				+ "and p.pname = ? and e.dno = ? and e.salary = ? "
				+ "order by lname";
		pstmt = conn.prepareStatement(query);
		
		pstmt.setString(1, request.getParameter("pname1"));
		pstmt.setInt(2, Integer.parseInt(request.getParameter("dnum")));
		pstmt.setInt(3, Integer.parseInt(request.getParameter("salary")));
		
		rs = pstmt.executeQuery();
	%>
	<%
		out.println("<h3>----- Q1 Result -----</h3>");
		out.println("<table border=\"1\">");
		ResultSetMetaData rsmd = rs.getMetaData();
		int cnt = rsmd.getColumnCount();
		for(int i=1; i<=cnt; i++)
			out.println("<th>"+rsmd.getColumnName(i)+"</th>");
		
		while(rs.next())
		{
			out.println("<tr>");
			out.println("<td>"+rs.getString(1)+"</td>");
			out.println("<td>"+rs.getString(2)+"</td>");
			out.println("<td>"+rs.getString(3)+"</td>");
			out.println("</tr>");
		}
		out.println("</table>");
		rs.close();
		pstmt.close();
		conn.close();
	%>
	
	<% 
		out.println("<h3>----- Q2 Result -----</h3>");
		conn = DriverManager.getConnection(url, user, pass);
		query = "select d.dname, e.ssn, e.lname "
				+ "from department d, employee e "
				+ "where super_ssn = ? and address like ? "
				+ "and d.dnumber = e.dno " 
				+ "order by e.lname";
		pstmt = conn.prepareStatement(query);
		
		pstmt.setString(1, request.getParameter("super_ssn"));
		pstmt.setString(2, "%" + request.getParameter("address") + "%");
		
		rs = pstmt.executeQuery();
	%>
	
	<%
		out.println("<table border=\"1\">");
		rsmd = rs.getMetaData();
		cnt = rsmd.getColumnCount();
		for(int i=1; i<=cnt; i++)
			out.println("<th>"+rsmd.getColumnName(i)+"</th>");
		
		while(rs.next())
		{
			out.println("<tr>");
			out.println("<td>"+rs.getString(1)+"</td>");
			out.println("<td>"+rs.getString(2)+"</td>");
			out.println("<td>"+rs.getString(3)+"</td>");
			out.println("</tr>");
		}
		out.println("</table>");
		rs.close();
		pstmt.close();
		conn.close();
	%>
	
	<% 
		out.println("<h3>----- Q3 Result -----</h3>");
		conn = DriverManager.getConnection(url, user, pass);
		query = "select e.lname, w.hours "
				+"from employee e, works_on w, project p "
				+"where p.pnumber = w.pno "
				+"and w.essn = e.ssn "
				+"and p.pname = ? "
				+"order by w.hours desc";
		pstmt = conn.prepareStatement(query);
		
		pstmt.setString(1, request.getParameter("pname3"));
		
		rs = pstmt.executeQuery();
	%>
	
	<%
		out.println("<table border=\"1\">");
		rsmd = rs.getMetaData();
		cnt = rsmd.getColumnCount();
		for(int i=1; i<=cnt; i++)
			out.println("<th>"+rsmd.getColumnName(i)+"</th>");
		
		while(rs.next())
		{
			out.println("<tr>");
			out.println("<td>"+rs.getString(1)+"</td>");
			out.println("<td>"+rs.getFloat(2)+"</td>");
			out.println("</tr>");
		}
		out.println("</table>");
		rs.close();
		pstmt.close();
		conn.close();
	%>
	
	<% 
		out.println("<h3>----- Q4 Result -----</h3>");
		conn = DriverManager.getConnection(url, user, pass);
		query = "select e.fname, e.lname, w.hours "
				+"from employee e, works_on w, project p "
				+"where p.pnumber = w.pno and w.essn = e.ssn "
				+"and p.pname = ? and w.hours >= ? "
				+"order by w.hours";
		pstmt = conn.prepareStatement(query);
		
		pstmt.setString(1, request.getParameter("pname4"));
		pstmt.setInt(2, Integer.parseInt(request.getParameter("hours")));
		
		rs = pstmt.executeQuery();
	%>
	
	<%
		out.println("<table border=\"1\">");
		rsmd = rs.getMetaData();
		cnt = rsmd.getColumnCount();
		for(int i=1; i<=cnt; i++)
			out.println("<th>"+rsmd.getColumnName(i)+"</th>");
		
		while(rs.next())
		{
			out.println("<tr>");
			out.println("<td>"+rs.getString(1)+"</td>");
			out.println("<td>"+rs.getString(2)+"</td>");
			out.println("<td>"+rs.getFloat(3)+"</td>");
			out.println("</tr>");
		}
		out.println("</table>");
		rs.close();
		pstmt.close();
		conn.close();
	%>
	
	<% 
		out.println("<h3>----- Q5 Result -----</h3>");
		conn = DriverManager.getConnection(url, user, pass);
		query = "select e.lname, e.fname, d.dependent_name, d.relationship "
				+"from employee e, dependent d "
				+"where d.essn = e.ssn "
				+"and e.super_ssn=?";
		pstmt = conn.prepareStatement(query);
		
		pstmt.setString(1, request.getParameter("super_ssn5"));
		
		rs = pstmt.executeQuery();
	%>
	
	<%
		out.println("<table border=\"1\">");
		rsmd = rs.getMetaData();
		cnt = rsmd.getColumnCount();
		for(int i=1; i<=cnt; i++)
			out.println("<th>"+rsmd.getColumnName(i)+"</th>");
		
		while(rs.next())
		{
			out.println("<tr>");
			out.println("<td>"+rs.getString(1)+"</td>");
			out.println("<td>"+rs.getString(2)+"</td>");;
			out.println("<td>"+rs.getString(3)+"</td>");;
			out.println("<td>"+rs.getString(4)+"</td>");
			out.println("</tr>");
		}
		out.println("</table>");
		rs.close();
		pstmt.close();
		conn.close();
	%>
</body>
</html>