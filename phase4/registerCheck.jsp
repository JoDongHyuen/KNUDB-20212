<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language = "java" import = "java.text.*, java.sql.*, java.util.*" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	PrintWriter script = response.getWriter();

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
		
		script.println("<script type='text/javascript'>");
		script.println("alert('�̸��� �ߺ��˴ϴ�. ���Ұ���.');");
		script.println("history.back();");
		script.println("</script>");		
		
		session.setAttribute("flag", flag);
		//response.sendRedirect("register.jsp");
	
	}
	else if(flag == 8){
		script.println("<script type='text/javascript'>");
		script.println("alert('��й�ȣ�� �Է��ϼ���');");
		script.println("history.back();");
		script.println("</script>");
	}
	else if(flag == 2){
		script.println("<script type='text/javascript'>");
		script.println("alert('�̸����� �Է����ּ���!');");
		script.println("history.back();");
		script.println("</script>");		
		
		
		//response.sendRedirect("register.jsp");
		
	}
	else if(flag == -1){
		script.println("<script type='text/javascript'>");
		script.println("alert('�̸��� ���Ŀ� ���� �ʽ��ϴ�!');");
		script.println("history.back();");
		script.println("</script>");	
		
	}
	else if(flag == 3){
		script.println("<script type='text/javascript'>");
		script.println("alert('�̸��� �Է��ϼ���!');");
		script.println("history.back();");
		script.println("</script>");
	}
	else if(flag == 4){ // �׳� �ϴ� ���� �ʿ�����ѵ�
		script.println("<script type='text/javascript'>");
		script.println("alert('�̸��� �Է��ϼ���!');");
		script.println("history.back();");
		script.println("</script>");
	}
	else if(flag == 5){
		script.println("<script type='text/javascript'>");
		script.println("alert('���̸� �Է��ϼ���!');");
		script.println("history.back();");
		script.println("</script>");
	}
	else if(flag == 6){
		script.println("<script type='text/javascript'>");
		script.println("alert('��ȭ��ȣ�� �Է��ϼ���!');");
		script.println("history.back();");
		script.println("</script>");
	}
	else if(flag == 7){
		script.println("<script type='text/javascript'>");
		script.println("alert('��й�ȣ�� ��ġ���� �ʽ��ϴ�');");
		script.println("history.back();");
		script.println("</script>");
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
			
			script.println("<script type='text/javascript'>");
			script.println("alert('ȸ�����ԿϷ�');");
			script.println("history.go(-2);");
			script.println("alert('ȸ�����ԿϷ�');");
			script.println("</script>");
		}
		else{
			conn.setAutoCommit(false);//transaction �߰�
			
			try{
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
				//store �� �̸� breg_number �߰� -> ���Ἲ �������� ������
				query = "insert into store values (" + lastNum
						+ ", '���� �̸� �Է�', '', 0, '�ּ� �Է�')"; // �ϴ� �ƹ� ����, �� ���� -> update �Ҷ��� �̰��� update ��
				res = stmt.executeUpdate(query);
				
				
				query = "insert into owner values (" + lastNum + ", '"
						+ fname.substring(0,1) + "', '"
						+ fname.substring(1,3) + "', '"
						+ phone + "', '" + null + "', '"
						+ gender + "', " + age + ")";
				
				res = stmt.executeUpdate(query);
				
				conn.commit();//transaction �߰�
				conn.setAutoCommit(true);
				
				script.println("<script type='text/javascript'>");
				script.println("alert('ȸ�����ԿϷ�');");
				script.println("history.go(-2);");
				script.println("</script>");
				script.flush();
			}
			
			catch(Exception e){
				conn.rollback(); //trnasaction rollback �߰�
				script.println("<script type='text/javascript'>");
				script.println("alert('ȸ�����Խ���');");
				script.println("history.go(-1);");
				script.println("</script>");
				script.flush();
				e.printStackTrace();
			}
			
			finally{
				stmt.close();
				conn.close();
				rs.close();
			}
		}
	}
	
	
	
%>



</body>
</html>