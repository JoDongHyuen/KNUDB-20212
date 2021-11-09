package phase3;

import java.sql.*;
import java.util.*;

public class Customer {
	public static void customerFunction(Connection conn, Statement stmt, Scanner scan) {
		System.out.println("1. �α����ϱ� 2. ȸ�������ϱ�");
		int num = scan.nextInt();
		switch (num) {
		case 1:
			c_login(conn, stmt, scan);
			break;
		case 2:
			c_register(conn, stmt, scan);
			break;
		}
	}

	public static void c_login(Connection conn, Statement stmt, Scanner scan) {// �α���
		int num;

		System.out.println("���� �̸����� �Է��ϼ���. ex) fm3si69f@nano.com");
		String o_email = scan.next();
		o_email = " " + o_email;

		System.out.println("1. �� ���� ���� 2. ���� Searching");
		num = scan.nextInt();
		switch (num) {
		case 1:
			change_customer(conn, stmt, scan, o_email);
			break;
		case 2:
			customerQuery(conn, stmt, scan);
			break;
		}
	}

	public static void change_customer(Connection conn, Statement stmt, Scanner scan, String o_email) {
		try {
			String sql = "";
			PreparedStatement ps = null;
			System.out.println("1. Fname ����  2. Lname ����  3.�޴���ȭ ����  4.���� ����");
			int num = scan.nextInt();
			scan.nextLine();
			switch (num) {
			case 1:
				sql = "Update Owner SET Fname = ? WHERE OWNER_EMAIL='" + o_email + "'";
				ps = conn.prepareStatement(sql);
				break;
			case 2:
				sql = "Update Owner SET Lname = ? WHERE OWNER_EMAIL='" + o_email + "'";
				ps = conn.prepareStatement(sql);
				break;
			case 3:
				sql = "Update Owner SET Phone_number = ? WHERE OWNER_EMAIL='" + o_email + "'";
				ps = conn.prepareStatement(sql);
				break;
			case 4:
				sql = "Update Owner SET Age = ? WHERE OWNER_EMAIL='" + o_email + "'";
				ps = conn.prepareStatement(sql);
				break;
			}
			System.out.printf("������ ���� �Է����ּ��� : ");
			String var = scan.nextLine();
			ps.setString(1, var);
			ps.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void c_register(Connection conn, Statement stmt, Scanner scan) { // ȸ������ ������
		PreparedStatement ps;
		ResultSet rs;
		String em, passWord, Fname, Lname, sex, phoneNum;
		int age;
		String sql = "select Customer_email from customer";
		while (true) {
			System.out.print("e-mail �ּ� �Է� (@nano.com ��õ) : ");
			em = scan.next();
			em = " " + em;
			int flag = 1; // ��ġ�� �� ������ flag = 0 �� �ٲ�
			try {
				ps = conn.prepareStatement(sql);
				rs = ps.executeQuery();
				while (rs.next()) {
					String temp_e = rs.getString(1);
					if (temp_e.equals(em)) {
						flag = 0;
						break;
					}
				}
			} catch (SQLException ex2) {
				System.err.println("sql error = " + ex2.getMessage());
			}
			if (flag == 0) { // ��ġ�� �� ����
				System.out.println("e-mail �� ��Ĩ�ϴ�. �ٽ� �Է����ּ���.");
				continue;
			}
			if (!(em.substring(em.length() - 4, em.length()).equals(".com"))) {
				System.out.println("e-mail ���Ŀ� ���� �ʽ��ϴ�. �ٽ� �Է����ּ���.");
				continue;
			}
			break;
		} // while bracket end
			// information ���̺� ���� email �־���� �θ�Ű ���� ���� �ȵ�
		while (true) {
			System.out.print("password �Է� (15�ڸ� �̳�, �ּ� 6�ڸ� ���� ��õ) : ");
			passWord = scan.next();
			if (passWord.length() > 15 || passWord.length() < 6) {
				System.out.println("password ���̰� �ȸ½��ϴ�. �ٽ� �Է����ּ���.");
				continue;
			}
			break;
		}
		while (true) {
			System.out.print("���� �Է� : ");
			Fname = scan.next();

			if (Fname.length() > 2) {
				System.out.println("������ �ʹ� ��ϴ�.");
				continue;
			}
			break;
		}
		System.out.print("�̸� �Է� : ");
		Lname = scan.next();
		while (true) {
			System.out.print("�޴��� ��ȣ �Է� (ex : 010-1111-1111) : "); // ���� �´��� Ȯ��
			phoneNum = scan.next();

			if (phoneNum.length() != 13) {
				System.out.println("���Ŀ� ���� �ʽ��ϴ�.");
				continue;
			}
			if (phoneNum.charAt(3) != '-' || phoneNum.charAt(8) != '-') {
				System.out.println("���Ŀ� ���� �ʽ��ϴ�.");
				continue;
			}
			break;
		}
		while (true) {
			System.out.print("���� �Է� (ex : M / F �Է�) : "); // ***m, f �Է��ϸ� �������� if�� �Ἥ male / female �� �ֵ���
			sex = scan.next();
			if (sex.equals("f") || sex.equals("m") || sex.equals("F") || sex.equals("M")) {

				break; // ���߿� �̰� ó���Ҷ� if ������***
			}
			System.out.println("���Ŀ� ���� �ʽ��ϴ�");
		}
		while (true) {
			System.out.print("���� �Է� (10�� ~ 100��) : ");
			age = scan.nextInt();
			break;
		}

		try {
			sql = "insert into information values ('" + em + "', '" + passWord + "', " + "'customer')";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();

		} catch (SQLException ex2) {
			System.err.println("sql error = " + ex2.getMessage());
		}
		// test
		System.out.println("information table �Է¿Ϸ�");
		if (sex.equals("M") || sex.equals("m"))
			sex = "male";
		else
			sex = "female";
		try {
			sql = "insert into customer values ('" + Fname + "', '" + Lname + "', '" + phoneNum + "', '" + em + "', '"
					+ sex + "', " + age + ")";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();

		} catch (SQLException ex2) {
			System.err.println("sql error = " + ex2.getMessage());
		}
		// test
		System.out.println("customer table �Է¿Ϸ�");

	} // customerIn bracket end

	public static void customerQuery(Connection conn, Statement stmt, Scanner scan) {
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

	public static void customerQuery1(Connection conn, Statement stmt, Scanner scan) { // 1. Ư�� ���� ������ ���� ��ȸ
		PreparedStatement ps;
		ResultSet rs;
		String sql = "";
		System.out.println("===== Ư�� ���� ������ ���� ��ȸ =====");
		System.out.println("���� �Է� : ");
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

				System.out.println(fn + " | " + pr + " ��");
			}

			rs.close();

		} catch (SQLException ex2) {
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}

	public static void customerQuery2(Connection conn, Statement stmt, Scanner scan) { // 2. �򰡰� Ư�� ���� �̻� �ִ� ���� ��ȸ
		PreparedStatement ps;
		ResultSet rs;
		String sql = "";
		System.out.println("===== �򰡰� Ư�� ���� �̻� �ִ� ���� ��ȸ =====");
		System.out.println("rating ���� �Է� : ");
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

				System.out.println(sn + " | " + rc + " ��");
			}

			rs.close();

		} catch (SQLException ex2) {
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}

	public static void customerQuery3(Connection conn, Statement stmt, Scanner scan) { // 3. ������ Ư�� ���� �̻��� ���� ��ȸ
		PreparedStatement ps;
		ResultSet rs;
		String sql = "";
		System.out.println("===== ������ Ư�� ���� �̻��� �����̸�, ��ġ, ���� ��ȸ =====");
		System.out.println("���� �Է� (�Ҽ��� ù��¥������ �Է����) : ");
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
				System.out.println(st + " | " + lo + " | " + ra + " �� ");
			}

			rs.close();

		} catch (SQLException ex2) {
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}

	public static void customerQuery4(Connection conn, Statement stmt, Scanner scan) { // 4. Ư�� ������ �����ϴ� ���� �̸� ��ȸ
		PreparedStatement ps;
		ResultSet rs;
		String sql = "";
		System.out.println("===== Ư�� ������ �����ϴ� ���� �̸� ��ȸ =====");
		System.out.println("���� �Է� : ");
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

	public static void customerQuery5(Connection conn, Statement stmt, Scanner scan) { // 5. �ַ��� �Ĵ� ���� // ���� �ʴ� ����
		PreparedStatement ps;
		ResultSet rs;
		String sql = "";
		System.out.println("===== �ַ��� �Ĵ� ���� // ����� �Ĵ� ���� -> ���� �̸�, �����, ���� ��� =====");
		System.out.println("�ַ�-> Y �Է� / ����� -> N �Է� : ");
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
				System.out.println(st + " | " + nd + " | " + pr + " �� ");
			}

			rs.close();

		} catch (SQLException ex2) {
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}

	public static void customerQuery6(Connection conn, Statement stmt, Scanner scan) { // 6. Ư�� ������ ���� ���� ��ȸ
		PreparedStatement ps;
		ResultSet rs;
		String sql = "";
		System.out.println("===== Ư�� ������ ���� �̸�, ���� ��ȸ =====");
		System.out.println("������ : �ѱ� / �߱� / �̱� / ���þ� / ȣ�� / �Ϻ� / ��Ʈ��");
		System.out.println("/ �ʸ��� / ���� / ���� / �븸 / ĳ���� / ĥ�� / ���⿡ / ������");
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
				System.out.println(fn + " | " + pr + " �� ");
			}

			rs.close();

		} catch (SQLException ex2) {
			System.out.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	}

	public static void customerQuery7(Connection conn, Statement stmt, Scanner scan) { // 7. �Ǹ��ϴ� ������ ��� Ư�� �������� ������ �̸�
																						// ���
		PreparedStatement ps;
		ResultSet rs;
		String sql = "";
		System.out.println("===== �Ǹ��ϴ� ������ ��� Ư�� �������� ������ �̸�, �ּ� ��ȸ =====");
		System.out.println("������ : �ѱ� / �߱� / �̱� / ���þ� / ȣ�� / �Ϻ� / ��Ʈ��");
		System.out.println("/ �ʸ��� / ���� / ���� / �븸 / ĳ���� / ĥ�� / ���⿡ / ������");
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

	public static void customerQuery8(Connection conn, Statement stmt, Scanner scan) { // 8. �Ǹ��ϴ� ��� ���ᰡ �ַ��� ���� // ������
																						// ����
		PreparedStatement ps;
		ResultSet rs;
		String sql = "";
		System.out.println("===== �Ǹ��ϴ� ��� ���ᰡ �ַ��� ���� // ������ ���� �� ���� �̸��� �ּ� ��ȸ =====");
		System.out.println("�ַ�-> Y �Է� / ����� -> N �Է� : ");
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
