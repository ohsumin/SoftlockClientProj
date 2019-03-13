package com.softlock.model;

import java.util.Random;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class UserSearchService {
	@Autowired
	private JavaMailSender mailsender;
	@Autowired
	private SqlSessionTemplate sqlSession;
	private MemberImpl userDao;

	// 아이디 찾기
	public String get_searchId(String mem_name, String mem_phone) {

		userDao = sqlSession.getMapper(MemberImpl.class);
		
		String result = "";

		try {
			result = userDao.searchId(mem_name, mem_phone);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("mem_name="+mem_name);
		System.out.println("mem_phone="+mem_phone);
		System.out.println("result="+result);
		return result;
	}
	// 이메일 난수 만드는 메서드
		private String init() {
			Random ran = new Random();
			StringBuffer sb = new StringBuffer();
			int num = 0;

			do {
				num = ran.nextInt(75) + 48;
				if ((num >= 48 && num <= 57) || (num >= 65 && num <= 90) || (num >= 97 && num <= 122)) {
					sb.append((char) num);
				} else {
					continue;
				}

			} while (sb.length() < size);
			if (lowerCheck) {
				return sb.toString().toLowerCase();
			}
			return sb.toString();
		}

		// 난수를 이용한 키 생성
		private boolean lowerCheck;
		private int size;
	public String getKey(boolean lowerCheck, int size) {
		this.lowerCheck = lowerCheck;
		this.size = size;
		return init();
	}
	
}
