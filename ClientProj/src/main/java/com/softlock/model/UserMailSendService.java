package com.softlock.model;

import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class UserMailSendService {

	@Autowired
	private JavaMailSender mailsender;
	@Autowired
	private SqlSessionTemplate sqlSession;
	private MemberImpl userDao;
	
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

	// 회원가입 발송 이메일(인증키 발송)
	public void mailSendWithUserKey(String e_mail, String mem_id, HttpServletRequest request) {
		
		String key = getKey(false, 20);
		userDao = sqlSession.getMapper(MemberImpl.class);
		userDao.GetKey(mem_id, key); 
		MimeMessage mail = mailsender.createMimeMessage();
		String htmlStr=""
	            +"<div style='background-color: #F1F3F5; width: 600px; height: 400px; padding-top: 60px; padding-left: 70px;'>"
	            +"<div style='width: 500px; height: 300px; background-color: white; '>"
	               +"<hr style='border: solid 3px #12264F; align-content: center;'>"
	               +"<div><span style='margin-left: 10px; font-size: 1.5em;'><Strong>똑닥똑닥</Strong></span>"
	               +"</div>"
	                  +"<hr style='width: 460px;'/>"
	                  +"<span style='color: #12264F; font-size: 1.6em; margin-left: 150px;'><Strong>비밀번호찾기</Strong></span>"
	                     +"<div style='margin-left: 20px;'>"
	                        +"<strong>"+mem_id +"</strong>님 안녕하세요. <br />"
	                        +"똑닥똑닥에 가입해주셔서 감사합니다.<br />"
	                        +"서비스 이용을 위해 고객님의 이메일을 인증해주시기 바랍니다.<br />"
	                        +"이메일 인증이 완료되면 정상적으로 사이트 이용이 가능합니다.<br />"
	                        +"<a href='http://localhost:8080" + request.getContextPath() + "/user/key_alter?mem_id="+ mem_id +"&user_key="+key+"'>인증하기</a><br />"
	                        +"<small>(혹시 잘못 전달된 메일이라면 이 이메일을 무시하셔도 됩니다)</small><fbr />"
	                        +"</div>"
	                        +"<div>"
	                        +"<hr  style='width: 460px;'/>"
	                        +"<div style='text-align: right; margin-right: 10px;'> 고객님의 건강보조! 똑닥똑닥드림 </div>"
	                        +"</div>"
	               +"<hr style='border: solid 3px #12264F; align-content: center;'>   "         
	            +"</div>"
	            +"</div>";

		try {
			mail.setSubject("[본인인증] 똑닥똑닥 본인인증 메일입니다.", "utf-8");
			mail.setText(htmlStr, "utf-8", "html");
			mail.addRecipient(RecipientType.TO, new InternetAddress(e_mail));
			
			mailsender.send(mail);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
	}
	
	//예약완료시 이메일 보냄
	public void mailSendWithUserKeyForReserv(String e_mail, String mem_id, HttpServletRequest request) {
		
		String key = getKey(false, 20);
		userDao = sqlSession.getMapper(MemberImpl.class);
		userDao.GetKey(mem_id, key); 
		MimeMessage mail = mailsender.createMimeMessage();
	      String htmlStr=""
	            +"<div style='background-color: #F1F3F5; width: 600px; height: 400px; padding-top: 60px; padding-left: 70px;'>"
	            +"<div style='width: 500px; height: 300px; background-color: white; '>"
	               +"<hr style='border: solid 3px #12264F; align-content: center;'>"
	               +"<div><span style='margin-left: 10px; font-size: 1.5em;'><Strong>똑닥똑닥</Strong></span>"
	               +"</div>"
	                  +"<hr style='width: 460px;'/>"
	                  +"<span style='color: #12264F; font-size: 1.6em; margin-left: 150px;'><Strong>예약완료메일</Strong></span>"
	                     +"<div style='margin-left: 20px;'>"
	                        +"<strong>"+mem_id +"</strong>님 예약완료메일입니다<br />"
	                        +"고객님께서 예약하신 병원의 예약이<br />"
	                        +"정상적으로 완료되었습니다!<br />"
	                        +"<small>(혹시 잘못 전달된 메일이라면 이 이메일을 무시하셔도 됩니다)</small><fbr />"
	                        +"</div>"
	                        +"<div>"
	                        +"<hr  style='width: 460px;'/>"
	                        +"<div style='text-align: right; margin-right: 10px;'> 고객님의 건강보조! 똑닥똑닥드림 </div>"
	                        +"</div>"
	               +"<hr style='border: solid 3px #12264F; align-content: center;'>   "         
	            +"</div>"
	            +"</div>";

		try {
			mail.setSubject("[본인인증] 똑닥똑닥 예약완료 메일입니다.", "utf-8");
			mail.setText(htmlStr, "utf-8", "html");
			mail.addRecipient(RecipientType.TO, new InternetAddress(e_mail));
			
			mailsender.send(mail);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
	}
	// 인증 확인 메서드 (Y 값으로 바꿔주는 메서드)
	public int alter_userKey_service(String user_id, String key) {
		
		int resultCnt = 0;
		
		userDao = sqlSession.getMapper(MemberImpl.class);
		resultCnt = userDao.alter_userKey(user_id, key);
		
		return resultCnt;
	}
		
	// 패스워드 찾기 이메일 발송
	public void mailSendWithPassword(String mem_id, String mem_email, HttpServletRequest request) {
		// 비밀번호는 6자리로 보내고 데이터베이스 비밀번호를 바꿔준다
		String key = getKey(false, 6);
		userDao = sqlSession.getMapper(MemberImpl.class);
		
		// 회원 이름 꺼내는 코드
		MemberDTO vo = userDao.userInfo(mem_id);
		String name = vo.getMem_name();
		
		MimeMessage mail = mailsender.createMimeMessage();

		String htmlStr=""
	            +"<div style='background-color: #F1F3F5; width: 600px; height: 400px; padding-top: 60px; padding-left: 70px;'>"
	            +"<div style='width: 500px; height: 300px; background-color: white; '>"
	               +"<hr style='border: solid 3px #12264F; align-content: center;'>"
	               +"<div><span style='margin-left: 10px; font-size: 1.5em;'><Strong>똑닥똑닥</Strong></span>"
	               +"</div>"
	                  +"<hr style='width: 460px;'/>"
	                  +"<span style='color: #12264F; font-size: 1.6em; margin-left: 150px;'><Strong>임시비밀번호 발송</Strong></span>"
	                     +"<div style='margin-left: 20px;'>"
	                        +"<strong>"+mem_id +"</strong>님 안녕하세요. <br />"
	                        +"비밀번호 찾기를 신청해주셔서 임시 비밀번호를 발급해드렸습니다<br />"
	                        +"임시로 발급 드린 비밀번호는 <h2>'" + key +"'</h2>이며 임시비밀번호로 로그인 후 회원정보수정에서 비밀번호를 변경해주시면 됩니다.<br />"
	                        +"<h3><a href='http://localhost:8080/client/member/home'>똑닥똑닥홈페이지바로가기</a></h3><br />"
	                        +"<small>(혹시 잘못 전달된 메일이라면 이 이메일을 무시하셔도 됩니다)</small><fbr />"
	                        +"</div>"
	                        +"<div>"
	                        +"<hr  style='width: 460px;'/>"
	                        +"<div style='text-align: right; margin-right: 10px;'> 고객님의 건강보조! 똑닥똑닥드림 </div>"
	                        +"</div>"
	               +"<hr style='border: solid 3px #12264F; align-content: center;'>   "         
	            +"</div>"
	            +"</div>";
	      
		try {
			mail.setSubject("[비밀번호찾기]임시 비밀번호가 발급되었습니다", "utf-8");
			mail.setText(htmlStr, "utf-8", "html");
			mail.addRecipient(RecipientType.TO, new InternetAddress(mem_email));
			mailsender.send(mail);
		} catch (MessagingException e) { 
			e.printStackTrace();
		}
		
		// 비밀번호 암호화해주는 메서드
		//key = UserSha256.encrypt(key);
		// 데이터 베이스 값은 암호한 값으로 저장시킨다.
		userDao.searchPassword(mem_id, mem_email, key);
		
	}
}