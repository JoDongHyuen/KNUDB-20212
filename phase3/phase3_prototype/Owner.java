package phase3;

import java.sql.*;
import java.util.Date;
import java.util.Scanner;

public class Owner {
	public static void ownerFunction(Connection conn, Statement stmt, Scanner scan) {
		int num;
		
		System.out.println("1. 로그인하기 2. 회원가입하기");
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
	
	public static void o_login(Connection conn, Statement stmt, Scanner scan) {//로그인
		int num;
		
		System.out.println("점주의 이메일을 입력하세요. ex) vkbp31z1@nano.com");
		String o_email = scan.next();
		o_email = " " + o_email;
		
		System.out.println("1. 점주 정보 변경 2. 점포 정보 변경 3. 본인 점포 상태 확인");
		num = scan.nextInt();
		switch(num) {
			case 1:
				change_owner(conn, stmt, scan, o_email);
				break;
			case 2: 
				change_store(conn, stmt, scan, o_email);
				break;
			case 3:
				ownerQuery(conn, stmt, scan, o_email);
				break;
		}
	}
	
	public static void change_owner(Connection conn, Statement stmt, Scanner scan, String o_email) {
		try {
	         String sql = "";
	         PreparedStatement ps = null;
	         System.out.println("1. Fname 변경  2. Lname 변경  3.휴대전화 변경  4.나이 변경");
	         int num = scan.nextInt();
	         scan.nextLine();
	         switch (num)
	         {
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
	         System.out.printf("변경할 값을 입력해주세요 : ");
	         String var = scan.nextLine();
	         ps.setString(1, var);
	         ps.executeUpdate();
	         
	      } catch (SQLException e) {
	         e.printStackTrace();
	      }
	}
	
	public static void o_register(Connection conn, Statement stmt, Scanner scan) {//회원가입
		String sql, email, password, fname, phoneNum, sex;
		int age;

		try {
			sql = "SELECT COUNT(*) FROM OWNER";
			
			ResultSet rs = stmt.executeQuery(sql);
			rs.next();
			int bnum = rs.getInt(1) + 1;
			sql = "INSERT INTO STORE VALUES(?, 'k', 'k', 44, 'k')";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, bnum);
			rs = ps.executeQuery();
			
			 while (true) {
		         System.out.print("성씨 입력 : ");
		         fname = scan.next();
		         
		         if(fname.length() > 2) {
		            System.out.println("성씨가 너무 깁니다.");
		            continue;
		         }
		         break;
		      }

			 System.out.print("이름 입력 : ");
			 String lname = scan.next();
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
			
			 sql = "select owner_email from owner";
			 while (true) {
				 System.out.print("e-mail 주소 입력 (@nano.com 추천) : ");
				 email = scan.next();
				 email = " " + email;
				 int flag = 1; // 겹치는 것 있으면 flag = 0 로 바꿈
	
				 ps = conn.prepareStatement(sql);
				 rs = ps.executeQuery();
				 while (rs.next()) {
					 String temp_e = rs.getString(1);
					 if (temp_e.equals(email)) {
						 flag = 0;
						 break;
					 }
		        }  
				 if (flag == 0) { // 겹치는 것 있음
					 System.out.println("e-mail 이 겹칩니다. 다시 입력해주세요.");
					 continue;
				 }
				 if(!(email.substring(email.length() - 4, email.length()).equals(".com"))) {
					 System.out.println("e-mail 형식에 맞지 않습니다. 다시 입력해주세요.");
					 continue;
				 }
				 break;
			 }
			
			 while (true) {
				 System.out.print("password 입력 (15자리 이내, 최소 6자리 숫자 추천) : ");
				 password = scan.next();
		         if(password.length() > 15 || password.length() < 6) {
		        	 System.out.println("password 길이가 안맞습니다. 다시 입력해주세요.");
		        	 continue;
		         }
		         break;
			 }

			 while (true) {
				 System.out.print("성별 입력 (ex : M / F 입력) : "); //***m, f 입력하면 넣을때는 if문 써서 male / female 로 넣도록
		         sex = scan.next();
		         if(sex.equals("f") || sex.equals("F")){
		        	 sex = "female";
		        	 break; // 나중에 이거 처리할때 if 문쓰기***
		         }
		         else if(sex.equals("m") || sex.equals("M")){
		        	 sex = "male";
		        	 break;
		         }
		         System.out.println("형식에 맞지 않습니다");
			 }

			 System.out.print("점주의 나이를 입력 : ");
			 age = scan.nextInt();
			
			sql = "INSERT INTO INFORMATION VALUES(?, ?, ?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			ps.setString(2, password);
			ps.setString(3, "owner");
			rs = ps.executeQuery();
			
			sql = "INSERT INTO OWNER VALUES(?, ?, ?, ?, ?, ?, ?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, bnum);
			ps.setString(2, fname);
			ps.setString(3, lname);
			ps.setString(4, phoneNum);
			ps.setString(5, email);
			ps.setString(6, sex);
			ps.setInt(7, age);
			rs = ps.executeQuery();
			
			sql = "UPDATE STORE SET Store_name = ?, Store_type = ?, Seat_number = ?, Location = ? WHERE Breg_number = ?";
			ps = conn.prepareStatement(sql);
			System.out.print("가게 이름 입력 : ");
			String sname = scan.next();
			System.out.print("가게 타입 입력(휴게음식점, 일반음식점, 제과점영업) : ");
			String type = scan.next();
			System.out.print("가게 좌석 수 입력 : ");
			int seat = scan.nextInt();
			System.out.print("가게 주소 입력 : ");
			String location = scan.next();
			ps.setString(1, sname);
			ps.setString(2, type);
			ps.setInt(3, seat);
			ps.setString(4, location);
			ps.setInt(5, bnum);
			rs = ps.executeQuery();
			
			System.out.println("회원 가입이 완료되었습니다.");
			
			while(true) {
				System.out.println("1. 가게에 음식 추가 2. 가게에 음료 추가 0. 종료");
				int f_num = scan.nextInt();

				if(f_num == 1) 
					add_food(conn, stmt, scan, email, bnum);
				
				if(f_num == 2)
					add_beverage(conn, stmt, scan, email, bnum);
				
				if(f_num == 0)
					break;
			}
		}catch (SQLException e){
			System.out.println("Insert Error: " + e);
		}
	}

	public static void add_food(Connection conn, Statement stmt, Scanner scan, String o_email, int bnum) {
		ResultSet rs;
		int f_id;
		String sql;
		PreparedStatement ps;
		
		try {
			sql = "SELECT COUNT(*) FROM FOOD";
			rs = stmt.executeQuery(sql);
			rs.next();
			f_id = rs.getInt(1) + 1;
			
			sql = "INSERT INTO FOOD VALUES(?, ?, ?, ?)";
			ps = conn.prepareStatement(sql);
			
			System.out.print("음식 이름 입력 : ");
			String food_name = scan.next();
			System.out.print("음식 가격 입력 : ");
			int price = scan.nextInt();
			
			ps.setInt(1, bnum);
			ps.setInt(2, f_id);
			ps.setInt(3, price);
			ps.setString(4, food_name);
			rs = ps.executeQuery();
			
		} catch (SQLException e){
			System.out.println("Insert Error: " + e);
		}
	}
	
	public static void add_beverage(Connection conn, Statement stmt, Scanner scan, String o_email, int bnum) {
		int b_id;
		String sql, alcohol;
		PreparedStatement ps;
		ResultSet rs;
		
		try {
			sql = "SELECT COUNT(*) FROM BEVERAGE";
			rs = stmt.executeQuery(sql);
			rs.next();
			b_id = rs.getInt(1) + 1;
			
			sql = "INSERT INTO BEVERAGE VALUES(?, ?, ?, ?, ?)";
			ps = conn.prepareStatement(sql);
			
			System.out.print("음료 이름 입력 : ");
			String beverage_name = scan.next();
			System.out.print("음료 가격 입력 : ");
			int price = scan.nextInt();
	
			while(true) {
				System.out.print("알콜 유무(Y, N) : ");
				alcohol = scan.next();
				if(alcohol.equals("Y") || alcohol.equals("y")) {
					alcohol = "Y";
					break;
				}
				else if(alcohol.equals("N") || alcohol.equals("n")) {
					alcohol = "N";
					break;
				}
				else
					System.out.println("형식에 맞게 입력해주세요.");
			}	
			ps.setInt(1, bnum);
			ps.setInt(2, b_id);
			ps.setString(3, alcohol);
			ps.setString(4, beverage_name);
			ps.setInt(5, price);
			rs = ps.executeQuery();
			
		} catch (SQLException e){
			System.out.println("Insert Error: " + e);
		}
	}
	
	public static void StoreChange(String owner_email) { // 다른 정보 변경 추가 ????
		
		String stName, stType, stLoc;
		int stSeats, bNum = 0;
		System.out.println("바꿀 정보 선택");
		System.out.println("1. 가게 이름");
		System.out.println("2. 가게 종류");
		System.out.println("3. 좌석 수");
		System.out.println("4. 가게 위치");
		//System.out.println("5. 완료, 정보 저장");
		System.out.println("숫자 입력 : ");
		Scanner scan = new Scanner(System.in);
		PreparedStatement ps;
		ResultSet rs;
		int num = scan.nextInt();
		String sql = "select Bnum from owner where owner_email = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, owner_email);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				bNum = rs.getInt(1);
			}
			
		} catch (SQLException ex2) {
			System.err.println("sql error = " + ex2.getMessage());
		}
		
		switch(num) {
		case 1:
		{
			System.out.print("바꿀 가게 이름 입력 : ");
			stName = scan.next();
			try {
				sql = "Update store set store_name = ? WHERE breg_number = "
						+ bNum;
				ps = conn.prepareStatement(sql);
				ps.setString(1, stName);
				rs = ps.executeQuery();
				
			} catch (SQLException ex2) {
				System.err.println("sql error = " + ex2.getMessage());
			}
			System.out.println("변경되었습니다");
			break;
		}
		case 2:
		{
			System.out.print("바꿀 가게 종류 입력 (제과점영업, 휴게음식점, 일반음식점, ...): ");
			stName = scan.next();
			try {
				sql = "Update store set store_type = ? WHERE breg_number = "
						+ bNum;
				ps = conn.prepareStatement(sql);
				ps.setString(1, stName);
				rs = ps.executeQuery();
				
			} catch (SQLException ex2) {
				System.err.println("sql error = " + ex2.getMessage());
			}
			System.out.println("변경되었습니다");
			break;
		}
		case 3:
		{
			System.out.print("변경할 좌석 수 입력 : ");
			stSeats = scan.nextInt();
			try {
				sql = "Update store set Seat_number = ? WHERE breg_number = "
						+ bNum;
				ps = conn.prepareStatement(sql);
				ps.setInt(1, stSeats);
				rs = ps.executeQuery();
				
			} catch (SQLException ex2) {
				System.err.println("sql error = " + ex2.getMessage());
			}
			System.out.println("변경되었습니다");
			break;
		}
		case 4:
		{
			System.out.print("4. 가게 위치");
			stLoc = scan.next();
			try {
				sql = "Update store set Location = ? WHERE breg_number = "
						+ bNum;
				ps = conn.prepareStatement(sql);
				ps.setString(1, stLoc);
				rs = ps.executeQuery();
				
			} catch (SQLException ex2) {
				System.err.println("sql error = " + ex2.getMessage());
			}
			System.out.println("변경되었습니다");
			break;
		}
		default:
			break;
		
		}
		
	}


	
	public static void ownerQuery(Connection conn, Statement stmt, Scanner scan, String o_email) {
		int num;

		try {
			conn.setAutoCommit(false);

			System.out.println("알고 싶은 정보의 번호를 입력하세요.");
			System.out.println("1. 본인 가게 이름과 예약한 사람의 이름, 시간 조회");
			System.out.println("2. 본인 가게 이름과 리뷰 조회");
			System.out.println("3. 본인 가게에 평점 4점 이상 준 고객의 이메일, 평점을 조회(평점으로 내림차순)");
			System.out.println("4. 특정 시간 이후 본인 가게에 예약을 한 사람 이름과 시간 대 조회");
			System.out.println("5. 본인 가게와 동종업계 가게의 이름, 평균 가격, 평균 평점 조회");
			System.out.println("0. 종료");

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

	// 본인가게 예약한 사람과 시간 조회 Type2-1
	private static void ownerQuery1(Connection conn, Statement stmt, Scanner scan, String o_email) {
		try {
			String sql = "SELECT S.Store_name, B.Time, C.Fname, C.Lname FROM STORE S, CUST_BOOKS_STR B, CUSTOMER C, OWNER O WHERE C.Customer_Email = B.Cemail and B.Bnum = S.Breg_number and B.Bnum = O.Bnum and O.Owner_Email = ?";
			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, o_email);
			ResultSet rs = ps.executeQuery();

			System.out.println("가게 명 | 예약 날짜 | 고객 Fname | 고객 Lname");
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

	// 본인가게 리뷰조회 Type5-1
	private static void ownerQuery2(Connection conn, Statement stmt, Scanner scan, String o_email) {
		try {
			String sql = "SELECT S.Store_name, R.Score FROM OWNER O, RATING R, STORE S WHERE O.Bnum = S.Breg_number and O.Bnum = R.Bnum and OWNER_EMAIL = ?";
			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, o_email);
			ResultSet rs = ps.executeQuery();

			System.out.println("가게 명 | 평점");
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

	// 본인가게 평점 4점이상 준 고객 이메일, 가게 명, 평점 조회, 평점으로 내림차순
	private static void ownerQuery3(Connection conn, Statement stmt, Scanner scan, String o_email) {
		try {
			String sql = "SELECT S.Store_name, C.Customer_email, R.Score   FROM CUSTOMER C, RATING R, STORE S, OWNER O WHERE Score >= 4 AND C.Customer_email = R.Cemail AND R.Bnum = S.Breg_number AND O.Bnum = R.bnum AND O.Owner_email = ? ORDER BY Score DESC";
			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, o_email);
			ResultSet rs = ps.executeQuery();

			System.out.println("가게 명 | 고객 이메일 | 평점");
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

	// 특정날짜 이후 예약이 있는 사람
	private static void ownerQuery4(Connection conn, Statement stmt, Scanner scan, String o_email) {
		try {
			String sql = "SELECT C.Fname, C.Lname, TO_CHAR(B.Time, 'YYYY-MM-DD HH24:MI:SS') as B_date FROM CUSTOMER C,  CUST_BOOKS_STR B, OWNER O WHERE B.Time > ?  AND C.Customer_email = B.Cemail AND O.Owner_email = ? and O.Bnum = B.Bnum ORDER BY B.time";
			PreparedStatement ps = conn.prepareStatement(sql);

			System.out.println("날짜를 입력해주세요.(YYYY-MM-DD) ex) 2021-09-30");
			String input_date = scan.next();
			ps.setString(1, input_date);
			ps.setString(2, o_email);
			ResultSet rs = ps.executeQuery();

			System.out.println("고객 Fname | 고객 Lname | 예약 날짜");
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

	// 본인가게와 동종업계 가게의 이름, 평균가격, 평균 평점
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

			System.out.println("동종 업계 가게 명 | 평균 가격 | 평균 평점");
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
