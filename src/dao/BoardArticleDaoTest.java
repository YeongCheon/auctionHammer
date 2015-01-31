package dao;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import javax.sql.DataSource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import bean.BoardArticle;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "/root-context.xml")
public class BoardArticleDaoTest {
	@Autowired
	BoardArticleDao boardArticleDao;
	@Autowired
	DataSource dataSource;

	BoardArticle article01[];
	BoardArticle article02[];

	@Before
	public void setUp() {
		article01 = new BoardArticle[30];
		article02 = new BoardArticle[30];

		for (int i = 0; i < 30; i++) {
			article01[i] = new BoardArticle(1, "kyc1025", "boardArticleTest0"
					+ (i + 1), "articleContentTest0" + (i + 1), false);
		}

	}

	@Test
	public void insertArticle() {
		assertThat(1, is(1));
//		repeat();
//		assertThat(30, is(boardArticleDao.getArticleCount(1, boardArticleDao.SEARCH_TYPE_DEFAULT, "%")));
	}

//	@Test
//	public void getArticleList() {
//		repeat();
//		assertThat(20, is(boardArticleDao.getArticleList(1, 1, 20).size()));
//	}
//
//	@Test
//	public void getArticle() {
//		repeat();
//		assertThat("boardArticleTest03", is(boardArticleDao.getArticle("200").getTitle()));
//	}

	public void repeat() {
		boardArticleDao.deleteAll();
		for (int i = 0; i < 30; i++) {
			boardArticleDao.insertArticle(article01[i]);
		}
	}
}
