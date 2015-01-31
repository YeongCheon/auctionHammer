package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import bean.BoardComment;
import db.JdbcContext;
import db.RowMapper;

public class BoardCommentDao {
	JdbcContext jdbcTemplate;

	public BoardCommentDao(){
		jdbcTemplate = new JdbcContext();
	}


	public int insertComment(BoardComment comment) {
		String query = "INSERT INTO ah_board_comment(article_id, comment_writer, comment_memo) VALUES(?, ?, ?)";
		return jdbcTemplate.update(query,
				Integer.toString(comment.getArticle_id()),
				comment.getComment_writer(), comment.getComment_memo());
	}

	public int insertRereplayComment(BoardComment comment) {
		String query = "INSERT INTO ah_board_comment(article_id, comment_writer, comment_memo, comment_ip, comment_rereply) VALUES(?, ?, ?, ?, ?)";
		return jdbcTemplate.update(query, Integer.toString(comment.getArticle_id()),
				comment.getComment_writer(), comment.getComment_memo(),
				comment.getComment_ip(), Integer.toString(comment.getComment_rereplay()));
	}

	public int updateComment(BoardComment comment) {
		String query = "UPDATE ah_board_comment SET comment_memo = ?";
		return jdbcTemplate.update(query, comment.getComment_memo());
	}

	public int deleteComment(int id) {
		String query = "DELETE FROM ah_board_comment WHERE comment_id = ?";
		return jdbcTemplate.update(query, Integer.toString(id));
	}

	public BoardComment getComment(int commentId) {
		String query = "SELECT comment_id ,article_id, comment_writer, comment_memo, comment_regdate, comment_ip,comment_rereply FROM ah_board_comment WHERE comment_id = ?";
		return jdbcTemplate.query(query, new String[]{Integer.toString(commentId)},
				new RowMapper<BoardComment>(){

					@Override
					public BoardComment mapRow(ResultSet rs)
							throws SQLException {
						BoardComment comment = new BoardComment();
						comment.setComment_id(rs.getInt("comment_id"));
						comment.setArticle_id(rs.getInt("article_id"));
						comment.setComment_writer(rs.getString("comment_writer"));
						comment.setComment_memo(rs.getString("comment_memo"));
						comment.setComment_regdate(rs.getDate("comment_regdate"));
						comment.setComment_ip(rs.getString("comment_ip"));
						comment.setComment_rereplay(rs.getInt("comment_rereply"));
						
						return comment;
					}
			
		}).get(0);
	}
	
	public int getreplyCount(int article_id){
		String query = "SELECT COUNT(*) FROM ah_board_comment WHERE article_id = ?";
		return jdbcTemplate.query(query, new String[]{Integer.toString(article_id)},
				new RowMapper<Integer>() {
					@Override
					public Integer mapRow(ResultSet rs) throws SQLException {
						Integer result = new Integer(rs.getInt(1));
						return result;
					}
		}).get(0).intValue();
	}

	public List<BoardComment> getAllCommentList(int articleId) {
		String query = "SELECT comment_id, article_id, comment_writer, comment_memo, comment_regdate, comment_ip, comment_rereply, lvl "
				+ "FROM( "
				+ "SELECT tbl_comment.*, @LEVEL := @LEVEL + 1 as lvl "
				+ "FROM ah_board_comment AS tbl_comment, (SELECT @LEVEL := 0) AS tbl_lvl "
				+ "WHERE article_id = ? AND comment_rereply IS NULL "
				+ "UNION ALL "
				+ "SELECT *, ( "
				+ "SELECT lvl FROM( "
				+ "SELECT tbl_comment.*, @LEVEL02 := @LEVEL02 + 1.1 as lvl "
				+ "FROM ah_board_comment AS tbl_comment, (SELECT @LEVEL02 := 0) AS tbl_lvl "
				+ "WHERE article_id = ? AND comment_rereply IS NULL "
				+ ") a WHERE a.comment_id = tbl_comment_rereply.comment_rereply "
				+ ") AS lvl "
				+ "FROM ah_board_comment AS tbl_comment_rereply "
				+ "WHERE article_id = ? AND comment_rereply IS NOT NULL "
				+ ") result " + "ORDER BY lvl, comment_id";

		return jdbcTemplate.query(query, new String[] {Integer.toString(articleId), Integer.toString(articleId), Integer.toString(articleId)}, new RowMapperForComment());
	}

	public List<BoardComment> getCommentList(int articleId, int pageNum,
			int showRecordCnt) {
		String query = "SELECT * FROM( "
				+ "SELECT @ROWNUM := @ROWNUM + 1 AS rm, tbl_comment.* "
				+ "FROM "
				+ "(SELECT comment_id, article_id, comment_memo, comment_regdate FROM ah_board_comment WHERE article_id = ?) tbl_comment, "
				+ "(SELECT @ROWNUM :=0) R " + ") a "
				+ "WHERE a.rm BETWEEN ? AND ? " + "ORDER BY comment_id ASC ";

		String record_min = Integer.toString(1 + (pageNum - 1) * showRecordCnt);
		String record_max = Integer.toString(pageNum * showRecordCnt);

		return jdbcTemplate.query(query, new String[]{Integer.toString(articleId), record_min, record_max},
				new RowMapper<BoardComment>() {
					@Override
					public BoardComment mapRow(ResultSet rs)
							throws SQLException {
						BoardComment comment = new BoardComment();
						comment.setComment_id(rs.getInt("comment_id"));
						comment.setArticle_id(rs.getInt("article_id"));
						comment.setComment_writer(rs.getString("comment_writer"));
						comment.setComment_memo(rs.getString("comment_memo"));
						comment.setComment_regdate(rs.getDate("comment_regdate"));
						comment.setComment_ip(rs.getString("comment_ip"));
						comment.setComment_rereplay(rs.getInt("comment_rereply"));
						comment.setComment_level(rs.getInt("lvl"));

						return comment;
					}
				});
	}
}

class RowMapperForComment implements RowMapper<BoardComment> {
	@Override
	public BoardComment mapRow(ResultSet rs) throws SQLException {
		BoardComment comment = new BoardComment();
		comment.setComment_id(rs.getInt("comment_id"));
		comment.setArticle_id(rs.getInt("article_id"));
		comment.setComment_writer(rs.getString("comment_writer"));
		comment.setComment_memo(rs.getString("comment_memo"));
		comment.setComment_regdate(rs.getDate("comment_regdate"));
		comment.setComment_ip(rs.getString("comment_ip"));
		comment.setComment_rereplay(rs.getInt("comment_rereply"));
		comment.setComment_level(rs.getFloat("lvl"));

		return comment;
	}
}