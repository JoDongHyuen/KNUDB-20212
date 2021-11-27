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
<title>가게 정보</title>
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
	
	String sql="select store_name, store_type, seat_number, location from store where breg_number = ?";
	PreparedStatement ps = conn.prepareStatement(sql);
	ps.setInt(1, bnum);
	ResultSet rs = ps.executeQuery();
	
	String store_name=null, store_type=null, location=null;
	int seat_number=0, flag=0;
	
	while(rs.next()){
		store_name = rs.getString(1);
		store_type = rs.getString(2);
		seat_number = rs.getInt(3);
		location = rs.getString(4);
	}
	
	sql = "select price, food_name, id from food where bnum=?";
	ps = conn.prepareStatement(sql);
	ps.setInt(1, bnum);
	rs = ps.executeQuery();
	String[] f_name = new String[100], origin = new String[100];
	int[] f_price = new int[100], f_id = new int[100];
	int f_count=0, n=0;
	
	while(rs.next()){
		f_price[f_count]=rs.getInt(1);
		f_name[f_count]=rs.getString(2);
		f_id[f_count]=rs.getInt(3);
		f_count++;
	}
	
	for(int i=0; i<f_count; i++){
		sql = "select country_name from origin where id=?";
		ps = conn.prepareStatement(sql);
		ps.setInt(1, f_id[i]);
		rs = ps.executeQuery();
		
		while(rs.next())
			origin[i] = rs.getString(1);
	}
	
	sql = "select price, drink_name, alcohol, id from beverage where bnum=?";
	ps = conn.prepareStatement(sql);
	ps.setInt(1, bnum);
	rs = ps.executeQuery();
	String[] d_name = new String[100], alcohol = new String[100];
	int[] d_price = new int[100], d_id = new int[100];
	int d_count=0;
	
	while(rs.next()){
		d_price[d_count]=rs.getInt(1);
		d_name[d_count]=rs.getString(2);
		alcohol[d_count]=rs.getString(3);
		d_id[d_count]=rs.getInt(4);
		
		d_count++;
	}
	
	rs.close();
	stmt.close();
	conn.close();

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
			<div class="top">Hello World!</div>
			<div class="main-title">가게 정보</div>
			<div class="main_contents">
				<div class="member_category">
					<div class="title">
						<span class="text">가게 정보 수정</span>
					</div>
					<form method="post" action="updateStore_ok.jsp" id="frm" class="frm_store">
						<table class="tab">
							<tr>
								<th>가게 명: </th>
								<td><input type="text" name="store_name" value="<%=store_name %>" class="txt"></td>
							</tr>
							
							<tr>
								<th>가게 타입: </th>
								<td>
									<select name="store_type" id="s_type" class="txt">
										<option value="general">일반음식점</option>
										<option value="rest">휴게음식점</option>
										<option value="bread">제과점영업</option>
									</select>
								</td>
							</tr>
							
							<tr>
								<th>좌석 수: </th>
								<td><input type="text" name="seat_number" value="<%=seat_number %>" class="txt"></td>
							</tr> 
							
							<tr>
								<th>주소: </th>
								<td><input type="text" name="location" value="<%=location %>" class="location"></td>
							</tr> 
				
						</table>
						<input type="submit" value="수정" class="btn">
					</form>
					
				</body>
				
				<div class="food_drink">
					<table class="frm_food">
							<tr>
								<th></th>
								<th>음식 명</th>
								<th>가격</th>
								<th>원산지</th>
							</tr>	
							<% for(int j=0; j<f_count; j++) {%>
								<form method="post" id="updateOrDeleteFrm" >	
									<tr>
										<td><input type="hidden" name="f_id" value="<%=f_id[j] %>"></td>
										<td><input type="text" name="f_name" value="<%=f_name[j] %>" class="txt"></td>
										<td><input type="text" name="f_price" value="<%=f_price[j] %>" class="txt"></td>
										<td><input type="text" name="origin" value="<%=origin[n] %>" class="txt"></td>
										
										<td>
										<input type="submit" value="저장" formaction="update_food.jsp" class="btn">
										<input type="submit" value="삭제" formaction="delete_food.jsp" class="btn">
										</td>
									</tr>
								</form>
							<%n++;} %>
						</table>
						
						<input type="button" onclick="location.href='insert_food.jsp'" value="음식 추가하기" class="btn_insert">
						
						<table class="frm_drink">
							<tr>
								<% 
									if(d_count != 0){
										out.println("<th></th>");	
										out.println("<th>음료 명</th>");
										out.println("<th>가격</th>");
										out.println("<th>주류 여부(Y or N)</th>");
									}
								%>
							</tr>
							<% for(int j=0; j<d_count; j++) {
								if(d_price[j] != 0) { %>
									<form method="post" id="updateOrDeleteFrm">
										<tr>
											<td><input type="hidden" name="d_id" value="<%=d_id[j] %>" class="txt"></td>
											<td><input type="text" name="d_name" value="<%=d_name[j] %>" class="txt"></td>
											<td><input type="text" name="d_price" value="<%=d_price[j] %>" class="txt"></td>
											<td><input type="text" name="alcohol" value="<%=alcohol[j] %>" class="txt"></td>
											<td>
												<input type="submit" formaction="update_drink.jsp" value="저장" class="btn">
												<input type="submit" formaction="delete_drink.jsp" value="삭제" class="btn">
											</td>
										</tr>
									</form>
							<%}} %>
						</table>
						<input type="button" onclick="location.href='insert_drink.jsp'" value="음료 추가하기" class="btn_insert">
						
					</div>
				</div>
			</div>
		</div>
	</div>	
	<script type="text/javascript">
	function fnUserModify(pageUrl) { 
		var frm = document.getElementById("updateOrDeleteFrm");
		frm.action = pageUrl;
		frm.submit(); 
	} 
</script>
</html>