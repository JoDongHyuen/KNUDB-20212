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
			<div class="top"></div>
			<div class="main-title">SEARCH</div>
			<div class="main_contents">
				<div class="member_category">
					<div class="title">
						<span class="text">판매 음료가 모두 주류 또는 음료수인 가게 이름 조회</span>
					</div>
					<div class="member_list">
						<form method="post" action="Search_Query8.jsp" class="query_frm">
							<table>
								<tr>
									<th>주류-> Y<br>음료수 -> N</th>
									<td><input type="text" name="bool" placeholder="Y or N" class="txt">
									<input type="submit" value="조회" class="btn">
								</tr>
							</table>
						</form>
						<table class="member_entity">
							<thead>
								<tr>
									<th style="width: 100px">가게 이름</th>
									<th style="width: 100px">주소</th>
								</tr>
							</thead>
							<%
							
								try{
									String bool = request.getParameter("bool");
									String sql = "SELECT Store_name, Location " 
											+ " FROM STORE S " 
											+ " WHERE EXISTS( ("
											        + "SELECT B.Id "
													+ " FROM  BEVERAGE B " 
											        + " WHERE B.Bnum = S.Breg_number "
											        + " AND B.Alcohol = ?) "
											+ " MINUS( "
											        + " SELECT E.Id "
											        + " FROM BEVERAGE E "
											        + " WHERE E.Alcohol = ?)"
											    + " )";
									PreparedStatement ps = conn.prepareStatement(sql);
									String bool2 = null;
									
									if(bool.equals("y")){
										bool="Y";
										bool2="N";	
									}
									else if (bool.equals("n")){
										bool="N";
										bool2="Y";
									}
									
									ps.setString(1, bool);
									ps.setString(2, bool2);
									ResultSet rs = ps.executeQuery();
									while(rs.next()){
										out.println("<tr>");
										out.println("<td style='width: 100px'>"+rs.getString(1)+"</td>");
										out.println("<td style='width: 100px'>"+rs.getString(2)+"</td>");
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