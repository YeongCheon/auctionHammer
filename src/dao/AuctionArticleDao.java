package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import bean.AuctionArticle;
import bean.Buy;
import bean.MyBidList;
import db.JdbcContext;
import db.RowMapper;

public class AuctionArticleDao {
	JdbcContext jdbcTemplate;

	public AuctionArticleDao(){
		jdbcTemplate = new JdbcContext();
	}

	public void deleteAll() {
		String query = "DELETE FROM ah_goods_article";
		jdbcTemplate.update(query);
	}

	public int insertArticle(AuctionArticle auctionArticle) {
		String query = "INSERT INTO ah_goods_article("
				+ "article_seller, article_startdate, article_enddate, "
				+ "article_marketprice, article_startprice, "
				+ "article_title, article_content, article_type, article_description) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";
		return jdbcTemplate.update(query, auctionArticle.getArticle_seller(),
				auctionArticle.getArticle_startdate().toString(),
				auctionArticle.getArticle_enddate().toString(),
				Integer.toString(auctionArticle.getArticle_marketprice()),
				Integer.toString(auctionArticle.getArticle_startprice()),
				auctionArticle.getArticle_title(),
				auctionArticle.getArticle_content(),
				Integer.toString(auctionArticle.getArticle_type()),
				auctionArticle.getArticle_description());
	}

	public int updateArticle(AuctionArticle auctionArticle) {
		String query = "";

		return jdbcTemplate.update("");
	}

	public int deleteArticle(int article_id) {
		String query = "DELETE FROM ah_goods_article WHERE article_id = ?";
		return jdbcTemplate.update(query, Integer.toString(article_id));
	}

	public AuctionArticle getAuctionArticle(int article_id) {
		String query = "SELECT "
				+ "article_id, article_seller, article_startdate, "
				+ "article_enddate, article_marketprice, article_startprice, "
				+ "article_title, article_content, article_type, article_regdate, article_description "
				+ "FROM ah_goods_article WHERE article_id = ?";
		return jdbcTemplate.query(query, new String[] { Integer.toString(article_id) },
				new RowMapper<AuctionArticle>(){

					@Override
					public AuctionArticle mapRow(ResultSet rs)
							throws SQLException {
						// TODO Auto-generated method stub
						AuctionArticle article = new AuctionArticle();
						article.setArticle_id(rs.getInt("article_id"));
						article.setArticle_seller(rs.getString("article_seller"));
						article.setArticle_startdate(rs.getTimestamp("article_startdate"));
						article.setArticle_enddate(rs.getTimestamp("article_enddate"));
						article.setArticle_marketprice(rs.getInt("article_marketprice"));
						article.setArticle_startprice(rs.getInt("article_startprice"));
						article.setArticle_title(rs.getString("article_title"));
						article.setArticle_content(rs.getString("article_content"));
						article.setArticle_type(rs.getInt("article_type"));
						article.setArticle_regdate(rs.getTimestamp("article_regdate"));
						article.setArticle_description(rs.getString("article_description"));
						
						return article;
					}
			
		}).get(0);

	}
	
	public static final int ARTICLE_TYPE_UP = 1;
	public static final int ARTICLE_TYPE_DOWN = 2;
	public static final int ARTICLE_TYPE_PRIVATE = 3;
	public List<AuctionArticle> getAuctionArticleList(int article_type) {
		String query = "SELECT "
				+ "article_id, article_seller, article_startdate, "
				+ "article_enddate, article_marketprice, article_startprice, "
				+ "article_title, article_content, article_type, article_regdate, article_description "
				+ "FROM ah_goods_article WHERE NOW() BETWEEN article_startdate AND article_enddate AND "
				+ "article_type = ? "
				+ "ORDER BY article_regdate DESC ";

		return jdbcTemplate.query(query, new String[]{Integer.toString(article_type)}, new RowMapperForGetList());
	}
	
	public List<AuctionArticle> getAuctionArticleListToKeyword(String keyword) {
		String query = "SELECT "
				+ "article_id, article_seller, article_startdate, "
				+ "article_enddate, article_marketprice, article_startprice, "
				+ "article_title, article_content, article_type, article_regdate, article_description "
				+ "FROM ah_goods_article WHERE NOW() BETWEEN article_startdate AND article_enddate AND "
				+ "article_title LIKE CONCAT('%',?,'%') "
				+ "ORDER BY article_regdate DESC ";

		return jdbcTemplate.query(query, new String[]{keyword}, new RowMapperForGetList());
	}
	
	public List<AuctionArticle> getAuctionArticleListToCategory(int category) {
		String query = "SELECT "
				+ "article_id, article_seller, article_startdate, "
				+ "article_enddate, article_marketprice, article_startprice, "
				+ "article_title, article_content, article_type, article_regdate, article_description "
				+ "FROM ah_goods_article WHERE NOW() BETWEEN article_startdate AND article_enddate AND "
				+ "article_id IN(SELECT a.article_id FROM ah_goods_category a WHERE standard_category_id = ?) "
				+ "ORDER BY article_regdate DESC ";

		return jdbcTemplate.query(query, new String[]{Integer.toString(category)}, new RowMapperForGetList());
	}	

	public List<AuctionArticle> getAuctionArticleListToUp() {
		String query = "SELECT "
				+ "article_id, article_seller, article_startdate, "
				+ "article_enddate, article_marketprice, article_startprice, "
				+ "article_title, article_content, article_type, article_regdate, article_description "
				+ "FROM ah_goods_article WHERE NOW() BETWEEN article_startdate AND article_enddate AND "
				+ "article_type = 1 "
				+ "ORDER BY article_regdate DESC ";

		return jdbcTemplate.query(query,new RowMapperForGetList());
	}
	
	public List<AuctionArticle> getAuctionArticleListToDown() {
		String query = "SELECT "
				+ "article_id, article_seller, article_startdate, "
				+ "article_enddate, article_marketprice, article_startprice, "
				+ "article_title, article_content, article_type, article_regdate, article_description "
				+ "FROM ah_goods_article WHERE NOW() BETWEEN article_startdate AND article_enddate AND "
				+ "article_type=2 "
				+ "ORDER BY article_regdate DESC ";

		return jdbcTemplate.query(query, new RowMapperForGetList());
	}
	
	public List<AuctionArticle> getAuctionArticleListToPrivate() {
		String query = "SELECT "
				+ "article_id, article_seller, article_startdate, "
				+ "article_enddate, article_marketprice, article_startprice, "
				+ "article_title, article_content, article_type, article_regdate, article_description "
				+ "FROM ah_goods_article WHERE NOW() BETWEEN article_startdate AND article_enddate AND "
				+ "article_type=3 "
				+ "ORDER BY article_regdate DESC ";

		return jdbcTemplate.query(query,new RowMapperForGetList());
	}	
	
	public int getRecentAuctionArticleId(String user_id){
		String query = "SELECT MAX(article_id) FROM ah_goods_article WHERE article_seller = ?";
		return jdbcTemplate.query(query, new String[]{user_id}, new RowMapper<Integer>() {

			@Override
			public Integer mapRow(ResultSet rs) throws SQLException { 
				return rs.getInt(1);
			}
		}).get(0);
	}

	public int getAuctionArticleTotalCount() {
		String query = "SELECT COUNT(*) FROM ah_goods_article";
		return jdbcTemplate.query(query, new RowMapper<Integer>() {

			@Override
			public Integer mapRow(ResultSet rs) throws SQLException { 
				return rs.getInt(1);
			}
		}).get(0);
	}
	
	public void insertAuctionCategory(int article_id, String[] categorys){
		String query = "INSERT INTO ah_goods_category(article_id, standard_category_id) VALUES(?, ?)";
		for(String category : categorys){
			jdbcTemplate.update(query, Integer.toString(article_id), category);
		}
	}
	
	public List<MyBidList> getMyBidList(String user_id){
		String query = "SELECT " + 
				"bid.bid_id, " +
				"article.article_id, " +
				"attach.attachfile_src, " +
				"article.article_title, " +
				"article.article_description, " +
				"bid.bid_price, " +
				"article.article_startprice, " +
				"article.article_marketprice, " +
				"article.article_regdate, " +
				"article.article_enddate, " +
				"article.article_seller, "
				+ "if(NOW() > article.article_enddate AND "
				+ "bid.bid_price >= (SELECT MAX(maxbid.bid_price) FROM ah_goods_bid AS maxbid WHERE maxbid.bid_article_id = bid.bid_article_id), "
				+ "true, false) isbid " +
				"FROM " +
				"ah_goods_bid AS bid INNER JOIN ah_goods_article AS article ON bid.bid_article_id = article.article_id " +
				"INNER JOIN ah_goods_attachfile AS attach ON attach.article_id = article.article_id " +
				"WHERE bid.bid_user = ? AND article.article_id NOT IN (SELECT buy_article_id FROM ah_goods_buy c) ORDER BY isbid DESC, article.article_id DESC, bid.bid_id DESC ";
		return jdbcTemplate.query(query, new String[]{user_id}, new RowMapper<MyBidList>(){
			@Override
			public MyBidList mapRow(ResultSet rs)
					throws SQLException {
				// TODO Auto-generated method stub
				MyBidList bid = new MyBidList();
				bid.setBid_id(rs.getInt("bid_id"));
				bid.setArticle_id(rs.getInt("article_id"));
				bid.setAttachfile_src(rs.getString("attachfile_src"));
				bid.setArticle_title(rs.getString("article_title"));
				bid.setArticle_description(rs.getString("article_description"));
				bid.setBid_price(rs.getInt("bid_price"));
				bid.setArticle_startprice(rs.getInt("article_startprice"));
				bid.setArticle_marketprice(rs.getInt("article_marketprice"));
				bid.setArticle_regdate(rs.getTimestamp("article_regdate"));
				bid.setArticle_enddate(rs.getTimestamp("article_enddate"));
				bid.setArticle_seller(rs.getString("article_seller"));
				bid.setBoolean_isBid(rs.getBoolean("isbid"));
				
				return bid;
			}
		});
	}
	
	public List<MyBidList> getMyBuyList(String user_id){
		String query = "SELECT " + 
//				"bid.bid_id, " +
				"article.article_id, " +
				"attach.attachfile_src, " +
				"article.article_title, " +
				"article.article_description, " +
				"bid.bid_price, " +
				"article.article_startprice, " +
				"article.article_marketprice, " +
				"article.article_regdate, " +
				"article.article_enddate, " +
				"article.article_seller " +
				"FROM "+ 
				"ah_goods_buy AS buy INNER JOIN ah_goods_article AS article ON buy.buy_article_id = article.article_id INNER JOIN ah_goods_attachfile AS attach ON attach.article_id = article.article_id "+ 
				"INNER JOIN (SELECT bid_article_id, MAX(bid_price) AS bid_price FROM ah_goods_bid GROUP BY bid_article_id) AS bid ON article.article_id = bid.bid_article_id "+
				"WHERE buy.user_id = ?";
		return jdbcTemplate.query(query, new String[]{user_id}, new RowMapper<MyBidList>(){
			@Override
			public MyBidList mapRow(ResultSet rs)
					throws SQLException {
				// TODO Auto-generated method stub
				MyBidList bid = new MyBidList();
//				bid.setBid_id(rs.getInt("bid_id"));
				bid.setArticle_id(rs.getInt("article_id"));
				bid.setAttachfile_src(rs.getString("attachfile_src"));
				bid.setArticle_title(rs.getString("article_title"));
				bid.setArticle_description(rs.getString("article_description"));
				bid.setBid_price(rs.getInt("bid_price"));
				bid.setArticle_startprice(rs.getInt("article_startprice"));
				bid.setArticle_marketprice(rs.getInt("article_marketprice"));
				bid.setArticle_regdate(rs.getTimestamp("article_regdate"));
				bid.setArticle_enddate(rs.getTimestamp("article_enddate"));
				bid.setArticle_seller(rs.getString("article_seller"));
				
				return bid;
			}
		});
	}
	
	public int insertBuy(Buy buy){
		String query = "INSERT INTO ah_goods_buy(buy_article_id, user_id, buy_zipcode, buy_addr1, buy_addr2) VALUES(?, ?, ?, ?, ?)";
		return jdbcTemplate.update(query, Integer.toString(buy.getBuy_article_id()), buy.getUser_id(), buy.getBuy_zipcode(), buy.getAddr1(), buy.getAddr2());
	}
}

class RowMapperForGetList implements RowMapper<AuctionArticle>{
	@Override
	public AuctionArticle mapRow(ResultSet rs)
			throws SQLException {
		// TODO Auto-generated method stub
		AuctionArticle article = new AuctionArticle();
		article.setArticle_id(rs.getInt("article_id"));
		article.setArticle_seller(rs.getString("article_seller"));
		article.setArticle_startdate(rs
				.getTimestamp("article_startdate"));
		article.setArticle_enddate(rs.getTimestamp("article_enddate"));
		article.setArticle_marketprice(rs.getInt("article_marketprice"));
		article.setArticle_startprice(rs.getInt("article_startprice"));
		article.setArticle_title(rs.getString("article_title"));
		article.setArticle_content(rs.getString("article_content"));
		article.setArticle_type(rs.getInt("article_type"));
		article.setArticle_regdate(rs.getTimestamp("article_regdate"));
		article.setArticle_description(rs.getString("article_description"));

		return article;
	}
}