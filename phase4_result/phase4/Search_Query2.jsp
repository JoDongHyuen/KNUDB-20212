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
				  <span class="title">Ư�� ����<br> ���� ���� ��ȸ</span>
				</a></li>
				<li><a href="Search_Query2.jsp">
				  <span class="title">�� Ư��<br> ���� �̻� ���� ��ȸ</span>
				</a></li>
				<li><a href="Search_Query3.jsp">
				  <span class="title">��� ���� �̻�<br> ���� ��ȸ</span>
				</a></li>
				<li><a href="Search_Query4.jsp">
				  <span class="title">Ư�� ���� �ִ�<br> ���� ��ȸ</span>
				</a></li>
				<li><a href="Search_Query5.jsp">
				  <span class="title">�ַ��� �ִ�<br> ���� ��ȸ</span>
				</a></li>
				<li><a href="Search_Query6.jsp">
				  <span class="title">Ư�� ������<br> ���� ��ȸ</span>
				</a></li>
				<li><a href="Search_Query7.jsp">
				  <span class="title">�Ǹ� ������ ���<br> Ư�� �������� ���� ��ȸ</span>
				</a></li>
				<li><a href="Search_Query8.jsp">
				  <span class="title">�Ǹ� ���ᰡ ��� �ַ�<br> �Ǵ� ������� ���� �̸� ��ȸ</span>
				</a></li>
				<li><a href="Search_Query9.jsp">
				  <span class="title">Ư�� ���� �̻�<br> ������ �ִ� ���� ��ȸ</span>
				</a></li>
			</ul>
		</div>
		<div class="main">
			<div class="top"></div>
			<div class="main-title">SEARCH</div>
			<div class="main_contents">
				<div class="member_category">
					<div class="title">
						<span class="text">�� Ư�� ���� �̻� ���� ��ȸ</span>
					</div>
					<div class="member_list">
						<form method="post" action="Search_Query2.jsp" class="query_frm">
							<table>
								<tr>
									<th>�� ����</th>
									<td><input type="text" name="cnt" placeholder="����" class="txt">
									<input type="submit" value="��ȸ" class="btn">
								</tr>
							</table>
						</form>
						<table class="member_entity">
							<thead>
								<tr>
									<th style="width: 100px">���� ��</th>
									<th style="width: 100px">���� ����</th>
								</tr>
							</thead>
							<%
							
								try{
									int price = Integer.parseInt(request.getParameter("cnt"));
									String sql = "SELECT Store_name, COUNT(*) AS Rating_Num " + "FROM STORE, RATING " + "WHERE Breg_number = Bnum "
											+ "GROUP BY Store_name " + "HAVING COUNT(*) >= ? ORDER BY Rating_Num";
									PreparedStatement ps = conn.prepareStatement(sql);
									ps.setInt(1, price);
									ResultSet rs = ps.executeQuery();

									while(rs.next()){
										out.println("<tr>");
										out.println("<td style='width: 100px'>"+rs.getString(1)+"</td>");
										out.println("<td style='width: 100px'>"+rs.getInt(2)+"</td>");
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