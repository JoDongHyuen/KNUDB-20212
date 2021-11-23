<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language = "java" import = "java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="css/navigation.css" />
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
%>

<div class="container">
		<div class="navigation">
			<div class="logo">
				<b>DataBase</b>
			</div>
			<ul>
				<li><a href="AdminCustomer.jsp">
				  <span class="icon"><img src="image/customer.png" alt="customer" /></span>
				  <span class="title">�� ����</span>
				</a></li>
				<li><a href="StoreState.jsp">
				  <span class="icon"><img src="image/owner.png" alt="owner" /></span>
				  <span class="title">���� ����</span>
				</a></li>
				<li><a href="logout.jsp">
				  <span class="icon"><img src="image/logout.png" alt="logout" /></span>
				  <span class="title">Log Out</span>
				</a></li>
			</ul>
		</div>
		<div class="main">
			<div class="top">Hello World!</div>
			<div class="main-title">���� ����</div>
			<div class="main_contents">
				<div class="member_category">
					<div class="title">
						<span class="text">���� �߰��ϱ�</span>
					</div>
					<div class="member_list">
						<form method="post" action="insert_drink_ok.jsp">
							<table>
								<tr>
									<td>���� �̸�</td>
									<td><input type="text" name="d_name" placeholder="���� �̸�" class="txt">
								</tr>
								<tr>
									<td>����</td>
									<td><input type="text" name="d_price" placeholder="����" class="txt">
								</tr>
								<tr>
									<td>�� ����</td>
									<td><input type="radio" name="alcohol" value="Y">Y
									<td><input type="radio" name="alcohol" value="N">N
								</tr>
							</table>
							<input type="submit" value="����" class="btn">
							<input type="button" value="���" onclick="history.back();" class="btn">
						</form>
					</div>
				</div>
			</div>		
		</div>
	</div>
</body>
</html>