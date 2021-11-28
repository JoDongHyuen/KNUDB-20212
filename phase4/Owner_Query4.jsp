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
<title>���� ��ȸ</title>
</head>
<body>

<script type="text/javascript">
    $(document).ready(function () {
            $.datepicker.setDefaults($.datepicker.regional['ko']); 

            $( "#endDate" ).datepicker({
                 changeMonth: true, 
                 changeYear: true,
                 nextText: '���� ��',
                 prevText: '���� ��', 
                 dayNames: ['�Ͽ���', '������', 'ȭ����', '������', '�����', '�ݿ���', '�����'],
                 dayNamesMin: ['��', '��', 'ȭ', '��', '��', '��', '��'], 
                 monthNamesShort: ['1��','2��','3��','4��','5��','6��','7��','8��','9��','10��','11��','12��'],
                 monthNames: ['1��','2��','3��','4��','5��','6��','7��','8��','9��','10��','11��','12��'],
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
			<div class="main-title">Ư�� ��¥ ���� ���� ��ȸ</div>
			<div class="main_contents">
				<div class="member_category">
					<div class="title">
						<span class="text"><%=store_name %></span>
					</div>
					<div class="member_list">
						<form method="post" action="Owner_Query4.jsp" class="query_frm">
							<table>
								<tr>
									<th>��¥</th>
									<td><input type="text" name="date" id="endDate"	class="txt" placeholder="Click!">
									<input type="submit" value="��ȸ" class="btn">
								</tr>
							</table>
						</form>
						<table class="member_entity">
							<thead>
								<tr>
									<th style="width: 100px">�� ��</th>
									<th style="width: 100px">��¥	</th>
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