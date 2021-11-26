<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language = "java" import = "java.text.*, java.sql.*, java.util.*" %>
<%
	if(request.getParameter("uid")!=null)
	{
		int id = Integer.parseInt(request.getParameter("uid"));
		
		String serverIP = "localhost";
		String strSID = "orcl";
		String portNum = "1521";
		String user = (String)session.getAttribute("DBID");
		String pass = (String)session.getAttribute("DBPW");
		String url = "jdbc:oracle:thin:@" + serverIP + ":"
		+ portNum + ":" + strSID;
		
		Connection conn = null;
		PreparedStatement pstmt, pstmt2, pstmt3;
		ResultSet rs, rs2, rs3;
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, user, pass);
		
		String sql="select * from store where breg_number=" + id;
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		
		sql="select * from food where bnum=" + id;
		
		while(rs.next())
			{
				%>
				<div class="row">
					<div class="col-3 p-3 mb-2 bg-primary text-white">
						가게명
					</div>
					<div class="col-9 p-3 mb-2 bg-light text-dark">
						<%= rs.getString(2) %>
					</div>
				</div>
				<div class="row">
					<div class="col-3 p-3 mb-2 bg-primary text-white">
						가게종류
					</div>
					<div class="col-9 p-3 mb-2 bg-light text-dark">
						<%= rs.getString(3) %>
					</div>
				</div>
				<div class="row">
					<div class="col-3 p-3 mb-2 bg-primary text-white">
						좌석수
					</div>
					<div class="col-9 p-3 mb-2 bg-light text-dark">
						<%= rs.getInt(4) %>
					</div>
				</div>
				<div class="row">
					<div class="col-3 p-3 mb-2 bg-primary text-white">
						위치
					</div>
					<div class="col-9 p-3 mb-2 bg-light text-dark">
						<%= rs.getString(5) %>
					</div>
				</div>
				<%
			}
		rs.close();
		pstmt.close();
		
		sql="select * from food where bnum=" + id;
		pstmt2 = conn.prepareStatement(sql);
		rs2 = pstmt2.executeQuery();
		
		sql="select * from beverage where bnum=" + id;
		pstmt3 = conn.prepareStatement(sql);
		rs3 = pstmt3.executeQuery();
		%>
		<br/>
		<p class="h4">메뉴판<p>
		<table class="table">
		  <thead>
		    <tr>
		      <th scope="col">Name</th>
		      <th scope="col">Price</th>
		    </tr>
		  </thead>
		  <tbody>
		  <%
		  	while(rs2.next())
		  	{
		  		%>
		  		<tr>
		  			<th><%= rs2.getString(4) %></th>
		  			<th><%= rs2.getInt(3) %></th>
		  		</tr>
		  		<%
		  	}
		  	while(rs3.next())
		  	{
		  		%>
		  		<tr>
		  			<th><%= rs3.getString(4) %></th>
		  			<th><%= rs3.getInt(5) %></th>
		  		</tr>
		  		<%
		  	}
		  %>
		  </tbody>
		</table>
		<%
		rs2.close();
		pstmt2.close();
		rs3.close();
		pstmt3.close();
		conn.close();
	}
%>