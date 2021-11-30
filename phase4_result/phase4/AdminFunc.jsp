<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page language = "java" import = "java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="css/navigation.css" />
<link rel="stylesheet" href="css/main.css" />
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
	PreparedStatement pstmt;
	ResultSet rs;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	
	
%>
	<div class="container">
		<div class="navigation">
			<div class="logo">
				<b>DataBase</b>
			</div>
			<ul>
				<li><a href="AdminCustomer.jsp">
				  <span class="icon"><img src="image/customer.png" alt="customer" /></span>
				  <span class="title">고객 관리</span>
				</a></li>
				<li><a href="AdminOwner.jsp">
				  <span class="icon"><img src="image/owner.png" alt="owner" /></span>
				  <span class="title">점주 관리</span>
				</a></li>
				<li><a href="logout.jsp">
				  <span class="icon"><img src="image/logout.png" alt="logout" /></span>
				  <span class="title">Log Out</span>
				</a></li>
			</ul>
		</div>
		<div class="main">
			<div class="top"></div>
			<div class="main-title">고객 관리</div>
			<div class="main_contents">
				<div class="member_category">
					<div class="title">
						<span class="text">회원 목록</span>
					</div>
					<div class="member_list">
						<table class="member_entity">
							<thead>
								<tr>
									<th style="width: 120px">이름</th>
									<th style="width: 300px">전화번호</th>
									<th style="width: 300px">이메일</th>
									<th style="width: 200px">성별</th>
									<th style="width: 100px">나이</th>
								</tr>
							</thead>
							<%
								String sql = "select * from customer";
								pstmt = conn.prepareStatement(sql);
								rs = pstmt.executeQuery();
								while (rs.next()) {
									out.println("<tr>");
									out.println("<td>"+rs.getString(1)+rs.getString(2)+"</td>");
									out.println("<td>"+rs.getString(3)+"</td>");
									out.println("<td>"+rs.getString(4)+"</td>");
									out.println("<td>"+rs.getString(5)+"</td>");
									out.println("<td>"+rs.getInt(6)+"</td>");
									out.println("</tr>");
								}
								rs.close();
								pstmt.close();
							%>
							<tbody>
							
							</tbody>
						</table>
					</div>
				</div>
			</div>		
		</div>
	</div>
</body>
</html>