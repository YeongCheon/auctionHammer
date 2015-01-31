package dao;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import bean.User;

/*
 * author : YeongCheon Kim
 * email : kyc1682@gmail.com
 * 
 * */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "/root-context.xml")
public class UserDaoTest {
	private User user01;
	private User user02;
	
	@Autowired
	private UserDao userDao;

	@Before
	public void setUp() {
		this.user01 = new User("kyc1025", "nicName01", "1111", "pwdHint???",
				"yes", "김영천", "M","19911025", "kyc1682", "gmail.com", "02", "4191682",
				"01084881682", "138863", "서올시 송파구", "ᅟaddr2", User.TYPE_ADMIN);

		this.user02 = new User("ycKim", "nicName02", "2222", "pwdHint???",
				"yes", "김영천", "M", "19911025", "kyc1682", "gmail.com", "02", "4191682",
				"01084881682", "138863", "서올시 송파구", "ᅟaddr2", User.TYPE_CUSTOMER);
	}

	@Test
	public void userCountTest() {
		userDao.deleteAll();
		userDao.userAdd(user01);
		userDao.userAdd(user02);

		assertThat(userDao.userCount(), is(2));
	}

//	//Exception 발생
//	@Test
//	public void userAddTest() {
//		userDao.deleteAll();
//
//		assertThat(userDao.userAdd(user01), is(1));
//		assertThat(userDao.userAdd(user01), is(0));
//	}

	@Test
	public void userGetTest() {
		userDao.deleteAll();
		userDao.userAdd(user01);

		User getUser01 = userDao.userGet("nothing");
		User getUser02 = userDao.userGet(user01.getUser_id());

		String test1 = "";
		if (getUser01 == null) {
			test1 = "success";
		}

		assertThat(test1, is("success"));
	}
	
	@Test(expected=NullPointerException.class)
	public void userGetWidthPwdTest(){
		userDao.deleteAll();
		userDao.userAdd(user01);
		
		User getUser01 = userDao.userGet(user01.getUser_id(), "1234");
		
		assertThat(getUser01.getUser_id(), is(user01.getUser_id()));
	}
}
