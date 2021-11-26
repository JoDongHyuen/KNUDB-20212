<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language = "java" import = "java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="css/navigation.css" />
<link rel="stylesheet" href="css/main.css" />
<link rel="stylesheet" href="css/Searching_Query.css" />
<title>SEARCH</title>
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
	
	int price = Integer.parseInt(request.getParameter("price"));
	
	Connection conn = null;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	Statement stmt = conn.createStatement();

%>
	<div class="container">
		<div class="navigation">
			<div class="logo">
				<a class="logo2" href="homepage.jsp">Database</a>
			</div>
			<ul>
				<li><a href="AdminCustomer.jsp">
				  <span class="icon"><img src="image/customer.png" alt="customer" /></span>
				  <span class="title">가격이하 음식 조회</span>
				</a></li>
				<li><a href="StoreState.jsp">
				  <span class="icon"><img src="image/shop.png" alt="owner" /></span>
				  <span class="title">query2</span>
				</a></li>
				<li><a href="logout.jsp">
				  <span class="icon"><img src="image/logout.png" alt="logout" /></span>
				  <span class="title">query3</span>
				</a></li>
				<li><a href="AdminCustomer.jsp">
				  <span class="icon"><img src="image/customer.png" alt="customer" /></span>
				  <span class="title">query4</span>
				</a></li>
				<li><a href="StoreState.jsp">
				  <span class="icon"><img src="image/owner.png" alt="owner" /></span>
				  <span class="title">query5</span>
				</a></li>
				<li><a href="logout.jsp">
				  <span class="icon"><img src="image/logout.png" alt="logout" /></span>
				  <span class="title">query6</span>
				</a></li>
				<li><a href="AdminCustomer.jsp">
				  <span class="icon"><img src="image/customer.png" alt="customer" /></span>
				  <span class="title">query7</span>
				</a></li>
				<li><a href="StoreState.jsp">
				  <span class="icon"><img src="image/owner.png" alt="owner" /></span>
				  <span class="title">query8</span>
				</a></li>
				<li><a href="logout.jsp">
				  <span class="icon"><img src="image/logout.png" alt="logout" /></span>
				  <span class="title">query9</span>
				</a></li>
			</ul>
		</div>
		<div class="main">
			<div class="top">Hello World!</div>
			<div class="main-title">SEARCH</div>
			<div class="main_contents">
				<div class="member_category">
					<div class="title">
						<span class="text">특정 가격 이하의 음식 조회</span>
					</div>
					<div class="member_list">
						<form method="post" action="Search_Query1_ok.jsp">
							<table>
								<tr>
									<th>가격</th>
									<td><input type="text" name="price" placeholder="가격" class="txt">
									<input type="submit" value="조회" class="btn">
								</tr>
							</table>
						</form>
						<table class="member_entity">
							<thead>
								<tr>
									<th style="width: 100px">음식 명</th>
									<th style="width: 100px">가격</th>
								</tr>
							</thead>
							<%
								String sql = "SELECT Food_name, Price " + "FROM FOOD " + "WHERE Price <= ? ORDER BY PRICE DESC";
								PreparedStatement ps = conn.prepareStatement(sql);
								ps.setInt(1, price);
								ResultSet rs = ps.executeQuery();
								
								String f_name=null;
								int k, f_price=0, flag=0;
								
								while(rs.next()){
									out.println("<tr>");
									out.println("<td style='width: 100px'>"+rs.getString(1)+"</td>");
									out.println("<td style='width: 100px'>"+rs.getInt(2)+"</td>");
									f_price = rs.getInt(2);
									out.println("</tr>");
								}
								rs.close();
								stmt.close();
								conn.close();
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