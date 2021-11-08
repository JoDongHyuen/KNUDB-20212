import java.sql.*;
import java.io.*;
import java.util.*;

public class phase3 {
	public static final String URL = "jdbc:oracle:thin:@localhost:1521:orcl";
	public static final String USER_PROJECT = "restaurant";
	public static final String USER_PASSWD = "restaurant";

	static Connection conn = null;
	static Statement stmt = null;

	public static void main(String[] args) {
		Scanner scan = new Scanner(System.in);
		String sql = "";
		ResultSet rs;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("Success!");

		} catch (ClassNotFoundException e) {
			System.err.println("error = " + e.getMessage());
		}

		try {
			conn = DriverManager.getConnection(URL, USER_PROJECT, USER_PASSWD);
			System.out.println("Connected");
		} catch (SQLException ex) {
			ex.printStackTrace();
			System.err.println("Cannot get a connection" + ex.getLocalizedMessage());
			System.exit(1);
		}

		
		int login_type;
		login_type = login();
		
		switch(login_type) {
			case 1 : 
				//Owner();
				break;
			case 2 :
				Customer();
				break;
			case 3 :
				//Admin();
				break;
		}
	} // main end bracket
	
	public static int login() {
		System.out.println("로그인할 계정을 선택해주세요. 1) OWNER 2) CUSTOMER 3) ADMINISTRATOR");
		
		Scanner scan = new Scanner(System.in);
		int login_type = scan.nextInt();
		
		return login_type;
	}
	public static void Customer() {
		Scanner scan = new Scanner(System.in);
		System.out.println("Customer");
		
		System.out.println("알고 싶은 정보의 번호를 입력하세요");
		System.out.println("1. 특정 가격 이하의 음식 조회");
		System.out.println("2. 평가가 특정 갯수 이상 있는 가게 조회");
		System.out.println("3. 평점이 특정 점수 이상인 가게이름, 위치, 평점 조회");
		System.out.println("4. 특정 평점이 존재하는 가게 이름 조회");
		System.out.println("5. 주류를 파는 가게 // 팔지 않는 가게");
		System.out.println("6. 특정 원산지 음식 가격 조회");
		System.out.println("7. 판매하는 음식이 모두 특정 원산지인 가게의 이름, 주소 출력");
		System.out.println("8. 판매하는 모든 음료가 주류인 가게 // 음식인 가게 의 이름, 주소 출력");
		
		int num = scan.nextInt();
		
		switch(num) {
		case 1:
			func1();
			break;
		case 2:
			func2();
			break;
		case 3:
			func3();
			break;
		case 4:
			func4();
			break;
		case 5:
			func5();
			break;
		case 6:
			func6();
			break;
		case 7:
			func7();
			break;
		case 8:
			func8();
			break;
			
		}
	}
	public static void func1() { // 1. 특정 가격 이하의 음식 조회
		Scanner scan = new Scanner(System.in);
		PreparedStatement ps;
		ResultSet rs;
		String sql = "";
		System.out.println("===== 특정 가격 이하의 음식 조회 =====");
		System.out.println("가격 입력 : ");
		int price = scan.nextInt();
		sql = "SELECT Food_name, Price "
				+ "FROM FOOD "
				+ "WHERE Price <= ?";
		try {
			String str = Integer.toString(price);
			ps = conn.prepareStatement(sql);
			ps.setString(1, str);
			rs = ps.executeQuery();
			
			System.out.println("Food Name   |  Price  ");
			while(rs.next()) {
				String fn = rs.getString(1);
				String pr = rs.getString(2);
				
				System.out.println(fn + " | " + pr + " 원");
			}
		}catch(SQLException ex2) {
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}
	public static void func2() { // 2. 평가가 특정 갯수 이상 있는 가게 조회
		Scanner scan = new Scanner(System.in);
		PreparedStatement ps;
		ResultSet rs;
		String sql = "";
		System.out.println("===== 평가가 특정 갯수 이상 있는 가게 조회 =====");
		System.out.println("rating 갯수 입력 : ");
		int num = scan.nextInt();
		sql = "SELECT Store_name, COUNT(*) AS Rating_Num "
				+ "FROM STORE, RATING "
				+ "WHERE Breg_number = Bnum "
				+ "GROUP BY Store_name "
				+ "HAVING COUNT(*) >= ?";
		try {
			String str = Integer.toString(num);
			ps = conn.prepareStatement(sql);
			ps.setString(1, str);
			rs = ps.executeQuery();
			
			System.out.println("Store Name        |  Rating Count ");
			while(rs.next()) {
				String sn = rs.getString(1);
				String rc = rs.getString(2);
				
				System.out.println(sn + " | " + rc + " 개");
			}
		}catch(SQLException ex2) {
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}
	public static void func3() { // 3. 평점이 특정 점수 이상인 가게 조회
		Scanner scan = new Scanner(System.in);
		PreparedStatement ps;
		ResultSet rs;
		String sql = "";
		System.out.println("===== 평점이 특정 점수 이상인 가게이름, 위치, 평점 조회 =====");
		System.out.println("평점 입력 (소수점 첫재짜리까지 입력허용) : ");
		double rating = scan.nextDouble();
		sql = "SELECT Store_name, Location, ROUND(avg(Score), 1) "
				+ "FROM STORE, RATING "
				+ "WHERE Breg_number = Bnum "
				+ "GROUP BY Store_name, Location "
				+ "HAVING avg(Score) >= ?";
		try {
			String str = Double.toString(rating);
			ps = conn.prepareStatement(sql);
			ps.setString(1, str);
			rs = ps.executeQuery();
			
			System.out.println("Store Name   |  Location    		|  Rating");
			while(rs.next()) {
				String st = rs.getString(1);
				String lo = rs.getString(2);
				String ra = rs.getString(3);
				System.out.println(st + " | " + lo + " | " + ra + " 점 ");
			}
		}catch(SQLException ex2) {
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}
	public static void func4() { // 4. 특정 평점이 존재하는 가게 이름 조회
		Scanner scan = new Scanner(System.in);
		PreparedStatement ps;
		ResultSet rs;
		String sql = "";
		System.out.println("===== 특정 평점이 존재하는 가게 이름 조회 =====");
		System.out.println("평점 입력 : ");
		Double rating = scan.nextDouble();
		
		sql = "SELECT Store_name "
				+ "FROM STORE S "
				+ "WHERE EXISTS( "
				+ "        SELECT * "
				+ "        FROM RATING R "
				+ "        WHERE R.Bnum = S.Breg_number "
				+ "        AND R.Score = ?)";
		try {
			String str = Double.toString(rating);
			ps = conn.prepareStatement(sql);
			ps.setString(1, str);
			rs = ps.executeQuery();
			
			System.out.println("Store Name  ");
			while(rs.next()) {
				String sn = rs.getString(1);
				System.out.println(sn);
			}
		}catch(SQLException ex2) {
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}
	public static void func5() { // 5. 주류를 파는 가게 // 팔지 않는 가게
		Scanner scan = new Scanner(System.in);
		PreparedStatement ps;
		ResultSet rs;
		//Statement stmt;
		String sql = "";
		System.out.println("===== 주류를 파는 가게 // 음료수 파는 가게 -> 가게 이름, 음료수, 가격 출력 =====");
		System.out.println("주류-> Y 입력 / 음료수 -> N 입력 : ");
		String bev = scan.next();
		sql = "SELECT Store_name, Drink_name, price "
				+ "FROM ( "
				+ "    SELECT * "
				+ "    FROM STORE, BEVERAGE "
				+ "    WHERE Breg_number = Bnum) "
				+ "WHERE Alcohol = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, bev);
			rs = ps.executeQuery();
			
			System.out.println("Store Name        |  Name of Drink  |  Price");
			while(rs.next()) {
				String st = rs.getString(1);
				String nd = rs.getString(2);
				String pr = rs.getString(3);
				System.out.println(st + " | " + nd + " | " + pr + " 원 ");
			}
		}catch(SQLException ex2) {
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}
	public static void func6() { // 6. 특정 원산지 음식 가격 조회
		Scanner scan = new Scanner(System.in);
		PreparedStatement ps;
		ResultSet rs;
		//Statement stmt;
		String sql = "";
		System.out.println("===== 특정 원산지 음식 이름, 가격 조회 =====");
		System.out.println("원산지 : 한국 / 중국 / 미국 / 러시아 / 호주 / 일본 / 베트남");
		System.out.println("/ 필리핀 / 독일 / 영국 / 대만 / 캐나다 / 칠레 / 벨기에 / 프랑스");
		String orig = scan.next();
		sql = "SELECT Food_name, Price "
				+ "FROM ( "
				+ "    SELECT * "
				+ "    FROM FOOD natural join ORIGIN "
				+ "    ) "
				+ "WHERE Country_name = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, orig);
			rs = ps.executeQuery();
			
			System.out.println("Food Name   |  Price");
			while(rs.next()) {
				String fn = rs.getString(1);
				String pr = rs.getString(2);
				System.out.println(fn + " | " + pr + " 원 ");
			}
		}catch(SQLException ex2) {
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}
	public static void func7() { // 7. 판매하는 음식이 모두 특정 원산지인 가게의 이름 출력
		Scanner scan = new Scanner(System.in);
		PreparedStatement ps;
		ResultSet rs;
		//Statement stmt;
		String sql = "";
		System.out.println("===== 판매하는 음식이 모두 특정 원산지인 가게의 이름, 주소 조회 =====");
		System.out.println("원산지 : 한국 / 중국 / 미국 / 러시아 / 호주 / 일본 / 베트남");
		System.out.println("/ 필리핀 / 독일 / 영국 / 대만 / 캐나다 / 칠레 / 벨기에 / 프랑스");
		String orig = scan.next();
		sql = "SELECT Store_name, Location "
				+ "FROM STORE S "
				+ "WHERE NOT EXISTS( "
				+ "        SELECT F.Id "
				+ "        FROM  FOOD F "
				+ "        WHERE F.Bnum = S.Breg_number "
				+ "        MINUS "
				+ "        SELECT O.Id "
				+ "        FROM ORIGIN O "
				+ "        WHERE O.Country_name = ?"
				+ "        )";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, orig);
			rs = ps.executeQuery();
			
			System.out.println("Store Name        |	 	Location");
			while(rs.next()) {
				String st = rs.getString(1);
				String lo = rs.getString(2);
				System.out.println(st + " | " + lo);
			}
		}catch(SQLException ex2) {
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}
	
	public static void func8() { // 8. 판매하는 모든 음료가 주류인 가게 // 음식인 가게
		Scanner scan = new Scanner(System.in);
		PreparedStatement ps;
		ResultSet rs;
		//Statement stmt;
		String sql = "";
		System.out.println("===== 판매하는 모든 음료가 주류인 가게 // 음식인 가게 의 가게 이름과 주소 조회 =====");
		System.out.println("주류-> Y 입력 / 음료수 -> N 입력 : ");
		String bev = scan.next();
		sql = "SELECT Store_name, Location "
				+ "FROM STORE S "
				+ "WHERE NOT EXISTS( "
				+ "        SELECT B.Id "
				+ "        FROM  BEVERAGE B "
				+ "        WHERE B.Bnum = S.Breg_number "
				+ "        AND B.Alcohol = ? "
				+ "        MINUS "
				+ "        SELECT E.Id "
				+ "        FROM BEVERAGE E "
				+ "        WHERE E.Alcohol = ?"
				+ "        )";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, bev);
			ps.setString(2, bev);
			rs = ps.executeQuery();
			
			System.out.println("Store Name        | Location");
			while(rs.next()) {
				String st = rs.getString(1);
				String lo = rs.getString(2);
				System.out.println(st + " | " + lo);
			}
		}catch(SQLException ex2) {
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}
}
