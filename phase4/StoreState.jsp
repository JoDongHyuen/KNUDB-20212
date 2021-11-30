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
<title>���� ����</title>
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
						<span class="text">���� ���� ����</span>
					</div>
					<form method="post" action="updateStore_ok.jsp" id="frm" class="frm_store">
						<table class="tab">
							<tr>
								<th>���� ��: </th>
								<td><input type="text" name="store_name" value="<%=store_name %>" class="txt"></td>
							</tr>
							
							<tr>
								<th>���� Ÿ��: </th>
								<td>
									<select name="store_type" id="s_type" class="txt">
										<option value="general">�Ϲ�������</option>
										<option value="rest">�ް�������</option>
										<option value="bread">����������</option>
									</select>
								</td>
							</tr>
							
							<tr>
								<th>�¼� ��: </th>
								<td><input type="text" name="seat_number" value="<%=seat_number %>" class="txt"></td>
							</tr> 
							
							<tr>
								<th>�ּ�: </th>
								<td><input type="text" name="location" value="<%=location %>" class="location"></td>
							</tr> 
				
						</table>
						<input type="submit" value="����" class="btn">
					</form>
					
				<div class="food_drink">
					<table class="frm_food">
							<tr>
							<% 
								if(f_count != 0){
									out.println("<th></th>");
									out.println("<th>���� ��</th>");
									out.println("<th>����</th>");
									out.println("<th>������</th>");
								}
							%>
							</tr>	
							<% for(int j=0; j<f_count; j++) {%>
								<form method="post" id="updateOrDeleteFrm" >	
									<tr>
										<td><input type="hidden" name="f_id" value="<%=f_id[j] %>"></td>
										<td><input type="text" name="f_name" value="<%=f_name[j] %>" class="txt"></td>
										<td><input type="text" name="f_price" value="<%=f_price[j] %>" class="txt"></td>
										<td><input type="text" name="origin" value="<%=origin[n] %>" class="txt"></td>
										
										<td>
										<input type="submit" value="����" formaction="update_food.jsp" class="btn">
										<input type="submit" value="����" formaction="delete_food.jsp" class="btn">
										</td>
									</tr>
								</form>
							<%n++;} %>
						</table>
						
						<input type="button" onclick="location.href='insert_food.jsp'" value="���� �߰��ϱ�" class="btn_insert">
						
						<table class="frm_drink">
							<tr>
								<% 
									if(d_count != 0){
										out.println("<th></th>");	
										out.println("<th>���� ��</th>");
										out.println("<th>����</th>");
										out.println("<th>�ַ� ����(Y or N)</th>");
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
												<input type="submit" formaction="update_drink.jsp" value="����" class="btn">
												<input type="submit" formaction="delete_drink.jsp" value="����" class="btn">
											</td>
										</tr>
									</form>
							<%}} %>
						</table>
						<input type="button" onclick="location.href='insert_drink.jsp'" value="���� �߰��ϱ�" class="btn_insert">
						
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
</body>
</html>