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
	String url = "jdbc:oracle:thin:@" + serverIP + ":"
	+ portNum + ":" + strSID;
	
	Connection conn = null;
	PreparedStatement pstmt;
	Statement stmt = null;
	ResultSet rs;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	
	String cmpId = request.getParameter("id");
	String passWord = request.getParameter("passWord");
	
	//cmpId = " " + compId; // ����ó��
	String sql = "select * from information";
	
	
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	String type = "";
	int flag = 0; // flag 1 -> �α��� ���� ��ġ // flag 2 -> �α��� ���� ����ġ
					// flag 0 -> ���̵� ����
	while (rs.next()) { // �̸��� �� ó���� ������ ������ ����
		String id = rs.getString(1);
		String pw = rs.getString(2);
		type = rs.getString(3);
		String newId = "";
		int i = 0;
		
		id= id.substring(1, id.length());
		
		if (cmpId.equals(id)) {
			if (pw.equals(passWord))
				flag = 1;
			else
				flag = 2;
			break;
		}
		
	}
	if (flag == 0) { // ���̵� ����
		response.sendRedirect("homepage.html");
	} else if (flag == 1) { // �α��� ����
		if(type.equals("customer"))
			response.sendRedirect("customer.html");
		else if(type.equals("owner"))
			response.sendRedirect("owner.html");
		else
			response.sendRedirect("admin.html");
			

	} else if (flag == 2) { // �α��� ���� ����ġ
		response.sendRedirect("homepage.html");
	}
	
	out.println("hello world");
%>



</body>
</html>