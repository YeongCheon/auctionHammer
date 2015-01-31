package db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;


/*
 * author : YeongCheon Kim
 * email : kyc1682@gmail.com
 * 
 * */
public interface StatementStrategy{
	PreparedStatement makePreparedStatement(Connection conn) throws SQLException;
}
