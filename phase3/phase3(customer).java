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
		System.out.println("�α����� ������ �������ּ���. 1) OWNER 2) CUSTOMER 3) ADMINISTRATOR");
		
		Scanner scan = new Scanner(System.in);
		int login_type = scan.nextInt();
		
		return login_type;
	}
	public static void Customer() {
		Scanner scan = new Scanner(System.in);
		System.out.println("Customer");
		
		System.out.println("�˰� ���� ������ ��ȣ�� �Է��ϼ���");
		System.out.println("1. Ư�� ���� ������ ���� ��ȸ");
		System.out.println("2. �򰡰� Ư�� ���� �̻� �ִ� ���� ��ȸ");
		System.out.println("3. ������ Ư�� ���� �̻��� �����̸�, ��ġ, ���� ��ȸ");
		System.out.println("4. Ư�� ������ �����ϴ� ���� �̸� ��ȸ");
		System.out.println("5. �ַ��� �Ĵ� ���� // ���� �ʴ� ����");
		System.out.println("6. Ư�� ������ ���� ���� ��ȸ");
		System.out.println("7. �Ǹ��ϴ� ������ ��� Ư�� �������� ������ �̸�, �ּ� ���");
		System.out.println("8. �Ǹ��ϴ� ��� ���ᰡ �ַ��� ���� // ������ ���� �� �̸�, �ּ� ���");
		
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
	public static void func1() { // 1. Ư�� ���� ������ ���� ��ȸ
		Scanner scan = new Scanner(System.in);
		PreparedStatement ps;
		ResultSet rs;
		String sql = "";
		System.out.println("===== Ư�� ���� ������ ���� ��ȸ =====");
		System.out.println("���� �Է� : ");
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
				
				System.out.println(fn + " | " + pr + " ��");
			}
		}catch(SQLException ex2) {
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}
	public static void func2() { // 2. �򰡰� Ư�� ���� �̻� �ִ� ���� ��ȸ
		Scanner scan = new Scanner(System.in);
		PreparedStatement ps;
		ResultSet rs;
		String sql = "";
		System.out.println("===== �򰡰� Ư�� ���� �̻� �ִ� ���� ��ȸ =====");
		System.out.println("rating ���� �Է� : ");
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
				
				System.out.println(sn + " | " + rc + " ��");
			}
		}catch(SQLException ex2) {
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}
	public static void func3() { // 3. ������ Ư�� ���� �̻��� ���� ��ȸ
		Scanner scan = new Scanner(System.in);
		PreparedStatement ps;
		ResultSet rs;
		String sql = "";
		System.out.println("===== ������ Ư�� ���� �̻��� �����̸�, ��ġ, ���� ��ȸ =====");
		System.out.println("���� �Է� (�Ҽ��� ù��¥������ �Է����) : ");
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
				System.out.println(st + " | " + lo + " | " + ra + " �� ");
			}
		}catch(SQLException ex2) {
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}
	public static void func4() { // 4. Ư�� ������ �����ϴ� ���� �̸� ��ȸ
		Scanner scan = new Scanner(System.in);
		PreparedStatement ps;
		ResultSet rs;
		String sql = "";
		System.out.println("===== Ư�� ������ �����ϴ� ���� �̸� ��ȸ =====");
		System.out.println("���� �Է� : ");
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
	public static void func5() { // 5. �ַ��� �Ĵ� ���� // ���� �ʴ� ����
		Scanner scan = new Scanner(System.in);
		PreparedStatement ps;
		ResultSet rs;
		//Statement stmt;
		String sql = "";
		System.out.println("===== �ַ��� �Ĵ� ���� // ����� �Ĵ� ���� -> ���� �̸�, �����, ���� ��� =====");
		System.out.println("�ַ�-> Y �Է� / ����� -> N �Է� : ");
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
				System.out.println(st + " | " + nd + " | " + pr + " �� ");
			}
		}catch(SQLException ex2) {
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}
	public static void func6() { // 6. Ư�� ������ ���� ���� ��ȸ
		Scanner scan = new Scanner(System.in);
		PreparedStatement ps;
		ResultSet rs;
		//Statement stmt;
		String sql = "";
		System.out.println("===== Ư�� ������ ���� �̸�, ���� ��ȸ =====");
		System.out.println("������ : �ѱ� / �߱� / �̱� / ���þ� / ȣ�� / �Ϻ� / ��Ʈ��");
		System.out.println("/ �ʸ��� / ���� / ���� / �븸 / ĳ���� / ĥ�� / ���⿡ / ������");
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
				System.out.println(fn + " | " + pr + " �� ");
			}
		}catch(SQLException ex2) {
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}
	public static void func7() { // 7. �Ǹ��ϴ� ������ ��� Ư�� �������� ������ �̸� ���
		Scanner scan = new Scanner(System.in);
		PreparedStatement ps;
		ResultSet rs;
		//Statement stmt;
		String sql = "";
		System.out.println("===== �Ǹ��ϴ� ������ ��� Ư�� �������� ������ �̸�, �ּ� ��ȸ =====");
		System.out.println("������ : �ѱ� / �߱� / �̱� / ���þ� / ȣ�� / �Ϻ� / ��Ʈ��");
		System.out.println("/ �ʸ��� / ���� / ���� / �븸 / ĳ���� / ĥ�� / ���⿡ / ������");
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
	
	public static void func8() { // 8. �Ǹ��ϴ� ��� ���ᰡ �ַ��� ���� // ������ ����
		Scanner scan = new Scanner(System.in);
		PreparedStatement ps;
		ResultSet rs;
		//Statement stmt;
		String sql = "";
		System.out.println("===== �Ǹ��ϴ� ��� ���ᰡ �ַ��� ���� // ������ ���� �� ���� �̸��� �ּ� ��ȸ =====");
		System.out.println("�ַ�-> Y �Է� / ����� -> N �Է� : ");
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
