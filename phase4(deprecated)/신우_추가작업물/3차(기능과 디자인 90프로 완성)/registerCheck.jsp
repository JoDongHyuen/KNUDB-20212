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
	String user = "restaurant";
	String pass = "restaurant";
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
	String age = request.getParameter("age"); // ������ư�� �ȳѾ�Ƿ� �׳� text�� �����
	String typeOfP = new String(request.getParameter("typeOfP"));
	String phone = request.getParameter("phone");
	String passWord = request.getParameter("passWord");
	String passWord2 = request.getParameter("passWord2");
	
	String sql = "select Email from information";
	stmt = conn.createStatement();
	rs = stmt.executeQuery(sql);
	
	
	int flag = 0; // ��ġ�� �� ������ 1, �̸��� ���� ��� 2, fname ���� ��� 3, lname ���� ��� 4, ���� ���� ��� 5
	if(email.length() == 0){ 	//	���� ���°�� 6, ��й�ȣ ��ġ���� �ʴ� ��� 7 ��й�ȣ ��ģ ���
		flag = 2;
	}
	else if (!(email.substring(email.length() - 4, email.length()).equals(".com"))) {
		//System.out.println("e-mail ���Ŀ� ���� �ʽ��ϴ�. �ٽ� �Է����ּ���.");
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
		out.println("alert('�̸��� �ߺ��˴ϴ�. ���Ұ���.');");
		out.println("history.back();");
		out.println("</script>");		
		
		session.setAttribute("flag", flag);
		//response.sendRedirect("register.jsp");
	
	}
	else if(flag == 8){
		out.println("<script type='text/javascript'>");
		out.println("alert('��й�ȣ�� �Է��ϼ���');");
		out.println("history.back();");
		out.println("</script>");
	}
	else if(flag == 2){
		out.println("<script type='text/javascript'>");
		out.println("alert('�̸����� �Է����ּ���!');");
		out.println("history.back();");
		out.println("</script>");		
		
		
		//response.sendRedirect("register.jsp");
		
	}
	else if(flag == -1){
		out.println("<script type='text/javascript'>");
		out.println("alert('�̸��� ���Ŀ� ���� �ʽ��ϴ�!');");
		out.println("history.back();");
		out.println("</script>");	
		
	}
	else if(flag == 3){
		out.println("<script type='text/javascript'>");
		out.println("alert('�̸��� �Է��ϼ���!');");
		out.println("history.back();");
		out.println("</script>");
	}
	else if(flag == 4){ // �׳� �ϴ� ���� �ʿ�����ѵ�
		out.println("<script type='text/javascript'>");
		out.println("alert('�̸��� �Է��ϼ���!');");
		out.println("history.back();");
		out.println("</script>");
	}
	else if(flag == 5){
		out.println("<script type='text/javascript'>");
		out.println("alert('���̸� �Է��ϼ���!');");
		out.println("history.back();");
		out.println("</script>");
	}
	else if(flag == 6){
		out.println("<script type='text/javascript'>");
		out.println("alert('��ȭ��ȣ�� �Է��ϼ���!');");
		out.println("history.back();");
		out.println("</script>");
	}
	else if(flag == 7){
		out.println("<script type='text/javascript'>");
		out.println("alert('��й�ȣ�� ��ġ���� �ʽ��ϴ�');");
		out.println("history.back();");
		out.println("</script>");
	}
	else{
		email = " " + email;
		//typeOfP = "customer"; gender = "male";
		if(typeOfP == "customer"){
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
			out.println("alert('ȸ�����ԿϷ�');");
			out.println("history.go(-2);");
			out.println("alert('ȸ�����ԿϷ�');");
			out.println("</script>");
		}
		else{
			String query = "insert into information values('"
					+ email + "', '" + passWord + "', 'owner')";
			int res = stmt.executeUpdate(query);
			
			query = "select Bnum from owner order by Bnum asc";
			rs = stmt.executeQuery(query);
			int lastNum = 0;
			while(rs.next()){	
				lastNum = rs.getInt(1);
			}
			lastNum++;
			//store �� �̸� breg_number �߰� -> ���Ἲ �������� ������
			query = "insert into store values (" + lastNum
					+ ", 'k', 'k', 44, 'k')"; // �ϴ� �ƹ� ����, �� ���� -> update �Ҷ��� �̰��� update ��
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
			out.println("alert('ȸ�����ԿϷ�');");
			out.println("history.go(-2);");
			out.println("alert('ȸ�����ԿϷ�');");
			out.println("</script>");
			
		}
		

		response.sendRedirect("homepage.jsp");
	}
	
	
	
%>



</body>
</html>