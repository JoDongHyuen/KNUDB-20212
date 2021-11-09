package phase3;

import java.sql.*;
import java.util.Date;
import java.util.Scanner;

public class Owner {
	public static void ownerFunction(Connection conn, Statement stmt, Scanner scan) {
		int num;
		
		System.out.println("1. �α����ϱ� 2. ȸ�������ϱ�");
		num=scan.nextInt();
		switch(num) {
			case 1:
				o_login(conn, stmt, scan);
				break;
			case 2: 
				o_register(conn, stmt, scan);
				break;
		}
	}
	
	public static void o_login(Connection conn, Statement stmt, Scanner scan) {//�α���
		int num;
		
		System.out.println("1. ���� ���� ���� 2. ���� ���� ���� Ȯ��");
		num = scan.nextInt();
		switch(num) {
			case 1: 
				change_store(conn, stmt, scan);
				break;
			case 2:
				ownerQuery(conn, stmt, scan);
		}
	}
	
	public static void o_register(Connection conn, Statement stmt, Scanner scan) {//ȸ������
		
	}
	
	public static void change_store(Connection conn, Statement stmt, Scanner scan) {
		
	}
	
	public static void ownerQuery(Connection conn, Statement stmt, Scanner scan) {
		// get email
		System.out.println("Owner");
		

		System.out.println("������ �̸����� �Է��ϼ���. ex) fm3si69f@nano.com");
		String o_email = scan.next();
		o_email = " " + o_email;
		int num;

		try {
			conn.setAutoCommit(false);

			System.out.println("�˰� ���� ������ ��ȣ�� �Է��ϼ���.");
			System.out.println("1. ���� ���� �̸��� ������ ����� �̸�, �ð� ��ȸ");
			System.out.println("2. ���� ���� �̸��� ���� ��ȸ");
			System.out.println("3. ���� ���Կ� ���� 4�� �̻� �� ���� �̸���, ������ ��ȸ(�������� ��������)");
			System.out.println("4. Ư�� �ð� ���� ���� ���Կ� ������ �� ��� �̸��� �ð� �� ��ȸ");
			System.out.println("5. ���� ���Կ� �������� ������ �̸�, ��� ����, ��� ���� ��ȸ");
			System.out.println("0. ����");

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

	// ���ΰ��� ������ ����� �ð� ��ȸ Type2-1
	private static void ownerQuery1(Connection conn, Statement stmt, Scanner scan, String o_email) {
		try {
			String sql = "SELECT S.Store_name, B.Time, C.Fname, C.Lname FROM STORE S, CUST_BOOKS_STR B, CUSTOMER C, OWNER O WHERE C.Customer_Email = B.Cemail and B.Bnum = S.Breg_number and B.Bnum = O.Bnum and O.Owner_Email = ?";
			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, o_email);
			ResultSet rs = ps.executeQuery();

			System.out.println("���� �� | ���� ��¥ | �� Fname | �� Lname");
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

	// ���ΰ��� ������ȸ Type5-1
	private static void ownerQuery2(Connection conn, Statement stmt, Scanner scan, String o_email) {
		try {
			String sql = "SELECT S.Store_name, R.Score FROM OWNER O, RATING R, STORE S WHERE O.Bnum = S.Breg_number and O.Bnum = R.Bnum and OWNER_EMAIL = ?";
			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, o_email);
			ResultSet rs = ps.executeQuery();

			System.out.println("���� �� | ����");
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

	// ���ΰ��� ���� 4���̻� �� �� �̸���, ���� ��, ���� ��ȸ, �������� ��������
	private static void ownerQuery3(Connection conn, Statement stmt, Scanner scan, String o_email) {
		try {
			String sql = "SELECT S.Store_name, C.Customer_email, R.Score   FROM CUSTOMER C, RATING R, STORE S, OWNER O WHERE Score >= 4 AND C.Customer_email = R.Cemail AND R.Bnum = S.Breg_number AND O.Bnum = R.bnum AND O.Owner_email = ? ORDER BY Score DESC";
			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, o_email);
			ResultSet rs = ps.executeQuery();

			System.out.println("���� �� | �� �̸��� | ����");
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

	// Ư����¥ ���� ������ �ִ� ���
	private static void ownerQuery4(Connection conn, Statement stmt, Scanner scan, String o_email) {
		try {
			String sql = "SELECT C.Fname, C.Lname, TO_CHAR(B.Time, 'YYYY-MM-DD HH24:MI:SS') as B_date FROM CUSTOMER C,  CUST_BOOKS_STR B, OWNER O WHERE B.Time > ?  AND C.Customer_email = B.Cemail AND O.Owner_email = ? and O.Bnum = B.Bnum ORDER BY B.time";
			PreparedStatement ps = conn.prepareStatement(sql);

			System.out.println("��¥�� �Է����ּ���.(YYYY-MM-DD) ex) 2021-09-30");
			String input_date = scan.next();
			ps.setString(1, input_date);
			ps.setString(2, o_email);
			ResultSet rs = ps.executeQuery();

			System.out.println("�� Fname | �� Lname | ���� ��¥");
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

	// ���ΰ��Կ� �������� ������ �̸�, ��հ���, ��� ����
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

			System.out.println("���� ���� ���� �� | ��� ���� | ��� ����");
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
