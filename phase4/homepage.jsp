<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page language = "java" import = "java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>HomePage</title>
<link rel="stylesheet" href="css/homepage.css">
</head>
<body>
	<div id="header">
		<a href="homepage.html" class="logo">DataBase Term Project</a>
		<div class="logo-right">COMP322004</div>
	</div>
	<div id="body">
		<ul class="actions">
				<li><a href="Search_Query1.jsp" class="button alt"><b>Search</b></a></li>
		</ul>
		<div class="login-form">
		<% 
			session.setAttribute("DBID", "restaurant");
			session.setAttribute("DBPW", "restaurant");
			if(session.getAttribute("userType") == null) {
		%>
			<form action="login.jsp" method="post">
				<input type="text" value="" name="id" class="text-field" placeholder="ID">
				<input type="password" value="" name="passWord" class="text-field" placeholder="PW">
				<input type="submit" value="Log In" class="btn">
				<button type="button" class="btn" value="signup" onClick="location.href='register.jsp'">Sign Up</button>
			</form>
		<% 
			} else if(session.getAttribute("userType").equals("customer")) {
		%>
		
		<div>
			<div class="welcome">
				�������!<br>
				<%=session.getAttribute("fname") %><%=session.getAttribute("lname") %>��
			</div><br>
			<input type="button" class="btn" value="���� ���� ����" onclick="location.href='updateCustomer.jsp'">
			<input type="button" class="btn" value="���� �ű��" onclick="location.href='customerRating.jsp'">
			<input type="button" class="btn" value="�����ϱ�" onclick="location.href='reserveCustomer.jsp'">
			<input type="button" class="btn" value="Log Out" onclick="location.href='logout.jsp'">
		</div>
		
		<%
			} else if(session.getAttribute("userType").equals("owner")) {
		%>
		
		<div>
			<div class="welcome">
				�������!<br>
				<%=session.getAttribute("fname") %><%=session.getAttribute("lname") %>��
			</div><br>
			<input type="button" class="btn" value="���� ���� ����" onclick="location.href='updateOwner.jsp'">
			<input type="button" class="btn" value="���� ����" onclick="location.href='StoreState.jsp'">
			<input type="button" class="btn" value="���� ����" onclick="location.href='reserveOwner.jsp'">
			<input type="button" class="btn" value="Log Out" onclick="location.href='logout.jsp'">
		</div>
		
		<% 
			} else if(session.getAttribute("userType").equals("admin"))
				response.sendRedirect("AdminCustomer.jsp");
		%>
	
		</div>
	</div>
	<div id="info1">
<center> <h2> �־��� ���� �Ұ�</h2> </center>
<%
	String serverIP = "localhost";
	String strSID = "orcl";
	String portNum = "1521";
	String user = "restaurant";
	String pass = "restaurant";
	String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;
	
	Connection conn = null;
	PreparedStatement pstmt;
	Statement stmt = null;
	ResultSet rs, rs2, rs3;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	
	String sql = "select distinct s.store_name, s.location, r.score " + "from food f, rating r, store s "
			+ "where f.bnum = r.bnum " + "and s.breg_number = r.bnum " + "and f.bnum = s. breg_number "
			+ "and r.score =( " + "    select min(score) " + "    from rating " + "    group by r.bnum " + ")";

	PreparedStatement ps = conn.prepareStatement(sql);
	rs = ps.executeQuery();
	stmt = conn.createStatement();
	rs = stmt.executeQuery(sql);
	ResultSetMetaData rsmd = rs.getMetaData();
	//int cnt = rsmd.getColumnCount();

	int i = 0;
	while (rs.next())
		i++;
	//�������� ���� ���� ���� i
	rs = stmt.executeQuery(sql);
	rsmd = rs.getMetaData();
	int j = 0;
	String strName = "";
	String strLoc = "";
	int score = 0;
	Random random = new Random();
	i = random.nextInt(i) + 1;
	while(rs.next()){
		j++;
		if(i == j){
			strName = rs.getString(1);
			strLoc = rs.getString(2);
			score = rs.getInt(3);
			break;
		}
	}

	out.print("���� �̸� : " + strName + "<br/>");	
	out.print("���� ��ġ : " + strLoc + "<br/>");
	out.print("���� : " + score + " �� <br/><br/><br/>");	
	out.print("<center> ���� ���� �ޱ� ���ؼ� ����� �սô� </center>");	
%>



</div>
		<div id="info2">
		<center> <h2>���� ��� ���� �Ұ�</h2> </center>
<%
	sql = "select f.food_name, o.country_name, f.price from food f, origin o where f.id = o.id and f.price =(   select max(price)     from food )";		
	ps = conn.prepareStatement(sql);
	rs = stmt.executeQuery(sql);
	rsmd = rs.getMetaData();
	
	i = 0;
	while (rs.next())
		i++;
	//�������� ���� ���� ���� i
	rs = stmt.executeQuery(sql);
	rsmd = rs.getMetaData();
	j = 0;
	String foodName = "";
	String CountryName = "";
	int price = 0;
	i = random.nextInt(i) + 1;
	while(rs.next()){
		j++;
		if(i == j){
			foodName = rs.getString(1);
			CountryName = rs.getString(2);
			price = rs.getInt(3);
			break;
		}
	}

	out.print("���� �̸� : " + foodName + "<br/>");	
	out.print("������ : " + CountryName + "<br/>");
	out.print("���� : " + price + " ��<br/><br/><br/>");	
	out.print("<center> </center>");	
	
	rs.close();
	ps.close();
	stmt.close();
	conn.close();
		
%>
	

</div>
		<div id="info3">
		<center> <h2>�ְ� ���� ���� �Ұ�</h2></center>
<%
	sql = "select distinct f.food_name, f.price, r.score from food f, rating r where f.bnum = r.bnum and r.score in("
			+ "select max(score)    from rating " + "group by r.bnum)";		
	ps = conn.prepareStatement(sql);
	rs = stmt.executeQuery(sql);
	rsmd = rs.getMetaData();
	
	i = 0;
	while (rs.next())
		i++;
	//�������� ���� ���� ���� i
	rs = stmt.executeQuery(sql);
	rsmd = rs.getMetaData();
	j = 0;
	foodName = "";
	price = 0;
	score = 0;
	i = random.nextInt(i) + 1;
	while(rs.next()){
		j++;
		if(i == j){
			foodName = rs.getString(1);
			price = rs.getInt(2);
			score = rs.getInt(3);
			break;
		}
	}

	out.print("���� �̸� : " + foodName + "<br/>");	
	out.print("���� : " + price + " ��<br/>");
	out.print("���� : " + score + " �� <br/><br/><br/>");	
	out.print("<center> �ְ��� ���� Ī���մϴ�. </center>");	
	
	
		
%>


</div>
	<div id="footer">
		<a href='https://kr.freepik.com/vectors/city'>City ���ʹ� upklyak - kr.freepik.com�� ������</a>
	</div>
</body>
</html>