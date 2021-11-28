<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language = "java" import = "java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="css/navigation12.css" />
<link rel="stylesheet" href="css/main.css" />
<link rel="stylesheet" href="css/StoreState.css" />
<title>고객 조회</title>
</head>
<body>

<%
	String userId = session.getAttribute("userId").toString();
	int bnum = (int)session.getAttribute("bnum");
	session.setAttribute("userId", userId);
	session.setAttribute("bnum", bnum);
	
	session.setAttribute("userId", userId);
	String serverIP = "localhost";
	String strSID = "orcl";
	String portNum = "1521";
	String user = "restaurant";
	String pass = "restaurant";
	String url = "jdbc:oracle:thin:@" + serverIP + ":"
	+ portNum + ":" + strSID;
	
	Connection conn = null;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	Statement stmt = conn.createStatement();
	
	String store_name=null;
	String sql = "select store_name from store where breg_number=?";
	PreparedStatement ps = conn.prepareStatement(sql);
	ps.setInt(1, bnum);
	ResultSet rs = ps.executeQuery();
	if(rs.next()){
		store_name = rs.getString(1);
	}
%>
	<div class="container">
		<div class="navigation">
			<div class="logo">
				<a class="logo2" href="homepage.jsp">Database</a>
			</div>
			<ul>
				<li><a href="#">
				  <span class="icon"><img src="image/customer.png" alt="customer" /></span>
				  <span class="title">고객 관리</span>
				</a></li>
				<li><a href="StoreState.jsp">
				  <span class="icon"><img src="image/shop.png" alt="shop" /></span>
				  <span class="title">가게 정보</span>
				</a></li>
				<li><a href="Owner_Query2.jsp">
				  <span class="icon"><img src="image/review.png" alt="review" /></span>
				  <span class="title">리뷰 조회</span>
				</a></li>
				<li><a href="Owner_Query3.jsp">
				  <span class="icon"><img src="image/review2.png" alt="review" /></span>
				  <span class="title">특정 점수 이상 준<br> 고객 조회</span>
				</a></li>
				<li><a href="Owner_Query4.jsp">
				  <span class="icon"><img src="image/date.png" alt="review" /></span>
				  <span class="title">특정 날짜 이후<br> 예약 조회</span>
				</a></li>
				<li><a href="Owner_Query5.jsp">
				  <span class="icon"><img src="image/same_type.png" alt="review" /></span>
				  <span class="title">동종업계 가게 및<br> 평점 조회</span>
				</a></li>
				<li><a href="logout.jsp">
				  <span class="icon"><img src="image/logout.png" alt="logout" /></span>
				  <span class="title">Log Out</span>
				</a></li>
			</ul>
		</div>
	
		<div class="main">
			<div class="top"></div>
			<div class="main-title">고객 조회</div>
			<div class="main_contents">
				<div class="member_category">
					<div class="title">
						<span class="text"><%=store_name %></span>
					</div>
					<div class="member_list">
						<form method="post" action="Owner_Query3.jsp" class="query_frm">
							<table>
								<tr>
									<th>평점</th>
									<td><input type="text" name="rate" placeholder="평점" class="txt">
									<input type="submit" value="조회" class="btn">
								</tr>
							</table>
						</form>
						<table class="member_entity">
							<thead>
								<tr>
									<th style="width: 100px">고객 명</th>
									<th style="width: 100px">평점</th>
								</tr>
							</thead>
							<%
								userId=" "+userId;
								
								try{
									int rate = Integer.parseInt(request.getParameter("rate"));
									sql = "SELECT C.fname, c.lname, R.Score "
										   + " FROM CUSTOMER C, RATING R, STORE S, OWNER O "
										   + " WHERE Score >= ? "
										   + " AND C.Customer_email = R.Cemail "
										   + " AND R.Bnum = S.Breg_number "
										   + " AND O.Bnum = R.bnum AND O.Owner_email = ? "
										   + " ORDER BY Score DESC";
									ps = conn.prepareStatement(sql);
									ps.setInt(1, rate);
									ps.setString(2, userId);
									rs = ps.executeQuery();
									while(rs.next()){
										out.println("<tr>");
										out.println("<td style='width: 100px'>"+rs.getString(1)+ rs.getString(2) +"</td>");
										out.println("<td style='width: 100px'>"+rs.getInt(3)+"</td>");
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