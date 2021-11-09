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
			
			System.out.println("관리자의 비밀번호를 입력해주세요.");
			String password = scan.next();
			
			try {
				String sql = "SELECT PASS_WORD FROM INFORMATION WHERE EMAIL = 'admin'";
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				rs.next();
				
				String get_password = rs.getString(1);
				if(get_password.equals(password)) {
					System.out.println("로그인 성공");
					break;
				}
				else
					System.out.println("이메일 또는 비밀번호가 틀렸습니다.");
				
			}catch (SQLException e) {
		         e.printStackTrace();
		      }
		}
		// Scanner scan = new Scanner(System.in);
		System.out.println("1. 나이대별 고객 조사");
		System.out.println("2. 특정인 소유 가게 조회");
		System.out.println("3. 최하 평점이 있는 가게 조회");
		System.out.println("4. 최고 가격을 가진 음식 이름, 원산지 조회");
		System.out.println("5. 최고 평점이 매겨진 음식 이름, 가격 평점 조회");
		System.out.println("6. 30000원 이상 음식이 있는 가게 조회");
		System.out.println("7. 각 가계별 음식 평균 가격 조회");
		System.out.println("0. 종료");

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

	// 나이대별 고객 조사 Type 1-1
	public static void adminQuery1(Connection conn, Statement stmt, Scanner scan) throws SQLException {

		String sql = "SELECT Fname, Lname, Age " + "FROM CUSTOMER " + "WHERE Age BETWEEN ? and ?";
		System.out.println("조회할 나이대를 입력해 주세요");
		System.out.print("시작할 나이 :");
		int from = scan.nextInt();
		System.out.print("끝낼 나이 :");
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

	// 특정인이 가지고 있는 가게 조회 Type 2-2
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

	// 최하 평점이 있는 가게이름 위치 음식이름 조회 Type 4-1
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

	// 최고 가격을 가진 음식이름, 원산지 조회 Type 4-2
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

	// 최고 평점이 매겨진 음식 이름, 가격, 평점 조회 Type 6-2
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

	// 3만원 이상인 음식이 있는 가게 조회 Type 9-1
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

	// 각 가계별 음식 평균 가격 내림차순 조회 Type 9-2
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