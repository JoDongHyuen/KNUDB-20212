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
				
				System.out.println("INSERT할 TABLE을 입력해주세요");
				System.out.println("(1. CUSTOMER, 2. STORE, 3. CUST_BOOKS_STR, 4. FOOD, 5. ORIGIN, 6. BEVERAGE, 7. OWNER, 8. RATING)");
				int table = scan.nextInt();
				System.out.println(table);
				
				if(table == 1) {
					System.out.println("이름의 성을 입력해주세요.");
					String fname = scan.next();
					System.out.println("이름을 입력해주세요.");
					String lname = scan.next();
					System.out.println("휴대폰 번호를 입력해주세요.");
					String phone = scan.next();
					System.out.println("이메일을 입력해주세요.");
					String email = scan.next();
					System.out.println("성별을 입력해주세요.(male, female)");
					String sex = scan.next();
					System.out.println("나이를 입력해주세요.");
					int age = scan.nextInt();

					sql = "INSERT INTO CUSTOMER VALUES('" + fname + "', '" + lname + "', '" + phone + "', '" + email + "', '" + sex + "', " + age + ")";
					int res = stmt.executeUpdate(sql);
				}
				
				if(table == 2) {
					System.out.println("가게 등록 번호를 입력해주세요.");
					int bnum = scan.nextInt();
					System.out.println("가게 이름을 입력해주세요.");
					String sname = scan.next();
					System.out.println("가게 타입을 입력해주세요.(휴게음식점, 일반음식점)");
					String type = scan.next();
					System.out.println("가게 좌석 수를 입력해주세요.");
					int seat = scan.nextInt();
					System.out.println("가게 주소를 입력해주세요.");
					String location = scan.next();
					
					sql = "INSERT INTO STORE VALUES(" + bnum + ", '" + sname + "', '" + type + "', " + seat + ", '" + location + "')";
					int res = stmt.executeUpdate(sql);
				}
				
				if(table == 3) {
					System.out.println("고객의 이메일을 입력해주세요.");
					String email = scan.next();
					System.out.println("가게 등록 번호를 입력해주세요.");
					int bnum = scan.nextInt();
					System.out.println("예약된 날짜를 입력해주세요.(yy-mm-dd)");
					String b_date = scan.next();
					
					sql = "INSERT INTO CUST_BOOKS_STR VALUES('" + email + "', " + bnum + ", to_date('" + b_date + "', 'YY-MM-DD'))";
					int res = stmt.executeUpdate(sql);
				}
				
				if(table == 4) {
					System.out.println("가게 등록 번호를 입력해주세요.");
					int bnum = scan.nextInt();
					System.out.println("음식 등록 번호를 입력해주세요.");
					int fnum = scan.nextInt();
					System.out.println("음식의 가격을 입력해주세요.");
					int price = scan.nextInt();
					System.out.println("음식의 이름을 입력해주세요.");
					String food_name = scan.next();
					
					sql = "INSERT INTO FOOD VALUES(" + bnum + ", " + fnum + ", " + price + ", '" + food_name + "')";
					int res = stmt.executeUpdate(sql);
				}
				if(table == 5) {
					System.out.println("국가의 등록 번호를 입력해주세요.");
					int cid = scan.nextInt();
					System.out.println("국가의 이름을 입력해주세요.");
					String cname = scan.next();
					
					sql = "INSERT INTO ORIGIN VALUES(" + cid + ", '" + cname + "')";
					int res = stmt.executeUpdate(sql);
				}
				
				if(table == 6) {
					System.out.println("가게 등록 번호를 입력해주세요.");
					int bnum = scan.nextInt();
					System.out.println("음료수 등록 ID를 입력해주세요.");
					int did = scan.nextInt();
					System.out.println("알코올 여부를 입력해주세요.(Y, N)");
					String alcohol = scan.next();
					System.out.println("음료수의 이름을 입력해주세요.");
					String dname = scan.next();
					System.out.println("음료수의 가격을 입력해주세요.");
					int price = scan.nextInt();
					
					sql = "INSERT INTO BEVERAGE VALUES(" + bnum + ", " + did + ", '" + alcohol + "', '" + dname + "', " + price + ")";
					int res = stmt.executeUpdate(sql);
				}
				
				if(table == 7) {
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
					
					sql = "INSERT INTO OWNER VALUES(" + bnum + ", '" + fname + "', '" + lname + "', '" + phone + "', '" + email + "', '" + sex + "', " + age + ")";
					int res = stmt.executeUpdate(sql);
				}
				
				if(table == 8) {
					System.out.println("가게 등록 번호를 입력해주세요.");
					int bnum = scan.nextInt();
					System.out.println("고객의 이메일을 입력해주세요.");
					String cemail = scan.next();
					System.out.println("점수를 입력해주세요.");
					float score = scan.nextFloat();
					System.out.println("Rating의 ID를 입력해주세요.");
					int id = scan.nextInt();
					
					sql = "INSERT INTO RATING VALUES(" + bnum + ", '" + cemail + "', " + score + ", " + id + ")";
					int res = stmt.executeUpdate(sql);
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}
