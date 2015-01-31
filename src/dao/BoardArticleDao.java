package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.owasp.esapi.ESAPI;

import bean.BoardArticle;
import db.JdbcContext;
import db.RowMapper;

public class BoardArticleDao {
	JdbcContext jdbcTemplate;

	public BoardArticleDao(){
		jdbcTemplate = new JdbcContext();
	}



	public int insertArticle(BoardArticle boardArticle) {
		int result = 0;

		String isNotice = null;

		if (boardArticle.getIsNotice() && boardArticle.getIsNotice()) {
			isNotice = "1";
		} else {
			isNotice = "0";
		}

		result = jdbcTemplate
				.update(
						"INSERT INTO ah_board_article(list_id, article_writer, article_title, article_content, article_isNotice) VALUES(?, ?, ?, ?, ?)",
						Integer.toString(boardArticle.getListId()),
						boardArticle.getWriter(), boardArticle.getTitle(),
						boardArticle.getContent(), isNotice);

		return result;
	}

	public int updateArticleHit(int article_id) {
		String query = "UPDATE ah_board_article SET article_hit = article_hit + 1 WHERE article_id = ?";
		return jdbcTemplate.update(query, Integer.toString(article_id));
	}

	public int updateArticle(BoardArticle boardArticle) {

		String isNotice = null;
		if (boardArticle.getIsNotice()) {
			isNotice = "1";
		} else {
			isNotice = "0";
		}

		String query = "UPDATE ah_board_article SET list_id = ?, article_title = ?, article_content = ? WHERE article_id = ?";

		return jdbcTemplate.update(query,
				Integer.toString(boardArticle.getListId()),
				boardArticle.getTitle(), boardArticle.getContent(),
				Integer.toString(boardArticle.getId()));
	}

	public int deleteArticle(int id) {
		String query = "DELETE FROM ah_board_article WHERE article_id = ?";
		return jdbcTemplate.update(query, Integer.toString(id));
	}

	public static final int SEARCH_TYPE_DEFAULT = 1;
	public static final int SEARCH_TYPE_TITLE = 2;
	public static final int SEARCH_TYPE_CONTENT = 3;
	public static final int SEARCH_TYPE_WRITER = 4;
	public static final int SEARCH_TYPE_TITLE_AND_CONTENT = 5;

	public List<BoardArticle> getArticleList(int listId, int search_type,
			String keyword, int pageNum, int showRecordCnt) {
		final String QUERY_DEFAULT = "SELECT -1 AS rm, article_id AS article_id, list_id AS list_id, article_writer AS article_writer, article_title AS article_title, article_content AS article_content, article_hit AS article_hit, article_isNotice AS article_isNotice, article_regdate AS article_regdate FROM ah_board_article WHERE article_isNotice = 1 "
				+ " union ALL " 
				+ "SELECT * FROM( "
				+ "SELECT @ROWNUM := @ROWNUM + 1 AS rm, article.* "
				+ "FROM "
				+ "(SELECT article_id, list_id, article_writer, article_title, article_content, article_hit, article_isNotice, article_regdate "
				+ "FROM ah_board_article WHERE list_id = ? AND article_content LIKE '%%' ORDER BY article_regdate DESC) article "
				+ ", (SELECT @ROWNUM := 0) R ORDER BY article_id DESC) a "
				+ "WHERE " + "rm >= ? AND rm <= ? OR rm = -1 ORDER BY rm ASC ";

		final String QUERY_TITLE = "SELECT * FROM( "
				+ "SELECT @ROWNUM := @ROWNUM + 1 AS rm, article.* "
				+ "FROM "
				+ "(SELECT article_id, list_id, article_writer, article_title, article_content, article_hit, article_isNotice, article_regdate "
				+ "FROM ah_board_article WHERE list_id = ? AND article_content LIKE '%%' ORDER BY article_regdate DESC) article "
				+ ", (SELECT @ROWNUM := 0) R ORDER BY article_id DESC) a "
				+ "WHERE "
				+ "rm >= ? AND rm <= ? AND CONVERT(article_title USING utf8) LIKE CONCAT('%', ? ,'%') ORDER BY rm ASC ";

		final String QUERY_CONTENT = "SELECT * FROM( "
				+ "SELECT @ROWNUM := @ROWNUM + 1 AS rm, article.* "
				+ "FROM "
				+ "(SELECT article_id, list_id, article_writer, article_title, article_content, article_hit, article_isNotice, article_regdate "
				+ "FROM ah_board_article WHERE list_id = ? AND article_content LIKE '%%' ORDER BY article_regdate DESC) article "
				+ ", (SELECT @ROWNUM := 0) R ORDER BY article_id DESC) a "
				+ "WHERE "
				+ "rm >= ? AND rm <= ? AND article_content LIKE CONCAT('%', ? ,'%') ORDER BY rm ASC ";

		final String QUERY_WRITER = "SELECT * FROM( "
				+ "SELECT @ROWNUM := @ROWNUM + 1 AS rm, article.* "
				+ "FROM "
				+ "(SELECT article_id, list_id, article_writer, article_title, article_content, article_hit, article_isNotice, article_regdate "
				+ "FROM ah_board_article WHERE list_id = ? AND article_content LIKE '%%' ORDER BY article_regdate DESC) article "
				+ ", (SELECT @ROWNUM := 0) R ORDER BY article_id DESC) a "
				+ "WHERE "
				+ "rm >= ? AND rm <= ? AND article_writer LIKE CONCAT('%', ? ,'%') ORDER BY rm ASC ";

		final String QUERY_TITLE_AND_CONTENT = "SELECT * FROM( "
				+ "SELECT @ROWNUM := @ROWNUM + 1 AS rm, article.* "
				+ "FROM "
				+ "(SELECT article_id, list_id, article_writer, article_title, article_content, article_hit, article_isNotice, article_regdate "
				+ "FROM ah_board_article WHERE list_id = ? AND article_content LIKE '%%' ORDER BY article_regdate DESC) article "
				+ ", (SELECT @ROWNUM := 0) R ORDER BY article_id DESC) a "
				+ "WHERE "
				+ "rm >= ? AND rm <= ? AND article_title LIKE CONCAT('%', ? ,'%') OR article_content LIKE CONCAT('%', ? ,'%') ORDER BY rm ASC ";

		String query = null;
		String record_min = Integer.toString(1 + (pageNum - 1) * showRecordCnt);
		String record_max = Integer.toString(pageNum * showRecordCnt);
		List<BoardArticle> result = null;
		switch (search_type) {
		case SEARCH_TYPE_DEFAULT:
			query = QUERY_DEFAULT;
			result = jdbcTemplate.query(query,
					new String[]{Integer.toString(listId),	record_min, record_max}, new RowmapperForBoardArticle());
			break;
		case SEARCH_TYPE_CONTENT:
			query = QUERY_CONTENT;
			result = jdbcTemplate.query(query,
					new String[]{ Integer.toString(listId),
					record_min, record_max, keyword}, new RowmapperForBoardArticle());
			System.out.println("3");
			break;
		case SEARCH_TYPE_TITLE:
			query = QUERY_TITLE;
			result = jdbcTemplate.query(query,
					new String[]{Integer.toString(listId),
					record_min, record_max, ESAPI.encoder().encodeForHTML(keyword)},new RowmapperForBoardArticle() );
			System.out.println("2");
			break;
		case SEARCH_TYPE_WRITER:
			query = QUERY_WRITER;
			result = jdbcTemplate.query(query,
					new String[]{Integer.toString(listId),
					record_min, record_max, keyword},new RowmapperForBoardArticle());
			System.out.println("4");
			break;
		case SEARCH_TYPE_TITLE_AND_CONTENT:
			query = QUERY_TITLE_AND_CONTENT;
			result = jdbcTemplate.query(query,
					new String[]{Integer.toString(listId),
					record_min, record_max, ESAPI.encoder().encodeForHTML(keyword), keyword},new RowmapperForBoardArticle());
			System.out.println("5");
			break;
		}
		return result;
	}

	public int getArticleCount(int listId, int search_type, String keyword) {
		final String QUERY_DEFAULT = "SELECT COUNT(*) FROM ah_board_article WHERE list_id = ?";

		final String QUERY_TITLE = "SELECT COUNT(*) FROM ah_board_article WHERE list_id = ? AND article_title LIKE concat('%', ?, '%')";
		final String QUERY_CONTENT = "SELECT COUNT(*) FROM ah_board_article WHERE list_id = ? AND article_content LIKE concat('%', ?, '%')";
		final String QUERY_WRITER = "SELECT COUNT(*) FROM ah_board_article WHERE list_id = ? AND article_writer LIKE concat('%', ?, '%')";
		final String QUERY_TITLE_AND_CONTENT = "SELECT COUNT(*) FROM ah_board_article WHERE list_id = ? AND article_content LIKE concat('%', ?, '%') OR article_title LIKE concat('%', ?, '%')";
		String query = null;

		switch (search_type) {
		case SEARCH_TYPE_DEFAULT:
			query = QUERY_DEFAULT;
			return jdbcTemplate.query(query,new String[]{Integer.toString(listId)}, new RowMapper<Integer>() {

				@Override
				public Integer mapRow(ResultSet rs) throws SQLException {
					// TODO Auto-generated method stub
					return rs.getInt(1);
				}
			}).get(0);
		case SEARCH_TYPE_CONTENT:
			query = QUERY_CONTENT;
			return jdbcTemplate.query(query,new String[]{Integer.toString(listId), keyword}, new RowMapper<Integer>() {

				@Override
				public Integer mapRow(ResultSet rs) throws SQLException {
					// TODO Auto-generated method stub
					return rs.getInt(1);
				}
			}).get(0);
		case SEARCH_TYPE_TITLE:
			query = QUERY_TITLE;
			return jdbcTemplate.query(query,new String[]{Integer.toString(listId), keyword}, new RowMapper<Integer>() {

				@Override
				public Integer mapRow(ResultSet rs) throws SQLException {
					// TODO Auto-generated method stub
					return rs.getInt(1);
				}
			}).get(0);
		case SEARCH_TYPE_WRITER:
			query = QUERY_WRITER;
			return jdbcTemplate.query(query,new String[]{Integer.toString(listId), keyword}, new RowMapper<Integer>() {

				@Override
				public Integer mapRow(ResultSet rs) throws SQLException {
					// TODO Auto-generated method stub
					return rs.getInt(1);
				}
			}).get(0);
		case SEARCH_TYPE_TITLE_AND_CONTENT:
			query = QUERY_TITLE_AND_CONTENT;
			return jdbcTemplate.query(query,new String[]{Integer.toString(listId), keyword, keyword}, new RowMapper<Integer>() {

				@Override
				public Integer mapRow(ResultSet rs) throws SQLException {
					// TODO Auto-generated method stub
					return rs.getInt(1);
				}
			}).get(0);
		default:
			return 0;
		}
	}

	public BoardArticle getArticle(int id) {
		BoardArticle result = null;
		String query = "SELECT article_id, list_id, article_writer, article_title, article_content, article_hit, article_isNotice, article_regdate "
				+ "FROM ah_board_article WHERE article_id = ?";
		List<BoardArticle> temp = jdbcTemplate.query(query, new String[]{Integer.toString(id)}, new RowmapperForBoardArticle());
		if (temp.size() > 0) {
			result = temp.get(0);
		} else {
			result = null;
		}

		return result;
	}

	public void deleteAll() {
		String query = "DELETE FROM ah_board_article";

		jdbcTemplate.update(query);
	}

}

class RowmapperForBoardArticle implements RowMapper<BoardArticle> {
	@Override
	public BoardArticle mapRow(ResultSet rs) throws SQLException {
		BoardArticle record = new BoardArticle();
		record.setId(rs.getInt("article_id"));
		record.setListId(rs.getInt("list_id"));
		record.setWriter(rs.getString("article_writer"));
		record.setTitle(rs.getString("article_title"));
		record.setContent(rs.getString("article_content"));
		record.setHit(rs.getInt("article_hit"));
		record.setIsNotice(rs.getBoolean("article_isNotice"));
		record.setRegdate(rs.getTimestamp("article_regDate"));

		return record;
	}
}