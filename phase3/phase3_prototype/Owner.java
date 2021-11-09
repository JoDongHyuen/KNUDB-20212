package phase3;

import java.sql.*;
import java.util.Date;
import java.util.Scanner;

public class Owner {
	public static void ownerFunction(Connection conn, Statement stmt, Scanner scan) {
		int num;
		
		System.out.println("1. 로그인하기 2. 회원가입하기");
		num=scan.nextInt();
		switch(num) {
			case 1:
				o_login(conn, stmt, scan);
				break;
			case 2: 
				register(conn, stmt, scan);
				break;
		}
	}
	
	public static void o_login(Connection conn, Statement stmt, Scanner scan) {//로그인
		int num;
		
		System.out.println("점주의 이메일을 입력하세요. ex) fm3si69f@nano.com");
		String o_email = scan.next();
		o_email = " " + o_email;
		
		System.out.println("1. 점주 정보 변경 2. 점포 정보 변경 3. 본인 점포 상태 확인");
		num = scan.nextInt();
		switch(num) {
			case 1:
				change_owner(conn, stmt, scan, o_email);
				break;
			case 2: 
				change_store(conn, stmt, scan, o_email);
				break;
			case 3:
				ownerQuery(conn, stmt, scan, o_email);
				break;
		}
	}
	
	public static void change_owner(Connection conn, Statement stmt, Scanner scan, String o_email) {
		
	}
	
	public static void register(Connection conn, Statement stmt, Scanner scan) {//회원가입
		String sql;
		try {
			sql = "SELECT COUNT(*) FROM OWNER";
			ResultSet rs = stmt.executeQuery(sql);
			int breg_number = rs.getInt(1) + 1;
			System.out.println(breg_number);
		}catch (SQLException e){
			
		}
		
		System.out.println("가게 등록 번호를 입력해주세요.");
		int bnum = scan.nextInt();
		System.out.println("점주의 이름의 성을 입력해주세요.");
		String fname = scan.next();
		System.out.println("점주의 이름을 입력해주세요.");
		String lname = scan.next();
		System.out.println("점주의 휴대폰 번호를 입력해주세요.");
		String phone = scan.next();
		System.out.println("점주의 이메일을 입력해주세요.");
		String email = scan.next();
		System.out.println("점주의 성별을 입력해주세요.(female, male)");
		String sex = scan.next();
		System.out.println("점주의 나이를 입력해주세요.");
		int age = scan.nextInt();
		
		try {
			sql = "INSERT INTO OWNER VALUES(" + bnum + ", '" + fname + "', '" + lname + "', '" + phone + "', '" + email + "', '" + sex + "', " + age + ")";
			
			int res = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void change_store(Connection conn, Statement stmt, Scanner scan, String o_email) {
		
	}
	
	public static void ownerQuery(Connection conn, Statement stmt, Scanner scan, String o_email) {
		int num;

		try {
			conn.setAutoCommit(false);

			System.out.println("알고 싶은 정보의 번호를 입력하세요.");
			System.out.println("1. 본인 가게 이름과 예약한 사람의 이름, 시간 조회");
			System.out.println("2. 본인 가게 이름과 리뷰 조회");
			System.out.println("3. 본인 가게에 평점 4점 이상 준 고객의 이메일, 평점을 조회(평점으로 내림차순)");
			System.out.println("4. 특정 시간 이후 본인 가게에 예약을 한 사람 이름과 시간 대 조회");
			System.out.println("5. 본인 가게와 동종업계 가게의 이름, 평균 가격, 평균 평점 조회");
			System.out.println("0. 종료");

			num = scan.nextInt();

			switch (num) {
			case 0:
				return;
			case 1:
				ownerQuery1(conn, stmt, scan, o_email);
				break;
			case 2:
				ownerQuery2(conn, stmt, scan, o_email);
				break;
			case 3:
				ownerQuery3(conn, stmt, scan, o_email);
				break;
			case 4:
				ownerQuery4(conn, stmt, scan, o_email);
				break;
			case 5:
				ownerQuery5(conn, stmt, scan, o_email);
				break;
			}
		} catch (SQLException ex2) {
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}

	// 본인가게 예약한 사람과 시간 조회 Type2-1
	private static void ownerQuery1(Connection conn, Statement stmt, Scanner scan, String o_email) {
		try {
			String sql = "SELECT S.Store_name, B.Time, C.Fname, C.Lname FROM STORE S, CUST_BOOKS_STR B, CUSTOMER C, OWNER O WHERE C.Customer_Email = B.Cemail and B.Bnum = S.Breg_number and B.Bnum = O.Bnum and O.Owner_Email = ?";
			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, o_email);
			ResultSet rs = ps.executeQuery();

			System.out.println("가게 명 | 예약 날짜 | 고객 Fname | 고객 Lname");
			while (rs.next()) {
				String store_name = rs.getString(1);
				Date book_date = new Date();
				book_date = rs.getDate(2);
				String fname = rs.getString(3);
				String lname = rs.getString(4);

				System.out.println(store_name + " | " + book_date + " | " + fname + " | " + lname);
			}
			
			rs.close();

		} catch (SQLException ex2) {
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}

	// 본인가게 리뷰조회 Type5-1
	private static void ownerQuery2(Connection conn, Statement stmt, Scanner scan, String o_email) {
		try {
			String sql = "SELECT S.Store_name, R.Score FROM OWNER O, RATING R, STORE S WHERE O.Bnum = S.Breg_number and O.Bnum = R.Bnum and OWNER_EMAIL = ?";
			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, o_email);
			ResultSet rs = ps.executeQuery();

			System.out.println("가게 명 | 평점");
			while (rs.next()) {
				String store_name = rs.getString(1);
				float score = rs.getFloat(2);

				System.out.println(store_name + " | " + score);
			}
			
			rs.close();

		} catch (SQLException ex2) {
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}

	// 본인가게 평점 4점이상 준 고객 이메일, 가게 명, 평점 조회, 평점으로 내림차순
	private static void ownerQuery3(Connection conn, Statement stmt, Scanner scan, String o_email) {
		try {
			String sql = "SELECT S.Store_name, C.Customer_email, R.Score   FROM CUSTOMER C, RATING R, STORE S, OWNER O WHERE Score >= 4 AND C.Customer_email = R.Cemail AND R.Bnum = S.Breg_number AND O.Bnum = R.bnum AND O.Owner_email = ? ORDER BY Score DESC";
			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, o_email);
			ResultSet rs = ps.executeQuery();

			System.out.println("가게 명 | 고객 이메일 | 평점");
			while (rs.next()) {
				String store_name = rs.getString(1);
				String customer_email = rs.getString(2);
				float score = rs.getFloat(3);

				System.out.println(store_name + " | " + customer_email + "  |  " + score);
			}
			
			rs.close();

		} catch (SQLException ex2) {
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}

	// 특정날짜 이후 예약이 있는 사람
	private static void ownerQuery4(Connection conn, Statement stmt, Scanner scan, String o_email) {
		try {
			String sql = "SELECT C.Fname, C.Lname, TO_CHAR(B.Time, 'YYYY-MM-DD HH24:MI:SS') as B_date FROM CUSTOMER C,  CUST_BOOKS_STR B, OWNER O WHERE B.Time > ?  AND C.Customer_email = B.Cemail AND O.Owner_email = ? and O.Bnum = B.Bnum ORDER BY B.time";
			PreparedStatement ps = conn.prepareStatement(sql);

			System.out.println("날짜를 입력해주세요.(YYYY-MM-DD) ex) 2021-09-30");
			String input_date = scan.next();
			ps.setString(1, input_date);
			ps.setString(2, o_email);
			ResultSet rs = ps.executeQuery();

			System.out.println("고객 Fname | 고객 Lname | 예약 날짜");
			while (rs.next()) {
				String fname = rs.getString(1);
				String lname = rs.getString(2);
				String b_date = rs.getString(3);

				System.out.println(fname + " | " + lname + "  |  " + b_date);
			}
			
			rs.close();

		} catch (SQLException ex2) {
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}

	// 본인가게와 동종업계 가게의 이름, 평균가격, 평균 평점
	private static void ownerQuery5(Connection conn, Statement stmt, Scanner scan, String o_email) {
		try {
			conn.setAutoCommit(false);

			String sql = "CREATE VIEW TEMP1 AS SELECT Bnum, Avg(Price) as Avg_price FROM FOOD GROUP BY Bnum";
			stmt.executeUpdate(sql);

			sql = "CREATE VIEW TEMP2 AS SELECT Bnum, Round(Avg(Score),2) AS Avg_score FROM RATING GROUP BY Bnum";
			stmt.executeUpdate(sql);

			sql = "SELECT S.Store_name, T1.Avg_price, T2.Avg_score FROM TEMP1 T1, TEMP2 T2, STORE S WHERE T1.Bnum = T2.Bnum AND S.Breg_number = T1.Bnum AND S.Store_type in(  SELECT Store_type S2 FROM STORE S2, OWNER O WHERE O.Owner_email = ? AND S2.breg_number = O.bnum)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, o_email);
			ResultSet rs = ps.executeQuery();

			System.out.println("동종 업계 가게 명 | 평균 가격 | 평균 평점");
			while (rs.next()) {
				String store_name = rs.getString(1);
				float avg_price = rs.getFloat(2);
				float avg_score = rs.getFloat(3);

				System.out.println(store_name + " | " + avg_price + "  |  " + avg_score);
			}
			
			rs.close();

			sql = "DROP VIEW TEMP1";
			stmt.executeUpdate(sql);
			sql = "DROP VIEW TEMP2";
			stmt.executeUpdate(sql);

		} catch (SQLException ex2) {
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}
}
