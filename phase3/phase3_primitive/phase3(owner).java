package lab7;

import java.sql.*;
import java.text.*;
import java.util.Date;
import java.io.*;
import java.util.Scanner;

public class phase3 {
	public static final String URL = "jdbc:oracle:thin:@localhost:1521:orcl";
	public static final String USER_COMPANY = "restaurant";
	public static final String USER_PASSWD = "restaurant";

	static Connection conn = null;
	static Statement stmt = null;
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Scanner scan = new Scanner(System.in);

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("Driver Loading: Success!");
		} catch (ClassNotFoundException e) {
			System.err.println("error = " + e.getMessage());
			System.exit(1);
		}

		try {
			conn = DriverManager.getConnection(URL, USER_COMPANY, USER_PASSWD);
			System.out.println("Oracle Connected");
		} catch (SQLException ex) {
			ex.printStackTrace();
			System.err.println("Cannot get a connection: " + ex.getLocalizedMessage());
			System.err.println("Cannot get a connection: " + ex.getMessage());
			System.exit(1);
		}

		int login_type;
		login_type = login();
		
		switch(login_type) {
			case 1 : 
				Owner();
				break;
			case 2 :
				Customer();
				break;
			case 3 :
				Admin();
				break;
		}
	} // main end bracket
	
	public static int login() {
		System.out.println("로그인할 계정을 선택해주세요. 1) OWNER 2) CUSTOMER 3) ADMINISTRATOR");
		
		Scanner scan = new Scanner(System.in);
		int login_type = scan.nextInt();
		
		return login_type;
	}

	public static void Owner() {
		//get email
		Scanner scan = new Scanner(System.in);
		System.out.println("Owner");
		
		System.out.println("점주의 이메일을 입력하세요. ex) fm3si69f@nano.com");
		String o_email = scan.next();
		o_email = " " + o_email;
		int num;
		
		try {
			stmt = conn.createStatement();
			conn.setAutoCommit(false);
			
			System.out.println("알고 싶은 정보의 번호를 입력하세요.");
			System.out.println("1. 본인 가게 이름과 예약한 사람의 이름, 시간 조회");
			System.out.println("2. 본인 가게 이름과 리뷰 조회");
			System.out.println("3. 본인 가게에 평점 4점 이상 준 고객의 이메일, 평점을 조회(평점으로 내림차순)");
			System.out.println("4. 특정 시간 이후 본인 가게에 예약을 한 사람 이름과 시간 대 조회");
			System.out.println("5. 본인 가게와 동종업계 가게의 이름, 평균 가격, 평균 평점 조회");
			System.out.println("0. 종료");
			
			num = scan.nextInt();
			
			switch(num) {
				case 0:
					return;
				case 1: 
					owner_query1(o_email);
					break;
				case 2:
					owner_query2(o_email);
					break;
				case 3:
					owner_query3(o_email);
					break;
				case 4:
					owner_query4(o_email);
					break;
				case 5:
					owner_query5(o_email);
					break;
			}
		} catch(SQLException ex2){
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}

	//본인가게 예약한 사람과 시간 조회 Type2-1
	private static void owner_query1(String o_email) {
		try {
			String sql = "SELECT S.Store_name, B.Time, C.Fname, C.Lname FROM STORE S, CUST_BOOKS_STR B, CUSTOMER C, OWNER O WHERE C.Customer_Email = B.Cemail and B.Bnum = S.Breg_number and B.Bnum = O.Bnum and O.Owner_Email = ?";
			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, o_email);
			ResultSet rs = ps.executeQuery();

			System.out.println("가게 명 | 예약 날짜 | 고객 Fname | 고객 Lname");
			while(rs.next()) {
				String store_name = rs.getString(1);
				Date book_date = new Date();
				book_date = rs.getDate(2);
				String fname = rs.getString(3);
				String lname = rs.getString(4);
				
				System.out.println(store_name + " | " + book_date + " | " + fname + " | " + lname);
			}
			
		} catch(SQLException ex2){
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}
	
	//본인가게 리뷰조회 Type5-1
	private static void owner_query2(String o_email) {
		try {
			String sql = "SELECT S.Store_name, R.Score FROM OWNER O, RATING R, STORE S WHERE O.Bnum = S.Breg_number and O.Bnum = R.Bnum and OWNER_EMAIL = ?";
			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, o_email);
			ResultSet rs = ps.executeQuery();
			
			System.out.println("가게 명 | 평점");
			while(rs.next()) {
				String store_name = rs.getString(1);
				float score = rs.getFloat(2);
				
				System.out.println(store_name + " | " + score);
			}
			
		}catch(SQLException ex2){
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}
	
	//본인가게 평점 4점이상 준 고객 이메일, 가게 명, 평점 조회, 평점으로 내림차순
	private static void owner_query3(String o_email) {
		try {
			String sql = "SELECT S.Store_name, C.Customer_email, R.Score   FROM CUSTOMER C, RATING R, STORE S, OWNER O WHERE Score >= 4 AND C.Customer_email = R.Cemail AND R.Bnum = S.Breg_number AND O.Bnum = R.bnum AND O.Owner_email = ? ORDER BY Score DESC";
			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, o_email);
			ResultSet rs = ps.executeQuery();
			
			System.out.println("가게 명 | 고객 이메일 | 평점");
			while(rs.next()) {
				String store_name = rs.getString(1);
				String customer_email = rs.getString(2);
				float score = rs.getFloat(3);
				
				System.out.println(store_name + " | " + customer_email + "  |  " + score);
			}
			
		}catch(SQLException ex2){
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}
	
	//특정날짜 이후 예약이 있는 사람
	private static void owner_query4(String o_email) {
		try {
			Scanner scan = new Scanner(System.in);
			String sql = "SELECT C.Fname, C.Lname, TO_CHAR(B.Time, 'YYYY-MM-DD HH24:MI:SS') as B_date FROM CUSTOMER C,  CUST_BOOKS_STR B, OWNER O WHERE B.Time > ?  AND C.Customer_email = B.Cemail AND O.Owner_email = ? and O.Bnum = B.Bnum ORDER BY B.time";
			PreparedStatement ps = conn.prepareStatement(sql);

			System.out.println("날짜를 입력해주세요.(YYYY-MM-DD) ex) 2021-09-30");
			String input_date = scan.next();
			ps.setString(1,  input_date);
			ps.setString(2, o_email);
			ResultSet rs = ps.executeQuery();
			
			System.out.println("고객 Fname | 고객 Lname | 예약 날짜");
			while(rs.next()) {
				String fname = rs.getString(1);
				String lname = rs.getString(2);
				String b_date = rs.getString(3);
				
				System.out.println(fname + " | " + lname + "  |  " + b_date);
			}
			
		}catch(SQLException ex2){
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}
	
	//본인가게와 동종업계 가게의 이름, 평균가격, 평균 평점
	private static void owner_query5(String o_email) {
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
			while(rs.next()) {
				String store_name = rs.getString(1);
				float avg_price = rs.getFloat(2);
				float avg_score = rs.getFloat(3);
				
				System.out.println(store_name + " | " + avg_price + "  |  " + avg_score);
			}
			
			sql = "DROP VIEW TEMP1";
			stmt.executeUpdate(sql);
			sql = "DROP VIEW TEMP2";
			stmt.executeUpdate(sql);
			
		}catch(SQLException ex2){
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}

	public static void Customer() {
		//get email
		System.out.println("Customer");
	}
	
	public static void Admin() {
		System.out.println("Admin");
	}
	
}