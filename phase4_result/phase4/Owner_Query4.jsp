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
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<title>예약 조회</title>
</head>
<body>

<script type="text/javascript">
    $(document).ready(function () {
            $.datepicker.setDefaults($.datepicker.regional['ko']); 

            $( "#endDate" ).datepicker({
                 changeMonth: true, 
                 changeYear: true,
                 nextText: '다음 달',
                 prevText: '이전 달', 
                 dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
                 dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
                 monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                 monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                 dateFormat: "yy-m-dd",
            });    
    });
</script>
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
				<li><a href="homepage.jsp">
				  <span class="icon"><img src="image/logout.png" alt="undo" /></span>
				  <span class="title">뒤로가기</span>
				</a></li>
			</ul>
		</div>
	
		<div class="main">
			<div class="top"></div>
			<div class="main-title">특정 날짜 이후 예약 조회</div>
			<div class="main_contents">
				<div class="member_category">
					<div class="title">
						<span class="text"><%=store_name %></span>
					</div>
					<div class="member_list">
						<form method="post" action="Owner_Query4.jsp" class="query_frm">
							<table>
								<tr>
									<th>날짜</th>
									<td><input type="text" name="date" id="endDate"	class="txt" placeholder="Click!">
									<input type="submit" value="조회" class="btn">
								</tr>
							</table>
						</form>
						<table class="member_entity">
							<thead>
								<tr>
									<th style="width: 100px">고객 명</th>
									<th style="width: 100px">날짜	</th>
								</tr>
							</thead>
							<%
								userId=" "+userId;
								
								try{
									String date = request.getParameter("date");
									sql = "SELECT C.Fname, C.Lname, TO_CHAR(B.Time, 'YYYY-MM-DD HH24:MI:SS') as B_date "
										  + " FROM CUSTOMER C,  CUST_BOOKS_STR B, OWNER O "
										  + " WHERE B.Time > ?  AND C.Customer_email = B.Cemail "
										  + " AND O.Owner_email = ? and O.Bnum = B.Bnum "
										  + " ORDER BY B.time";
									
									ps = conn.prepareStatement(sql);
									ps.setString(1, date);
									ps.setString(2, userId);
									rs = ps.executeQuery();
									while(rs.next()){
										out.println("<tr>");
										out.println("<td style='width: 100px'>"+rs.getString(1)+ rs.getString(2) +"</td>");
										out.println("<td style='width: 100px'>"+rs.getString(3)+"</td>");
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