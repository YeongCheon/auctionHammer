package db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/*
 * author : YeongCheon Kim
 * email : kyc1682@gmail.com
 * 
 * */
public class JdbcContext {
	final static int NONRETURN = 0;
	final static int GETRETURN = 1;

	public JdbcContext() {
		// TODO Auto-generated constructor stub
	}

	public int update(final String QUERY, final String... VARS) {
		int result = 0;
		ArrayList<Integer> list =
		workWithStatementStrategy(
				new StatementStrategy() {

					@Override
					public PreparedStatement makePreparedStatement(
							Connection conn) throws SQLException {
						PreparedStatement pstmt = conn.prepareStatement(QUERY);

						for (int i = 0; i < VARS.length; i++) {
							pstmt.setString(i + 1, VARS[i]);
						}

						return pstmt;
					}
				}, NONRETURN, null);
		
		if(list != null && list.size() > 0){
			result = list.get(0).intValue();
		}
		
		return result;
	}

	public <T> ArrayList<T> query(final String QUERY,  final String[] VARS,
			final RowMapper<T> rowMapper) {
		ArrayList<T> result = workWithStatementStrategy(
				new StatementStrategy() {
					@Override
					public PreparedStatement makePreparedStatement(
							Connection conn) throws SQLException {
						PreparedStatement pstmt = conn.prepareStatement(QUERY);

						for (int i = 0; i < VARS.length; i++) {
							pstmt.setString(i + 1, VARS[i]);
						}

						return pstmt;
					}
				}, GETRETURN, rowMapper);

		return result;
	}
	
	public <T> ArrayList<T> query(final String QUERY,
			final RowMapper<T> rowMapper) {
		ArrayList<T> result = workWithStatementStrategy(
				new StatementStrategy() {
					@Override
					public PreparedStatement makePreparedStatement(
							Connection conn) throws SQLException {
						PreparedStatement pstmt = conn.prepareStatement(QUERY);

						return pstmt;
					}
				}, GETRETURN, rowMapper);

		return result;
	}	

	private <T> ArrayList<T> workWithStatementStrategy(StatementStrategy stmt,
			int isReturn, RowMapper<T> rowMapper) {
		ArrayList<T> result = new ArrayList<T>();

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = getConnection();
			pstmt = stmt.makePreparedStatement(conn);
			switch (isReturn) {
			case NONRETURN:
				result.add((T) new Integer(pstmt.executeUpdate()));
				break;
			case GETRETURN:
				rs = pstmt.executeQuery();
				break;
			}
			if (rs != null) {
				while (rs.next()) {
					result.add(rowMapper.mapRow(rs));
				}
			}

		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {

				}
			}

			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {

				}
			}

			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {

				}
			}
		}
		return result;
	}

	private Connection getConnection() {
		return new AuctionHammerConnectionMaker().makeNewConnection();
	}
}
