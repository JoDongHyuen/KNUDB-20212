package phase3;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

public class Admin {
	
	public static void adminQuery(Connection conn, Statement stmt, Scanner scan) throws IOException {
		
		while(true) {
			
			System.out.println("�������� ��й�ȣ�� �Է����ּ���.");
			String password = scan.next();
			
			try {
				String sql = "SELECT PASS_WORD FROM INFORMATION WHERE EMAIL = 'admin'";
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				rs.next();
				
				String get_password = rs.getString(1);
				if(get_password.equals(password)) {
					System.out.println("�α��� ����");
					break;
				}
				else
					System.out.println("�̸��� �Ǵ� ��й�ȣ�� Ʋ�Ƚ��ϴ�.");
				
			}catch (SQLException e) {
		         e.printStackTrace();
		      }
		}
		// Scanner scan = new Scanner(System.in);
		System.out.println("1. ���̴뺰 �� ����");
		System.out.println("2. Ư���� ���� ���� ��ȸ");
		System.out.println("3. ���� ������ �ִ� ���� ��ȸ");
		System.out.println("4. �ְ� ������ ���� ���� �̸�, ������ ��ȸ");
		System.out.println("5. �ְ� ������ �Ű��� ���� �̸�, ���� ���� ��ȸ");
		System.out.println("6. 30000�� �̻� ������ �ִ� ���� ��ȸ");
		System.out.println("7. �� ���躰 ���� ��� ���� ��ȸ");
		System.out.println("0. ����");

		int num = scan.nextInt();

		try {
			switch (num) {
			case 0:
				break;
			case 1:
				adminQuery1(conn, stmt, scan);
				break;
			case 2:
				adminQuery2(conn, stmt, scan);
				break;
			case 3:
				adminQuery3(conn, stmt, scan);
				break;
			case 4:
				adminQuery4(conn, stmt, scan);
				break;
			case 5:
				adminQuery5(conn, stmt, scan);
				break;
			case 6:
				adminQuery6(conn, stmt, scan);
				break;
			case 7:
				adminQuery7(conn, stmt, scan);
				break;
			}
		} catch (SQLException ex2) {
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}

	// ���̴뺰 �� ���� Type 1-1
	public static void adminQuery1(Connection conn, Statement stmt, Scanner scan) throws SQLException {

		String sql = "SELECT Fname, Lname, Age " + "FROM CUSTOMER " + "WHERE Age BETWEEN ? and ?";
		System.out.println("��ȸ�� ���̴븦 �Է��� �ּ���");
		System.out.print("������ ���� :");
		int from = scan.nextInt();
		System.out.print("���� ���� :");
		int to = scan.nextInt();

		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, Integer.toString(from));
		ps.setString(2, Integer.toString(to));
		ResultSet rs = ps.executeQuery();

		ResultSetMetaData rsmd = rs.getMetaData();
		int cnt = rsmd.getColumnCount();
		for (int i = 1; i <= cnt; i++)
			System.out.print(" | " + rsmd.getColumnName(i));
		System.out.println(" | ");

		while (rs.next()) {
			String Fname = rs.getString(1);
			String Lname = rs.getString(2);
			int Age = rs.getInt(3);
			System.out.println(Fname + " " + Lname + " " + Age);
		}

		rs.close();

	}

	// Ư������ ������ �ִ� ���� ��ȸ Type 2-2
	public static void adminQuery2(Connection conn, Statement stmt, Scanner scan) throws SQLException {
		String sql = "SELECT Store_name, Location, Fname, Lname " + "FROM STORE, OWNER " + "WHERE Fname = ? "
				+ "AND Lname = ? " + "and Bnum = Breg_number";
		System.out.print("First Name :");
		String fname = scan.next();
		System.out.print("Last Name :");
		String lname = scan.next();

		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, fname);
		ps.setString(2, lname);
		ResultSet rs = ps.executeQuery();

		ResultSetMetaData rsmd = rs.getMetaData();
		int cnt = rsmd.getColumnCount();
		for (int i = 1; i <= cnt; i++)
			System.out.print(" | " + rsmd.getColumnName(i));
		System.out.println(" | ");

		while (rs.next()) {
			String Store_name = rs.getString(1);
			String Location = rs.getString(2);
			String Fname = rs.getString(3);
			String Lname = rs.getString(4);
			System.out.println(Store_name + " | " + Location + " | " + Fname + " " + Lname);
		}

		rs.close();

	}

	// ���� ������ �ִ� �����̸� ��ġ �����̸� ��ȸ Type 4-1
	public static void adminQuery3(Connection conn, Statement stmt, Scanner scan) throws SQLException {
		String sql = "select distinct s.store_name, s.location, f.Food_name " + "from food f, rating r, store s "
				+ "where f.bnum = r.bnum " + "and s.breg_number = r.bnum " + "and f.bnum = s. breg_number "
				+ "and r.score =( " + "    select min(score) " + "    from rating " + "    group by r.bnum " + ")";

		PreparedStatement ps = conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		ResultSetMetaData rsmd = rs.getMetaData();
		int cnt = rsmd.getColumnCount();
		for (int i = 1; i <= cnt; i++)
			System.out.print(" | " + rsmd.getColumnName(i));
		System.out.println(" | ");

		while (rs.next()) {
			String Store_name = rs.getString(1);
			String Location = rs.getString(2);
			String Food_name = rs.getString(3);
			System.out.println(Store_name + " | " + Location + " | " + Food_name);
		}

		rs.close();
	}

	// �ְ� ������ ���� �����̸�, ������ ��ȸ Type 4-2
	public static void adminQuery4(Connection conn, Statement stmt, Scanner scan) throws SQLException {
		String sql = "select f.food_name, o.country_name " + "from food f, origin o " + "where f.id = o.id "
				+ "and f.price =( " + "    select max(price) " + "    from food " + ")";

		PreparedStatement ps = conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		ResultSetMetaData rsmd = rs.getMetaData();
		int cnt = rsmd.getColumnCount();
		for (int i = 1; i <= cnt; i++)
			System.out.print(" | " + rsmd.getColumnName(i));
		System.out.println(" | ");

		while (rs.next()) {
			String food_name = rs.getString(1);
			String country_name = rs.getString(2);
			System.out.println(food_name + " | " + country_name);
		}

		rs.close();
	}

	// �ְ� ������ �Ű��� ���� �̸�, ����, ���� ��ȸ Type 6-2
	public static void adminQuery5(Connection conn, Statement stmt, Scanner scan) throws SQLException {
		String sql = "select f.food_name, f.price, r.score " + "from food f, rating r " + "where f.bnum = r.bnum "
				+ "and r.score in( " + "    select max(score) " + "    from rating " + "    group by r.bnum " + ")";

		PreparedStatement ps = conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		ResultSetMetaData rsmd = rs.getMetaData();
		int cnt = rsmd.getColumnCount();
		for (int i = 1; i <= cnt; i++)
			System.out.print(" | " + rsmd.getColumnName(i));
		System.out.println(" | ");

		while (rs.next()) {
			String food_name = rs.getString(1);
			int price = rs.getInt(2);
			double score = rs.getDouble(3);
			System.out.println(food_name + " | " + price + " | " + score);
		}

		rs.close();
	}

	// 3���� �̻��� ������ �ִ� ���� ��ȸ Type 9-1
	public static void adminQuery6(Connection conn, Statement stmt, Scanner scan) throws SQLException {
		String sql = "select Breg_number as bnum, Store_name, count(*) " + "from Store natural join food "
				+ "where price in " + "   (select price " + "   from food " + "   where price >= 30000 " + "   ) "
				+ "and breg_number = Bnum " + "group by Breg_number, Store_name " + "having count(*) >= 1 "
				+ "order by bnum asc";

		PreparedStatement ps = conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		ResultSetMetaData rsmd = rs.getMetaData();
		int cnt = rsmd.getColumnCount();
		for (int i = 1; i <= cnt; i++)
			System.out.print(" | " + rsmd.getColumnName(i));
		System.out.println(" | ");

		while (rs.next()) {
			int bnum = rs.getInt(1);
			String Store_name = rs.getString(2);
			int count = rs.getInt(3);
			System.out.println(bnum + " | " + Store_name + " | " + count);
		}

		rs.close();
	}

	// �� ���躰 ���� ��� ���� �������� ��ȸ Type 9-2
	public static void adminQuery7(Connection conn, Statement stmt, Scanner scan) throws SQLException {
		String sql = "SELECT s.store_name, AVG(f.price) AS avg_price " + "FROM STORE s, FOOD f "
				+ "WHERE s.breg_number = f.bnum " + "GROUP BY s.store_name " + "ORDER BY avg_price DESC";

		PreparedStatement ps = conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		ResultSetMetaData rsmd = rs.getMetaData();
		int cnt = rsmd.getColumnCount();
		for (int i = 1; i <= cnt; i++)
			System.out.print(" | " + rsmd.getColumnName(i));
		System.out.println(" | ");

		while (rs.next()) {
			String Store_name = rs.getString(1);
			int avg_price = rs.getInt(2);
			System.out.println(Store_name + " | " + avg_price);
		}

		rs.close();
	}

}