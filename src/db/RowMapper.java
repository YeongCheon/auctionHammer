package db;

import java.sql.ResultSet;
import java.sql.SQLException;

/*
 * author : YeongCheon Kim
 * email : kyc1682@gmail.com
 * 
 * */
public interface RowMapper<T> {
	T mapRow(ResultSet rs) throws SQLException;
}
