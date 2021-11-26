<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language = "java" import = "java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%

	String serverIP = "localhost";
	String strSID = "orcl";
	String portNum = "1521";
	String user = (String)session.getAttribute("DBID");
	String pass = (String)session.getAttribute("DBPW");
	String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;

	Connection conn = null;
	PreparedStatement pstmt;
	Statement stmt = null;
	ResultSet rs, rs2, rs3;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	
	String email = new String(request.getParameter("email").getBytes("8859_1"), "EUC-KR");
	String gender = new String(request.getParameter("gender"));
	String fname = new String(request.getParameter("fullName").getBytes("8859_1"), "EUC-KR");
	String age = request.getParameter("age"); // 라디오버튼이 안넘어가므로 그냥 text로 만들기
	String typeOfP = new String(request.getParameter("typeOfP"));
	String phone = request.getParameter("phone");
	String passWord = request.getParameter("passWord");
	String passWord2 = request.getParameter("passWord2");
	
	String sql = "select Email from information";
	stmt = conn.createStatement();
	rs = stmt.executeQuery(sql);
	
	
	int flag = 0; // 겹치는 것 있으면 1, 이메일 없는 경우 2, fname 없는 경우 3, lname 없는 경우 4, 나이 없는 경우 5
	if(email.length() == 0){ 	//	전번 없는경우 6, 비밀번호 일치하지 않는 경우 7 비밀번호 안친 경우
		flag = 2;
	}
	else if (!(email.substring(email.length() - 4, email.length()).equals(".com"))) {
		//System.out.println("e-mail 형식에 맞지 않습니다. 다시 입력해주세요.");
		flag = -1;
	}
	if(fname.length() == 0) flag = 3;
	//if(lname == null) flag = 4;
	if(age.length() == 0) flag = 5;
	if(phone.length() == 0) flag = 6;
	if(!(passWord.equals(passWord2))){
		flag = 7;
	}
	if(passWord.length() == 0 || passWord2.length() == 0){
		flag = 8;
	}
	while(rs.next()){
		String e = rs.getString(1);
		e = e.substring(1, e.length());
		if(e.equals(email)){
			flag = 1;
			break;
		}
	}
	
	int a = 0;
	
	if(flag == 1){
		
		out.println("<script type='text/javascript'>");
		out.println("alert('이메일 중복됩니다. 사용불가능.');");
		out.println("history.back();");
		out.println("</script>");		
		
		session.setAttribute("flag", flag);
		//response.sendRedirect("register.jsp");
	
	}
	else if(flag == 8){
		out.println("<script type='text/javascript'>");
		out.println("alert('비밀번호를 입력하세요');");
		out.println("history.back();");
		out.println("</script>");
	}
	else if(flag == 2){
		out.println("<script type='text/javascript'>");
		out.println("alert('이메일을 입력해주세요!');");
		out.println("history.back();");
		out.println("</script>");		
		
		
		//response.sendRedirect("register.jsp");
		
	}
	else if(flag == -1){
		out.println("<script type='text/javascript'>");
		out.println("alert('이메일 형식에 맞지 않습니다!');");
		out.println("history.back();");
		out.println("</script>");	
		
	}
	else if(flag == 3){
		out.println("<script type='text/javascript'>");
		out.println("alert('이름을 입력하세요!');");
		out.println("history.back();");
		out.println("</script>");
	}
	else if(flag == 4){ // 그냥 일단 놔둠 필요없긴한데
		out.println("<script type='text/javascript'>");
		out.println("alert('이름을 입력하세요!');");
		out.println("history.back();");
		out.println("</script>");
	}
	else if(flag == 5){
		out.println("<script type='text/javascript'>");
		out.println("alert('나이를 입력하세요!');");
		out.println("history.back();");
		out.println("</script>");
	}
	else if(flag == 6){
		out.println("<script type='text/javascript'>");
		out.println("alert('전화번호를 입력하세요!');");
		out.println("history.back();");
		out.println("</script>");
	}
	else if(flag == 7){
		out.println("<script type='text/javascript'>");
		out.println("alert('비밀번호가 일치하지 않습니다');");
		out.println("history.back();");
		out.println("</script>");
	}
	else{
		email = " " + email;
		//typeOfP = "customer"; gender = "male";
		if(typeOfP.equals("customer")){
			String query = "insert into information values('"
					+ email + "', '" + passWord + "', 'customer')";
			int res = stmt.executeUpdate(query);
					
					
					
			query = "insert into customer values ('"
					+ fname.substring(0,1) + "', '"
					+ fname.substring(1,3) + "', '"
					+ phone + "', '" + email + "', '"
					+ gender + "', " + age + ")";
			
			res = stmt.executeUpdate(query);
			stmt.close();
			conn.close();
			
			out.println("<script type='text/javascript'>");
			out.println("alert('회원가입완료');");
			out.println("history.go(-2);");
			out.println("alert('회원가입완료');");
			out.println("</script>");
		}
		else{
			String query = "insert into information values('"
					+ email + "', '" + passWord + "', 'owner')";
			int res = stmt.executeUpdate(query);
			
			query = "select COUNT(*) from STORE";
			rs = stmt.executeQuery(query);
			int lastNum = 0;
			while(rs.next()){	
				lastNum = rs.getInt(1);
				break;
			}
			lastNum++;
			//store 에 미리 breg_number 추가 -> 무결성 위약조건 때문에
			query = "insert into store values (" + lastNum
					+ ", 'k', 'k', 44, 'k')"; // 일단 아무 숫자, 값 넣음 -> update 할때는 이것을 update 함
			res = stmt.executeUpdate(query);
			
			
			query = "insert into owner values (" + lastNum + ", '"
					+ fname.substring(0,1) + "', '"
					+ fname.substring(1,3) + "', '"
					+ phone + "', '" + email + "', '"
					+ gender + "', " + age + ")";
			
			res = stmt.executeUpdate(query);
			stmt.close();
			conn.close();
			
			out.println("<script type='text/javascript'>");
			out.println("alert('회원가입완료');");
			out.println("history.go(-2);");
			out.println("alert('회원가입완료');");
			out.println("</script>");
			
		}
		

		response.sendRedirect("homepage.jsp");
	}
	
	
	
%>



</body>
</html>