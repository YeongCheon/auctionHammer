package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import util.Sha256Util;
import bean.User;
import db.JdbcContext;
import db.RowMapper;

/*
 * 
 * author : YeongCheon Kim
 * email : kyc1682@gmail.com
 * 
 * */

public class UserDao {
	JdbcContext jdbcTemplate;

	public UserDao(){
		jdbcTemplate = new JdbcContext();
	}

	public User userGet(String id) {
		User result = new User();

		List<User> userList = jdbcTemplate.query(
				"SELECT * FROM ah_user WHERE LOWER(user_id) = LOWER(?)",new String[]{id},
				new RowMapperForUserGet());

		if (userList != null && userList.size() > 0) {
			result = userList.get(0);
		} else {
			result = null;
		}

		return result;
	}

	public User userGet(String id, String pwd) {
		User result = new User();

		List<User> userList = jdbcTemplate
				.query(
						"SELECT * FROM ah_user WHERE LOWER(user_id) = LOWER(?) AND user_password = ?",new String[]{id, pwd},
						new RowMapperForUserGet());

		if (userList != null && userList.size() > 0) {
			result = userList.get(0);
		} else {
			result = null;
		}

		return result;
	}

	public int userAdd(final User user) {
		int result = 0;
		String query = "INSERT INTO ah_user(user_id, user_nicname, user_password, user_pwdHint"
				+ ", user_answer, user_name, user_gender, user_birthday, "
				+ "user_emailID, user_emailDomain, user_localNum, user_callNum, "
				+ "user_phone, user_zipcode, user_addr1, user_addr2, user_type) "
				+ "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		result = jdbcTemplate.update(query, user.getUser_id(), user.getUser_nicname(),
				Sha256Util.getEncrypt(user.getUser_password()), user.getUser_pwdHint(), user.getUser_answer(),
				user.getUser_name(), user.getUser_gender(), user.getUser_birthday(),
				user.getUser_emailID(), user.getUser_emailDomain(), user.getUser_localNum(),
				user.getUser_callNum(), user.getUser_phone(), user.getUser_zipcode(),
				user.getUser_addr1(), user.getUser_addr2(), user.getUser_type());

		return result;

	}

	public int userModify(final User user) {
		int result = 0;
		String query = "UPDATE ah_user SET "
				+ "user_nicname= ?, user_pwdHint = ?, "
				+ "user_answer = ?, user_name = ?, user_gender = ?, user_birthday = ?, "
				+ "user_emailID = ?, user_emailDomain = ?, user_localNum = ?, "
				+ "user_callNum = ?, user_phone = ?, user_zipcode = ?, "
				+ "user_addr1 = ?, user_addr2 = ? "
				+ "WHERE user_id = ? ";

		result = jdbcTemplate.update(query, user.getUser_nicname(),
				user.getUser_pwdHint(), user.getUser_answer(), user.getUser_name(),
				user.getUser_gender(), user.getUser_birthday(), user.getUser_emailID(),
				user.getUser_emailDomain(), user.getUser_localNum(), user.getUser_callNum(),
				user.getUser_phone(), user.getUser_zipcode(), user.getUser_addr1(),
				user.getUser_addr2(), user.getUser_id());

		return result;
	}

	public int userModifyPassword(final User user) {
		int result = 0;

		String query = "UPDATE ah_user SET user_password = ? WHERE user_id = ?";

		result = jdbcTemplate
				.update(query, Sha256Util.getEncrypt(user.getUser_password()), user.getUser_id());

		return result;
	}

	public void deleteAll() {
		jdbcTemplate.update("DELETE FROM ah_user");
	}

	public int userCount() {
		int result = 0;
		List<Integer> tempResult = jdbcTemplate.query(
				"SELECT COUNT(*) FROM ah_user", new RowMapper<Integer>() {
					@Override
					public Integer mapRow(ResultSet rs)
							throws SQLException {
						Integer result = null;
						result = new Integer(rs.getInt(1));

						return result;
					}

				});

		if (tempResult != null) {
			result = tempResult.get(0);
		}

		return result;

	}

}

class RowMapperForUserGet implements RowMapper<User> {
	@Override
	public User mapRow(ResultSet rs) throws SQLException {
		// TODO Auto-generated method stub
		User user = new User();

		user.setUser_id(rs.getString("user_id"));
		user.setUser_nicname(rs.getString("user_nicname"));
		user.setUser_password(rs.getString("user_password"));
		user.setUser_pwdHint(rs.getString("user_pwdHint"));
		user.setUser_answer(rs.getString("user_answer"));
		user.setUser_name(rs.getString("user_name"));
		user.setUser_gender(rs.getString("user_gender"));
		user.setUser_birthday(rs.getString("user_birthday"));
		user.setUser_emailID(rs.getString("user_emailID"));
		user.setUser_emailDomain(rs.getString("user_emailDomain"));
		user.setUser_localNum(rs.getString("user_localNum"));
		user.setUser_callNum(rs.getString("user_callNum"));
		user.setUser_phone(rs.getString("user_phone"));
		user.setUser_zipcode(rs.getString("user_zipcode"));
		user.setUser_addr1(rs.getString("user_addr1"));
		user.setUser_addr2(rs.getString("user_addr2"));
		user.setUser_type(rs.getString("user_type"));
		user.setUser_regDate(rs.getString("user_regDate"));

		return user;
	}

}