package db;

import java.sql.Connection;

/*
 * author : YeongCheon Kim
 * email : kyc1682@gmail.com
 * 
 * */
import java.sql.DriverManager;
import java.sql.SQLException;

public class AuctionHammerConnectionMaker {
	
	public Connection makeNewConnection() {
		Connection conn = null;
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(
					"jdbc:mariadb://192.168.0.10:3306/auctionHammer", "auctionHammer",
					"1111");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("CONN SQL EXCEPTION!!");
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			System.out.println("CONN CLASSNOTFOUND EXCEPTION!!");
			e.printStackTrace();
		}
		return conn;
	}

}
