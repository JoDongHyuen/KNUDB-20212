package phase3;

import java.sql.*;
import java.io.*;
import java.util.Scanner;

public class phase3 {
	public static final String URL = "jdbc:oracle:thin:@localhost:1521:orcl";
	public static final String USER_COMPANY = "restaurant";
	public static final String USER_PASSWD = "restaurant";

	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub
		Scanner scan = new Scanner(System.in);
		Connection conn = null;
		Statement stmt = null;

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("Driver Loading: Success!");
		} catch (ClassNotFoundException e) {
			System.err.println("error = " + e.getMessage());
			System.exit(1);
		}

		try {
			conn = DriverManager.getConnection(URL, USER_COMPANY, USER_PASSWD);
			stmt = conn.createStatement();
			System.out.println("Oracle Connected");
		} catch (SQLException ex) {
			ex.printStackTrace();
			System.err.println("Cannot get a connection: " + ex.getLocalizedMessage());
			System.err.println("Cannot get a connection: " + ex.getMessage());
			System.exit(1);
		}

		int login_type;
		login_type = login(scan);

		switch (login_type) {
		case 1:
			Owner.ownerFunction(conn, stmt, scan);
			break;
		case 2:
			Customer.customerFunction(conn, stmt, scan);
			break;
		case 3:
			Admin.adminQuery(conn, stmt, scan);
			break;
		}
		
		try {
			stmt.close();
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


	} // main end bracket

	public static int login(Scanner scan) {
		System.out.println("로그인할 계정을 선택해주세요. 1) OWNER 2) CUSTOMER 3) ADMINISTRATOR");
		int login_type = scan.nextInt();
		return login_type;

	}

}
