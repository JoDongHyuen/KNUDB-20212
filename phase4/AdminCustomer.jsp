<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page language = "java" import = "java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
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
				  <span class="title">�� ����</span>
				</a></li>
				<li><a href="AdminOwner.jsp">
				  <span class="icon"><img src="image/owner.png" alt="owner" /></span>
				  <span class="title">���� ����</span>
				</a></li>
				<li><a href="logout.jsp">
				  <span class="icon"><img src="image/logout.png" alt="logout" /></span>
				  <span class="title">Log Out</span>
				</a></li>
			</ul>
		</div>
		<div class="main">
			<div class="top"></div>
			<div class="main-title">�� ����</div>
			<div class="main_contents">
				<div class="member_category">
					<div class="title">
						<span class="text">ȸ�� ���</span>
					</div>
					<div class="member_list">
						<table class="member_entity">
							<thead>
								<tr>
									<th style="width: 120px">�̸�</th>
									<th style="width: 300px">��ȭ��ȣ</th>
									<th style="width: 300px">�̸���</th>
									<th style="width: 200px">����</th>
									<th style="width: 100px">����</th>
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