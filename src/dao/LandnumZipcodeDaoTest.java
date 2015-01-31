package dao;

import static org.junit.Assert.assertThat;
import static org.hamcrest.CoreMatchers.is;

import org.junit.Before;
import org.junit.Test;

/*
 * author : YeongCheon Kim
 * email : kyc1682@gmail.com
 * 
 * */
public class LandnumZipcodeDaoTest {
	LandnumZipcodeDao zipcodeDao;

	@Before
	public void setUp() {
		zipcodeDao = new LandnumZipcodeDao();
	}

	@Test
	public void getZipcodeListTest() {
		int getListCount = zipcodeDao.getZipcodeList("송파구").size();
		
		assertThat(getListCount, is(432));

	}
}
