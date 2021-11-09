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
		System.out.println("로그인할 계정을 선택해주세요. 1) OWNER 2) CUSTOMER 3) ADMINISTRATOR");
		Scanner scan = new Scanner(System.in);
		int login_type = scan.nextInt();
		
		return login_type;
	}
	
	// 내가 해야할 것 : customer table, information table, rating 작성 함수
	public static void CustomerIn() { // 회원가입 페이지
		Scanner scan = new Scanner(System.in);
		PreparedStatement ps;	
		ResultSet rs;
		String em, passWord, Fname, Lname, sex, phoneNum;
		int age;
		String sql = "select Customer_email from customer";
		while (true) {
			System.out.print("e-mail 주소 입력 (@nano.com 추천) : ");
			em = scan.next();
			em = " " + em;
			int flag = 1; // 겹치는 것 있으면 flag = 0 로 바꿈
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
			if (flag == 0) { // 겹치는 것 있음
				System.out.println("e-mail 이 겹칩니다. 다시 입력해주세요.");
				continue;
			}
			if(!(em.substring(em.length() - 4, em.length()).equals(".com"))) {
				System.out.println("e-mail 형식에 맞지 않습니다. 다시 입력해주세요.");
				continue;
			}
			break;
		}//while bracket end
		//information 테이블 부터 email 넣어야지 부모키 업음 오류 안됨
		while (true) {
			System.out.print("password 입력 (15자리 이내, 최소 6자리 숫자 추천) : ");
			passWord = scan.next();
			if(passWord.length() > 15 || passWord.length() < 6) {
				System.out.println("password 길이가 안맞습니다. 다시 입력해주세요.");
				continue;
			}
			break;
		}
		while (true) {
			System.out.print("성씨 입력 : ");
			Fname = scan.next();
			
			if(Fname.length() > 2) {
				System.out.println("성씨가 너무 깁니다.");
				continue;
			}
			break;
		}
		System.out.print("이름 입력 : ");
		Lname = scan.next();
		while (true) {
			System.out.print("휴대폰 번호 입력 (ex : 010-1111-1111) : "); // 형식 맞는지 확인
			phoneNum = scan.next();
		
			if(phoneNum.length() != 13) {
				System.out.println("형식에 맞지 않습니다.");
				continue;
			}
			if(phoneNum.charAt(3) != '-' || phoneNum.charAt(8) != '-') {
				System.out.println("형식에 맞지 않습니다.");
				continue;
			}
			break;
		}
		while (true) {
			System.out.print("성별 입력 (ex : M / F 입력) : "); //***m, f 입력하면 넣을때는 if문 써서 male / female 로 넣도록
			sex = scan.next();
			if(sex.equals("f") || sex.equals("m") || sex.equals("F") || sex.equals("M")) {

				break; // 나중에 이거 처리할때 if 문쓰기***
			}
			System.out.println("형식에 맞지 않습니다");
		}
		while (true) {
			System.out.print("나이 입력 (10세 ~ 100세) : ");
			age = scan.nextInt();
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
		System.out.println("information table 입력완료");
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
		System.out.println("customer table 입력완료");
		
	} // customerIn bracket end

}
