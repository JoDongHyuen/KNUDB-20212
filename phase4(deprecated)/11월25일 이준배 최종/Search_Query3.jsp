<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language = "java" import = "java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="css/Searching_main.css" />
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
				<li><a href="Search_Query1.jsp">
				  <span class="title">특정 가격<br> 이하 음식 조회</span>
				</a></li>
				<li><a href="Search_Query2.jsp">
				  <span class="title">평가 특정<br> 개수 이상</span>
				</a></li>
				<li><a href="Search_Query3.jsp">
				  <span class="title">평균 평점 이상<br> 가게 조회</span>
				</a></li>
				<li><a href="Search_Query4.jsp">
				  <span class="title">특정 평점 있는<br> 가게 조회</span>
				</a></li>
				<li><a href="Search_Query5.jsp">
				  <span class="title">주류가 있는<br> 가게 조회</span>
				</a></li>
				<li><a href="Search_Query6.jsp">
				  <span class="title">특정 원산지<br> 음식 조회</span>
				</a></li>
				<li><a href="Search_Query7.jsp">
				  <span class="title">판매 음식이 모두<br> 특정 원산지인 가게 조회</span>
				</a></li>
				<li><a href="Search_Query8.jsp">
				  <span class="title">판매 음료가 모두 주류<br> 또는 음료수인 가게 이름 조회</span>
				</a></li>
				<li><a href="Search_Query9.jsp">
				  <span class="title">특정 가격 이상<br> 음식이 있는 가게 조회</span>
				</a></li>
			</ul>
		</div>
		<div class="main">
			<div class="top">Hello World!</div>
			<div class="main-title">SEARCH</div>
			<div class="main_contents">
				<div class="member_category">
					<div class="title">
						<span class="text">평균 평점이 특정 점수 이상인 가게이름, 위치, 평점 조회</span>
					</div>
					<div class="member_list">
						<form method="post" action="Search_Query3.jsp" class="query_frm">
							<table>
								<tr>
									<th>평균 평점</th>
									<td><input type="text" name="avg_rate" placeholder="평균 평점" class="txt">
									<input type="submit" value="조회" class="btn">
								</tr>
							</table>
						</form>
						<table class="member_entity">
							<thead>
								<tr>
									<th style="width: 100px">가게 이름</th>
									<th style="width: 100px">위치</th>
									<th style="width: 100px">평점</th>
								</tr>
							</thead>
							<%
							
								try{
									int avg_rate = Integer.parseInt(request.getParameter("avg_rate"));
									String sql = "SELECT Store_name, Location, ROUND(avg(Score), 1) " + "FROM STORE, RATING " + "WHERE Breg_number = Bnum "
											+ "GROUP BY Store_name, Location " + "HAVING avg(Score) >= ? ORDER BY avg(Score)";
									PreparedStatement ps = conn.prepareStatement(sql);
									ps.setInt(1, avg_rate);
									ResultSet rs = ps.executeQuery();
									while(rs.next()){
										out.println("<tr>");
										out.println("<td style='width: 100px'>"+rs.getString(1)+"</td>");
										out.println("<td style='width: 100px'>"+rs.getString(2)+"</td>");
										out.println("<td style='width: 100px'>"+rs.getFloat(3)+"</td>");
										out.println("</tr>");
									}
								}
								catch(Exception e){
									e.printStackTrace();
								}
								finally{
									stmt.close();
									conn.close();
								}
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