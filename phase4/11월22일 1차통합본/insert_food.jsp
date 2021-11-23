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
<title>점포 음식 추가</title>
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
				  <span class="title">고객 관리</span>
				</a></li>
				<li><a href="StoreState.jsp">
				  <span class="icon"><img src="image/owner.png" alt="owner" /></span>
				  <span class="title">가게 정보</span>
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
						<span class="text">음식 추가하기</span>
					</div>
					<div class="member_list">
						<form method="post" action="insert_food_ok.jsp">
							<table>
								<tr>
									<th>음식 이름</th>
									<td><input type="text" name="f_name" placeholder="음식 이름" class="txt">
								</tr>
								<tr>
									<th>가격</th>
									<td><input type="text" name="f_price" placeholder="가격" class="txt">
								</tr>
								<tr>
									<th>원산지</th>
									<td><input type="text" name="origin" placeholder="원산지" class="txt">
								</tr>
							</table>
							<input type="submit" value="저장" class="btn">
							<input type="button" value="취소" onclick="history.back();" class="btn">
						</form>
					</div>
				</div>
			</div>		
		</div>
	</div>
</body>
</html>