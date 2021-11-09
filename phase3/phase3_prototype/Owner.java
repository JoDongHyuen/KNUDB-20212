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
		
		System.out.println("������ �̸����� �Է��ϼ���. ex) vkbp31z1@nano.com");
		String o_email = scan.next();
		o_email = " " + o_email;
		
		System.out.println("1. ���� ���� ���� 2. ���� ���� ���� 3. ���� ���� ���� Ȯ��");
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
	         System.out.println("1. Fname ����  2. Lname ����  3.�޴���ȭ ����  4.���� ����");
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
	         System.out.printf("������ ���� �Է����ּ��� : ");
	         String var = scan.nextLine();
	         ps.setString(1, var);
	         ps.executeUpdate();
	         
	      } catch (SQLException e) {
	         e.printStackTrace();
	      }
	}
	
	public static void o_register(Connection conn, Statement stmt, Scanner scan) {//ȸ������
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
		         System.out.print("���� �Է� : ");
		         fname = scan.next();
		         
		         if(fname.length() > 2) {
		            System.out.println("������ �ʹ� ��ϴ�.");
		            continue;
		         }
		         break;
		      }

			 System.out.print("�̸� �Է� : ");
			 String lname = scan.next();
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
			
			 sql = "select owner_email from owner";
			 while (true) {
				 System.out.print("e-mail �ּ� �Է� (@nano.com ��õ) : ");
				 email = scan.next();
				 email = " " + email;
				 int flag = 1; // ��ġ�� �� ������ flag = 0 �� �ٲ�
	
				 ps = conn.prepareStatement(sql);
				 rs = ps.executeQuery();
				 while (rs.next()) {
					 String temp_e = rs.getString(1);
					 if (temp_e.equals(email)) {
						 flag = 0;
						 break;
					 }
		        }  
				 if (flag == 0) { // ��ġ�� �� ����
					 System.out.println("e-mail �� ��Ĩ�ϴ�. �ٽ� �Է����ּ���.");
					 continue;
				 }
				 if(!(email.substring(email.length() - 4, email.length()).equals(".com"))) {
					 System.out.println("e-mail ���Ŀ� ���� �ʽ��ϴ�. �ٽ� �Է����ּ���.");
					 continue;
				 }
				 break;
			 }
			
			 while (true) {
				 System.out.print("password �Է� (15�ڸ� �̳�, �ּ� 6�ڸ� ���� ��õ) : ");
				 password = scan.next();
		         if(password.length() > 15 || password.length() < 6) {
		        	 System.out.println("password ���̰� �ȸ½��ϴ�. �ٽ� �Է����ּ���.");
		        	 continue;
		         }
		         break;
			 }

			 while (true) {
				 System.out.print("���� �Է� (ex : M / F �Է�) : "); //***m, f �Է��ϸ� �������� if�� �Ἥ male / female �� �ֵ���
		         sex = scan.next();
		         if(sex.equals("f") || sex.equals("F")){
		        	 sex = "female";
		        	 break; // ���߿� �̰� ó���Ҷ� if ������***
		         }
		         else if(sex.equals("m") || sex.equals("M")){
		        	 sex = "male";
		        	 break;
		         }
		         System.out.println("���Ŀ� ���� �ʽ��ϴ�");
			 }

			 System.out.print("������ ���̸� �Է� : ");
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
			System.out.print("���� �̸� �Է� : ");
			String sname = scan.next();
			System.out.print("���� Ÿ�� �Է�(�ް�������, �Ϲ�������, ����������) : ");
			String type = scan.next();
			System.out.print("���� �¼� �� �Է� : ");
			int seat = scan.nextInt();
			System.out.print("���� �ּ� �Է� : ");
			String location = scan.next();
			ps.setString(1, sname);
			ps.setString(2, type);
			ps.setInt(3, seat);
			ps.setString(4, location);
			ps.setInt(5, bnum);
			rs = ps.executeQuery();
			
			System.out.println("ȸ�� ������ �Ϸ�Ǿ����ϴ�.");
			
			while(true) {
				System.out.println("1. ���Կ� ���� �߰� 2. ���Կ� ���� �߰� 0. ����");
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
			
			System.out.print("���� �̸� �Է� : ");
			String food_name = scan.next();
			System.out.print("���� ���� �Է� : ");
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
			
			System.out.print("���� �̸� �Է� : ");
			String beverage_name = scan.next();
			System.out.print("���� ���� �Է� : ");
			int price = scan.nextInt();
	
			while(true) {
				System.out.print("���� ����(Y, N) : ");
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
					System.out.println("���Ŀ� �°� �Է����ּ���.");
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
	
	public static void StoreChange(String owner_email) { // �ٸ� ���� ���� �߰� ????
		
		String stName, stType, stLoc;
		int stSeats, bNum = 0;
		System.out.println("�ٲ� ���� ����");
		System.out.println("1. ���� �̸�");
		System.out.println("2. ���� ����");
		System.out.println("3. �¼� ��");
		System.out.println("4. ���� ��ġ");
		//System.out.println("5. �Ϸ�, ���� ����");
		System.out.println("���� �Է� : ");
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
			System.out.print("�ٲ� ���� �̸� �Է� : ");
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
			System.out.println("����Ǿ����ϴ�");
			break;
		}
		case 2:
		{
			System.out.print("�ٲ� ���� ���� �Է� (����������, �ް�������, �Ϲ�������, ...): ");
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
			System.out.println("����Ǿ����ϴ�");
			break;
		}
		case 3:
		{
			System.out.print("������ �¼� �� �Է� : ");
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
			System.out.println("����Ǿ����ϴ�");
			break;
		}
		case 4:
		{
			System.out.print("4. ���� ��ġ");
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
			System.out.println("����Ǿ����ϴ�");
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
