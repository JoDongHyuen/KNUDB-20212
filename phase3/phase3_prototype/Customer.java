package phase3;

import java.sql.*;
import java.util.*;

public class Customer {
	public static void customerQuery(Connection conn, Statement stmt, Scanner scan) {
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

		switch (num) {
		case 1:
			customerQuery1(conn, stmt, scan);
			break;
		case 2:
			customerQuery2(conn, stmt, scan);
			break;
		case 3:
			customerQuery3(conn, stmt, scan);
			break;
		case 4:
			customerQuery4(conn, stmt, scan);
			break;
		case 5:
			customerQuery5(conn, stmt, scan);
			break;
		case 6:
			customerQuery6(conn, stmt, scan);
			break;
		case 7:
			customerQuery7(conn, stmt, scan);
			break;
		case 8:
			customerQuery8(conn, stmt, scan);
			break;

		}
	}

	public static void customerQuery1(Connection conn, Statement stmt, Scanner scan) { // 1. 특정 가격 이하의 음식 조회
		PreparedStatement ps;
		ResultSet rs;
		String sql = "";
		System.out.println("===== 특정 가격 이하의 음식 조회 =====");
		System.out.println("가격 입력 : ");
		int price = scan.nextInt();
		sql = "SELECT Food_name, Price " + "FROM FOOD " + "WHERE Price <= ?";
		try {
			String str = Integer.toString(price);
			ps = conn.prepareStatement(sql);
			ps.setString(1, str);
			rs = ps.executeQuery();

			System.out.println("Food Name   |  Price  ");
			while (rs.next()) {
				String fn = rs.getString(1);
				String pr = rs.getString(2);

				System.out.println(fn + " | " + pr + " 원");
			}
			
			rs.close();
			
		} catch (SQLException ex2) {
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}

	public static void customerQuery2(Connection conn, Statement stmt, Scanner scan) { // 2. 평가가 특정 갯수 이상 있는 가게 조회
		PreparedStatement ps;
		ResultSet rs;
		String sql = "";
		System.out.println("===== 평가가 특정 갯수 이상 있는 가게 조회 =====");
		System.out.println("rating 갯수 입력 : ");
		int num = scan.nextInt();
		sql = "SELECT Store_name, COUNT(*) AS Rating_Num " + "FROM STORE, RATING " + "WHERE Breg_number = Bnum "
				+ "GROUP BY Store_name " + "HAVING COUNT(*) >= ?";
		try {
			String str = Integer.toString(num);
			ps = conn.prepareStatement(sql);
			ps.setString(1, str);
			rs = ps.executeQuery();

			System.out.println("Store Name        |  Rating Count ");
			while (rs.next()) {
				String sn = rs.getString(1);
				String rc = rs.getString(2);

				System.out.println(sn + " | " + rc + " 개");
			}
			
			rs.close();
			
		} catch (SQLException ex2) {
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}

	public static void customerQuery3(Connection conn, Statement stmt, Scanner scan) { // 3. 평점이 특정 점수 이상인 가게 조회
		PreparedStatement ps;
		ResultSet rs;
		String sql = "";
		System.out.println("===== 평점이 특정 점수 이상인 가게이름, 위치, 평점 조회 =====");
		System.out.println("평점 입력 (소수점 첫재짜리까지 입력허용) : ");
		double rating = scan.nextDouble();
		sql = "SELECT Store_name, Location, ROUND(avg(Score), 1) " + "FROM STORE, RATING " + "WHERE Breg_number = Bnum "
				+ "GROUP BY Store_name, Location " + "HAVING avg(Score) >= ?";
		try {
			String str = Double.toString(rating);
			ps = conn.prepareStatement(sql);
			ps.setString(1, str);
			rs = ps.executeQuery();

			System.out.println("Store Name   |  Location    		|  Rating");
			while (rs.next()) {
				String st = rs.getString(1);
				String lo = rs.getString(2);
				String ra = rs.getString(3);
				System.out.println(st + " | " + lo + " | " + ra + " 점 ");
			}
			
			rs.close();
			
		} catch (SQLException ex2) {
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}

	public static void customerQuery4(Connection conn, Statement stmt, Scanner scan) { // 4. 특정 평점이 존재하는 가게 이름 조회
		PreparedStatement ps;
		ResultSet rs;
		String sql = "";
		System.out.println("===== 특정 평점이 존재하는 가게 이름 조회 =====");
		System.out.println("평점 입력 : ");
		Double rating = scan.nextDouble();

		sql = "SELECT Store_name " + "FROM STORE S " + "WHERE EXISTS( " + "        SELECT * " + "        FROM RATING R "
				+ "        WHERE R.Bnum = S.Breg_number " + "        AND R.Score = ?)";
		try {
			String str = Double.toString(rating);
			ps = conn.prepareStatement(sql);
			ps.setString(1, str);
			rs = ps.executeQuery();

			System.out.println("Store Name  ");
			while (rs.next()) {
				String sn = rs.getString(1);
				System.out.println(sn);
			}
			
			rs.close();
			
		} catch (SQLException ex2) {
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}

	public static void customerQuery5(Connection conn, Statement stmt, Scanner scan) { // 5. 주류를 파는 가게 // 팔지 않는 가게
		PreparedStatement ps;
		ResultSet rs;
		String sql = "";
		System.out.println("===== 주류를 파는 가게 // 음료수 파는 가게 -> 가게 이름, 음료수, 가격 출력 =====");
		System.out.println("주류-> Y 입력 / 음료수 -> N 입력 : ");
		String bev = scan.next();
		sql = "SELECT Store_name, Drink_name, price " + "FROM ( " + "    SELECT * " + "    FROM STORE, BEVERAGE "
				+ "    WHERE Breg_number = Bnum) " + "WHERE Alcohol = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, bev);
			rs = ps.executeQuery();

			System.out.println("Store Name        |  Name of Drink  |  Price");
			while (rs.next()) {
				String st = rs.getString(1);
				String nd = rs.getString(2);
				String pr = rs.getString(3);
				System.out.println(st + " | " + nd + " | " + pr + " 원 ");
			}
			
			rs.close();
			
		} catch (SQLException ex2) {
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}

	public static void customerQuery6(Connection conn, Statement stmt, Scanner scan) { // 6. 특정 원산지 음식 가격 조회
		PreparedStatement ps;
		ResultSet rs;
		String sql = "";
		System.out.println("===== 특정 원산지 음식 이름, 가격 조회 =====");
		System.out.println("원산지 : 한국 / 중국 / 미국 / 러시아 / 호주 / 일본 / 베트남");
		System.out.println("/ 필리핀 / 독일 / 영국 / 대만 / 캐나다 / 칠레 / 벨기에 / 프랑스");
		String orig = scan.next();
		sql = "SELECT Food_name, Price " + "FROM ( " + "    SELECT * " + "    FROM FOOD natural join ORIGIN " + "    ) "
				+ "WHERE Country_name = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, orig);
			rs = ps.executeQuery();

			System.out.println("Food Name   |  Price");
			while (rs.next()) {
				String fn = rs.getString(1);
				String pr = rs.getString(2);
				System.out.println(fn + " | " + pr + " 원 ");
			}
			
			rs.close();
			
		} catch (SQLException ex2) {
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}

	public static void customerQuery7(Connection conn, Statement stmt, Scanner scan) { // 7. 판매하는 음식이 모두 특정 원산지인 가게의 이름 출력
		PreparedStatement ps;
		ResultSet rs;
		String sql = "";
		System.out.println("===== 판매하는 음식이 모두 특정 원산지인 가게의 이름, 주소 조회 =====");
		System.out.println("원산지 : 한국 / 중국 / 미국 / 러시아 / 호주 / 일본 / 베트남");
		System.out.println("/ 필리핀 / 독일 / 영국 / 대만 / 캐나다 / 칠레 / 벨기에 / 프랑스");
		String orig = scan.next();
		sql = "SELECT Store_name, Location " + "FROM STORE S " + "WHERE NOT EXISTS( " + "        SELECT F.Id "
				+ "        FROM  FOOD F " + "        WHERE F.Bnum = S.Breg_number " + "        MINUS "
				+ "        SELECT O.Id " + "        FROM ORIGIN O " + "        WHERE O.Country_name = ?" + "        )";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, orig);
			rs = ps.executeQuery();

			System.out.println("Store Name        |	 	Location");
			while (rs.next()) {
				String st = rs.getString(1);
				String lo = rs.getString(2);
				System.out.println(st + " | " + lo);
			}
			
			rs.close();
			
		} catch (SQLException ex2) {
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}

	public static void customerQuery8(Connection conn, Statement stmt, Scanner scan) { // 8. 판매하는 모든 음료가 주류인 가게 // 음식인 가게
		PreparedStatement ps;
		ResultSet rs;
		String sql = "";
		System.out.println("===== 판매하는 모든 음료가 주류인 가게 // 음식인 가게 의 가게 이름과 주소 조회 =====");
		System.out.println("주류-> Y 입력 / 음료수 -> N 입력 : ");
		String bev = scan.next();
		sql = "SELECT Store_name, Location " + "FROM STORE S " + "WHERE NOT EXISTS( " + "        SELECT B.Id "
				+ "        FROM  BEVERAGE B " + "        WHERE B.Bnum = S.Breg_number " + "        AND B.Alcohol = ? "
				+ "        MINUS " + "        SELECT E.Id " + "        FROM BEVERAGE E " + "        WHERE E.Alcohol = ?"
				+ "        )";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, bev);
			ps.setString(2, bev);
			rs = ps.executeQuery();

			System.out.println("Store Name        | Location");
			while (rs.next()) {
				String st = rs.getString(1);
				String lo = rs.getString(2);
				System.out.println(st + " | " + lo);
			}
			
			rs.close();
			
		} catch (SQLException ex2) {
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}
}
