<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="css/navigation.css" />
<link rel="stylesheet" href="css/main.css" />
</head>
<body>
	<div class="container">
		<div class="navigation">
			<div class="logo">
				<b>DataBase</b>
			</div>
			<ul>
				<li><a href="#">
				  <span class="icon"><img src="image/customer.png" alt="customer" /></span>
				  <span class="title">�� ����</span>
				</a></li>
				<li><a href="/admin_member">
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
			<div class="main-title">�� ����</div>
			<div class="main_contents">
				<div class="member_category">
					<div class="title">
						<span class="text">ȸ�� ���</span>
					</div>
					<div class="member_list">
						<table class="member_entity">
							<thead>
								<tr>
									<th>�̸�</th>
									<th>��ȭ��ȣ</th>
									<th>�̸���</th>
									<th>����</th>
									<th>����</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>		
		</div>
	</div>
</body>
</html>