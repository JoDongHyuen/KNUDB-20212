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
						<span class="text">판매 음식이 모두 특정 원산지인 가게 조회</span>
					</div>
					<div class="member_list">
						<form method="post" action="Search_Query7.jsp" class="query_frm" >
							<table>
								<tr>
									<th>원산지 선택</th>
									<td><select name="origin" class="txt" id="sel">
										<option value="한국">한국</option>
										<option value="캐나다">캐나다</option>
										<option value="일본">일본</option>
										<option value="벨기에">벨기에</option>
										<option value="러시아">러시아</option>
										<option value="독일">독일</option>
										<option value="칠레">칠레</option>
										<option value="미국">미국</option>
										<option value="프랑스">프랑스</option>
										<option value="영국">영국</option>
										<option value="대만">대만</option>
										<option value="중국">중국</option>
										<option value="호주">호주</option>
										<option value="베트남">베트남</option>
										<option value="필리핀">필리핀</option>
									</select></td>
									<td><input type="submit" value="조회" class="btn"></td>
								</tr>
							</table>
						</form>
						<table class="member_entity">
							<thead>
								<tr>
									<th style="width: 100px">가게 명</th>
									<th style="width: 100px">주소</th>
								</tr>
							</thead>
							<%
							
								try{
									String origin = new String(request.getParameter("origin").getBytes("8859_1"),"KSC5601");   
									String sql = "SELECT Store_name, Location " + "FROM STORE S " + "WHERE NOT EXISTS( " + "        SELECT F.Id "
											+ "        FROM  FOOD F " + "        WHERE F.Bnum = S.Breg_number " + "        MINUS "
											+ "        SELECT O.Id " + "        FROM ORIGIN O " + "        WHERE O.Country_name = ?" + "        )";
									PreparedStatement ps = conn.prepareStatement(sql);
				
									ps.setString(1, origin);
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