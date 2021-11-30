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
<title>���� ���� �߰�</title>
</head>
<body>
<%
	String userId = session.getAttribute("userId").toString();
	int bnum = (int)session.getAttribute("bnum");
	session.setAttribute("userId", userId);
	session.setAttribute("bnum", bnum);
	
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
				<li><a href="#">
				  <span class="icon"><img src="image/customer.png" alt="customer" /></span>
				  <span class="title">�� ����</span>
				</a></li>
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
				<li><a href="logout.jsp">
				  <span class="icon"><img src="image/logout.png" alt="logout" /></span>
				  <span class="title">Log Out</span>
				</a></li>
			</ul>
		</div>
	
		<div class="main">
			<div class="top"></div>
			<div class="main-title">���� �߰�</div>
			<div class="main_contents">
				<div class="member_category">
					<div class="title">
						<span class="text"><%=store_name %></span>
					</div>
					<div class="member_list">

						<table class="member_entity">
							<thead>

							</thead>

							<tbody>
								<form method="post" action="insert_food_ok.jsp" class="query_frm">
									<table>
										<tr>
											<td>���� �̸�</td>
											<td><input type="text" name="f_name" placeholder="���� �̸�" class="txt">
										</tr>
										<tr>
											<td>����</td>
											<td><input type="text" name="f_price" placeholder="����" class="txt">
										</tr>
										<tr>
											<td>������</td>
											<td><input type="text" name="origin" placeholder="������" class="txt">
										</tr>
									</table>
									<input type="submit" value="����" class="btn">
									<input type="button" value="���" onclick="history.back();"class="btn" />
								</form>
							</tbody>
						</table>
					</div>
				</div>
			</div>		
		</div>
	</div>
</body>
</html>