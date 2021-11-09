import java.sql.*;
import java.io.*;
import java.util.*;

public class phase33 {
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
			case 4 :
				CustomerIn();
		}
	} // main end bracket
	
	public static int login() {
		System.out.println("�α����� ������ �������ּ���. 1) OWNER 2) CUSTOMER 3) ADMINISTRATOR");
		Scanner scan = new Scanner(System.in);
		int login_type = scan.nextInt();
		
		return login_type;
	}
	
	// ���� �ؾ��� �� : customer table, information table, rating �ۼ� �Լ�
	public static void CustomerIn() { // ȸ������ ������
		Scanner scan = new Scanner(System.in);
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
			if(!(em.substring(em.length() - 4, em.length()).equals(".com"))) {
				System.out.println("e-mail ���Ŀ� ���� �ʽ��ϴ�. �ٽ� �Է����ּ���.");
				continue;
			}
			break;
		}//while bracket end
		//information ���̺� ���� email �־���� �θ�Ű ���� ���� �ȵ�
		while (true) {
			System.out.print("password �Է� (15�ڸ� �̳�, �ּ� 6�ڸ� ���� ��õ) : ");
			passWord = scan.next();
			if(passWord.length() > 15 || passWord.length() < 6) {
				System.out.println("password ���̰� �ȸ½��ϴ�. �ٽ� �Է����ּ���.");
				continue;
			}
			break;
		}
		while (true) {
			System.out.print("���� �Է� : ");
			Fname = scan.next();
			
			if(Fname.length() > 2) {
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
		
			if(phoneNum.length() != 13) {
				System.out.println("���Ŀ� ���� �ʽ��ϴ�.");
				continue;
			}
			if(phoneNum.charAt(3) != '-' || phoneNum.charAt(8) != '-') {
				System.out.println("���Ŀ� ���� �ʽ��ϴ�.");
				continue;
			}
			break;
		}
		while (true) {
			System.out.print("���� �Է� (ex : M / F �Է�) : "); //***m, f �Է��ϸ� �������� if�� �Ἥ male / female �� �ֵ���
			sex = scan.next();
			if(sex.equals("f") || sex.equals("m") || sex.equals("F") || sex.equals("M")) {

				break; // ���߿� �̰� ó���Ҷ� if ������***
			}
			System.out.println("���Ŀ� ���� �ʽ��ϴ�");
		}
		while (true) {
			System.out.print("���� �Է� (10�� ~ 100��) : ");
			age = scan.nextInt();
			if(age < 10 || age > 100) {
				System.out.println("���Ŀ� ���� �ʽ��ϴ�.");
				continue;
			}
			break;
		}
		
		try {
			sql = "insert into information values ('"
					+ em + "', '"
					+ passWord + "', "
					+ "'customer')";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			
		} catch (SQLException ex2) {
			System.err.println("sql error = " + ex2.getMessage());
		}
		//test
		System.out.println("information table �Է¿Ϸ�");
		if(sex.equals("M") || sex.equals("m"))
			sex = "male";
		else
			sex = "female";
		try {
			sql = "insert into customer values ('"
					+ Fname + "', '"
					+ Lname + "', '"
					+ phoneNum + "', '"
					+ em + "', '"
					+ sex + "', "
					+ age + ")";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			
		} catch (SQLException ex2) {
			System.err.println("sql error = " + ex2.getMessage());
		}
		//test
		System.out.println("customer table �Է¿Ϸ�");
		
	} // customerIn bracket end

}
