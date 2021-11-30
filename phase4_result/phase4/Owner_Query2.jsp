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
<title>���� ��ȸ</title>
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
	String user = (String)session.getAttribute("DBID");
	String pass = (String)session.getAttribute("DBPW");
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
				<li><a href="StoreState.jsp">
				  <span class="icon"><img src="image/shop.png" alt="shop" /></span>
				  <span class="title">���� ����</span>
				</a></li>
				<li><a href="Owner_Query2.jsp">
				  <span class="icon"><img src="image/review.png" alt="review" /></span>
				  <span class="title">���� ��ȸ</span>
				</a></li>
				<li><a href="Owner_Query3.jsp">
				  <span class="icon"><img src="image/review2.png" alt="review" /></span>
				  <span class="title">Ư�� ���� �̻� ��<br> �� ��ȸ</span>
				</a></li>
				<li><a href="Owner_Query4.jsp">
				  <span class="icon"><img src="image/date.png" alt="review" /></span>
				  <span class="title">Ư�� ��¥ ����<br> ���� ��ȸ</span>
				</a></li>
				<li><a href="Owner_Query5.jsp">
				  <span class="icon"><img src="image/same_type.png" alt="review" /></span>
				  <span class="title">�������� ���� ��<br> ���� ��ȸ</span>
				</a></li>
				<li><a href="homepage.jsp">
				  <span class="icon"><img src="image/logout.png" alt="undo" /></span>
				  <span class="title">�ڷΰ���</span>
				</a></li>
			</ul>
		</div>
	
		<div class="main">
			<div class="top"></div>
			<div class="main-title">���� ����</div>
			<div class="main_contents">
				<div class="member_category">
					<div class="title">
						<span class="text"><%=store_name %></span>
					</div>
					<div class="member_list">
						<table class="member_entity">
							<thead>
								<tr>
									<th style="width: 100px">����</th>
								</tr>
							</thead>
							<%
								userId=" "+userId;
								try{
									sql = "SELECT R.Score " 
											+ "FROM OWNER O, RATING R, STORE S "
											+ " WHERE O.Bnum = S.Breg_number "
											+ " and O.Bnum = R.Bnum and OWNER_EMAIL = ?";
									ps = conn.prepareStatement(sql);
									ps.setString(1, userId);
									rs = ps.executeQuery();
									while(rs.next()){
										out.println("<tr>");
										out.println("<td style='width: 100px'>"+rs.getInt(1)+"</td>");
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