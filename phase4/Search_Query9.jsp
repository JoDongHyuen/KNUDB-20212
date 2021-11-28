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
				  <span class="title">평가 특정<br> 개수 이상 가게 조회</span>
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
			<div class="top"></div>
			<div class="main-title">SEARCH</div>
			<div class="main_contents">
				<div class="member_category">
					<div class="title">
						<span class="text">특정 가격 이상 음식이 있는 가게 조회</span>
					</div>
					<div class="member_list">
						<form method="post" action="Search_Query9.jsp" class="query_frm">
							<table>
								<tr>
									<th>가격</th>
									<td><input type="text" name="price" placeholder="가격 입력" class="txt">
									<input type="submit" value="조회" class="btn">
								</tr>
							</table>
						</form>
						<table class="member_entity">
							<thead>
								<tr>
									<th style="width: 100px">가게 이름</th>
									<th style="width: 100px">개수</th>
								</tr>
							</thead>
							<%
							
								try{
									int price = Integer.parseInt(request.getParameter("price"));
									String sql = "select Store_name, count(*) as count " + "from Store natural join food "
											+ "where price in " + "   (select price " + "   from food " + "   where price >= ? " + "   ) "
											+ "and breg_number = Bnum " + "group by Store_name " + "having count(*) >= 1 "
											+ "order by count desc";
									PreparedStatement ps = conn.prepareStatement(sql);
			
									ps.setInt(1, price);
									ResultSet rs = ps.executeQuery();
									while(rs.next()){
										out.println("<tr>");
										out.println("<td style='width: 100px'>"+rs.getString(1)+"</td>");
										out.println("<td style='width: 100px'>"+rs.getInt(2)+"</td>");
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