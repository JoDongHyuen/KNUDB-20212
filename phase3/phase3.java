package lab7;

import java.sql.*;
import java.text.*;
import java.util.Date;
import java.io.*;
import java.util.Scanner;

public class phase3 {
	public static final String URL = "jdbc:oracle:thin:@localhost:1521:orcl";
	public static final String USER_RESTAURANT = "restaurant";
	public static final String USER_PASSWD = "restaurant";
	//public static final String TABLE_NAME = "TEST";
	
	public static void main(String[] args) throws IOException{
		
		// TODO Auto-generated method stub
		Scanner scan = new Scanner(System.in);
		Connection conn = null;
		Statement stmt = null;
		String sql = "";
		int i;
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("Driver Loading: Success!");
		}catch(ClassNotFoundException e) {
			System.err.println("error = " + e.getMessage());
			System.exit(1);
		}
		
		try {
			conn = DriverManager.getConnection(URL, USER_RESTAURANT, USER_PASSWD);
			System.out.println("Oracle Connected");
		}catch(SQLException ex) {
			ex.printStackTrace();
			System.err.println("Cannot get a connection: " + ex.getLocalizedMessage());
			System.err.println("Cannot get a connection: " + ex.getMessage());
			System.exit(1);
		}		
//		
//		try {
//			int res;
//			String[] table_name = {"CUSTOMER", "STORE", "FOOD", "BEVERAGE", "CUST_BOOKS_STR", "ORIGIN", "RATING", "OWNER"};
//			
//			conn.setAutoCommit(false);
//			stmt = conn.createStatement();
//			
//			for(i=0; i<table_name.length; i++)
//			{
//				sql = "DROP TABLE "+ table_name[i] +" CASCADE CONSTRAINT";
//				res = stmt.executeUpdate(sql);
//			}
//
//			sql = "create table customer( Fname varchar2(2), Lname varchar2(4), Phone_number varchar2(15), Customer_email varchar2(50) not null primary key, Sex varchar2(10) not null, Age number not null)";
//			res = stmt.executeUpdate(sql);
//		
//			sql = "create table store( Breg_number number not null primary key, Store_name varchar2(40) not null, Store_type varchar2(20), Seat_number number not null, Location varchar2(70) not null)";
//			res = stmt.executeUpdate(sql);
//		
//			sql = "create table cust_books_str( Cemail varchar2(50) not null references customer(Customer_email),  Bnum number not null references store(Breg_number), Time date not null, constraint pk_cust_books_str primary key(Cemail, Bnum))";
//			res = stmt.executeUpdate(sql);
//		
//			sql = "create table rating( Bnum number not null references store(Breg_number), Cemail varchar2(50) not null references customer(Customer_email), Score number(2,1), Id number not null, constraint pk_rating primary key(Bnum, Cemail, Id))";
//			res = stmt.executeUpdate(sql);
//		
//			sql = "create table food( Bnum number not null references store(Breg_number), Id number not null unique, Price number not null, Food_name varchar2(50) not null)";
//			res = stmt.executeUpdate(sql);
//		
//			sql = "create table origin( Id number not null references food(Id), Country_name varchar2(20), constraint pk_origin_country primary key(Id, Country_name))";
//			res = stmt.executeUpdate(sql);
//			
//			sql = "create table beverage( Bnum number not null references store(Breg_number), Id number not null, Alcohol varchar2(2), Drink_name varchar2(30) not null, Price number not null, constraint pk_beverage primary key(Bnum, Id))";
//			res = stmt.executeUpdate(sql);
//			
//			sql = "create table owner( Bnum number not null references store(breg_number), Fname varchar2(2), Lname varchar2(4), Phone_number varchar2(15), Owner_email varchar2(50) not null unique, Sex varchar2(10) not null, Age number not null,  constraint pk_owner primary key(Bnum, Owner_email))";
//			res = stmt.executeUpdate(sql);
//			
//			conn.commit();
//			System.out.println("CREATE TABLE SUCCESSFULLY");
//			
//		}catch(SQLException ex2) {
//			System.err.println("sql error = " + ex2.getMessage());
//			System.exit(1);
//		}

//		try {
//			stmt = conn.createStatement();
//			sql = "select * from origin";
//			ResultSet rs = stmt.executeQuery(sql);
//			while(rs.next()) {
//				int num = rs.getInt(1);
//				String country = rs.getString(2);
//				System.out.println(num + "  |  " + country);
//			}
//		}catch(SQLException ex2) {
//			System.out.println(ex2);
//		}

		while(true) {
			try {
				stmt = conn.createStatement();
				PreparedStatement pstmt = null;
				
				System.out.println("INSERT�� TABLE�� �Է����ּ���. ���Ḧ ���Ѵٸ� 0�� �Է��ϼ���");
				System.out.println("(1. CUSTOMER, 2. STORE, 3. CUST_BOOKS_STR, 4. FOOD, 5. ORIGIN, 6. BEVERAGE, 7. OWNER, 8. RATING)");
				int table = scan.nextInt();
				
				if(table == 0)
					break;
				
				else if(table == 1) {
					System.out.println("�̸��� ���� �Է����ּ���.");
					String fname = scan.next();
					System.out.println("�̸��� �Է����ּ���.");
					String lname = scan.next();
					System.out.println("�޴��� ��ȣ�� �Է����ּ���.");
					String phone = scan.next();
					System.out.println("�̸����� �Է����ּ���.");
					String email = scan.next();
					System.out.println("������ �Է����ּ���.(male, female)");
					String sex = scan.next();
					System.out.println("���̸� �Է����ּ���.");
					int age = scan.nextInt();

					sql = "INSERT INTO CUSTOMER VALUES('" + fname + "', '" + lname + "', '" + phone + "', '" + email + "', '" + sex + "', " + age + ")";
					int res = stmt.executeUpdate(sql);
				}
				
				else if(table == 2) {
					System.out.println("���� ��� ��ȣ�� �Է����ּ���.");
					int bnum = scan.nextInt();
					System.out.println("���� �̸��� �Է����ּ���.");
					String sname = scan.next();
					System.out.println("���� Ÿ���� �Է����ּ���.(�ް�������, �Ϲ�������)");
					String type = scan.next();
					System.out.println("���� �¼� ���� �Է����ּ���.");
					int seat = scan.nextInt();
					System.out.println("���� �ּҸ� �Է����ּ���.");
					String location = scan.next();
					
					sql = "INSERT INTO STORE VALUES(" + bnum + ", '" + sname + "', '" + type + "', " + seat + ", '" + location + "')";
					int res = stmt.executeUpdate(sql);
				}
				
				else if(table == 3) {
					System.out.println("���� �̸����� �Է����ּ���.");
					String email = scan.next();
					System.out.println("���� ��� ��ȣ�� �Է����ּ���.");
					int bnum = scan.nextInt();
					System.out.println("����� ��¥�� �Է����ּ���.(yy-mm-dd)");
					String b_date = scan.next();
					
					sql = "INSERT INTO CUST_BOOKS_STR VALUES('" + email + "', " + bnum + ", to_date('" + b_date + "', 'YY-MM-DD'))";
					int res = stmt.executeUpdate(sql);
				}
				
				else if(table == 4) {
					System.out.println("���� ��� ��ȣ�� �Է����ּ���.");
					int bnum = scan.nextInt();
					System.out.println("���� ��� ��ȣ�� �Է����ּ���.");
					int fnum = scan.nextInt();
					System.out.println("������ ������ �Է����ּ���.");
					int price = scan.nextInt();
					System.out.println("������ �̸��� �Է����ּ���.");
					String food_name = scan.next();
					
					sql = "INSERT INTO FOOD VALUES(" + bnum + ", " + fnum + ", " + price + ", '" + food_name + "')";
					int res = stmt.executeUpdate(sql);
				}
				else if(table == 5) {
					System.out.println("������ ��� ��ȣ�� �Է����ּ���.");
					int cid = scan.nextInt();
					System.out.println("������ �̸��� �Է����ּ���.");
					String cname = scan.next();
					
					sql = "INSERT INTO ORIGIN VALUES(" + cid + ", '" + cname + "')";
					int res = stmt.executeUpdate(sql);
				}
				
				else if(table == 6) {
					System.out.println("���� ��� ��ȣ�� �Է����ּ���.");
					int bnum = scan.nextInt();
					System.out.println("����� ��� ID�� �Է����ּ���.");
					int did = scan.nextInt();
					System.out.println("���ڿ� ���θ� �Է����ּ���.(Y, N)");
					String alcohol = scan.next();
					System.out.println("������� �̸��� �Է����ּ���.");
					String dname = scan.next();
					System.out.println("������� ������ �Է����ּ���.");
					int price = scan.nextInt();
					
					sql = "INSERT INTO BEVERAGE VALUES(" + bnum + ", " + did + ", '" + alcohol + "', '" + dname + "', " + price + ")";
					int res = stmt.executeUpdate(sql);
				}
				
				else if(table == 7) {
					System.out.println("���� ��� ��ȣ�� �Է����ּ���.");
					int bnum = scan.nextInt();
					System.out.println("������ �̸��� ���� �Է����ּ���.");
					String fname = scan.next();
					System.out.println("������ �̸��� �Է����ּ���.");
					String lname = scan.next();
					System.out.println("������ �޴��� ��ȣ�� �Է����ּ���.");
					String phone = scan.next();
					System.out.println("������ �̸����� �Է����ּ���.");
					String email = scan.next();
					System.out.println("������ ������ �Է����ּ���.(female, male)");
					String sex = scan.next();
					System.out.println("������ ���̸� �Է����ּ���.");
					int age = scan.nextInt();
					
					sql = "INSERT INTO OWNER VALUES(" + bnum + ", '" + fname + "', '" + lname + "', '" + phone + "', '" + email + "', '" + sex + "', " + age + ")";
					int res = stmt.executeUpdate(sql);
				}
				
				else if(table == 8) {
					System.out.println("���� ��� ��ȣ�� �Է����ּ���.");
					int bnum = scan.nextInt();
					System.out.println("���� �̸����� �Է����ּ���.");
					String cemail = scan.next();
					System.out.println("������ �Է����ּ���.");
					float score = scan.nextFloat();
					System.out.println("Rating�� ID�� �Է����ּ���.");
					int id = scan.nextInt();
					
					sql = "INSERT INTO RATING VALUES(" + bnum + ", '" + cemail + "', " + score + ", " + id + ")";
					int res = stmt.executeUpdate(sql);
				}
				conn.commit();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}
