package com.softlock.client;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.softlock.model.MemberDTO;
import com.softlock.model.MemberImpl;
import com.softlock.model.UserMailSendService;

@Controller
public class MemberController {
	
	@Autowired
	private SqlSession sqlSession;
	
	//이메일인증
	@Autowired
	private UserMailSendService mailsender;
	
	@RequestMapping("/member/home")
	public String memHome() {
		
		return "member/home";
	}
	
	@RequestMapping("/member/join")
	public String memJoin() {
		 
		return "member/mem_join";
	}
	
	@RequestMapping("/member/login")
	public String memLogin() {
		
		return "member/mem_login";
	}
	
	@RequestMapping("/member/loginAction")
	@ResponseBody
	public Map<String, Object> loginAction(HttpServletRequest req, HttpSession session) 
	{
		String id = req.getParameter("id");
		String pass = req.getParameter("pass");
		
		System.out.println(id);
		System.out.println(pass);
		
		// Mybatis 사용
		// 회원정보 저장
		ArrayList<MemberDTO> vo = sqlSession.getMapper(MemberImpl.class).login(id, pass);
		// 회원존재여부 판단
		int user = sqlSession.getMapper(MemberImpl.class).isUser(id, pass);
		
		Map<String, Object> map = new HashMap<String, Object>();
				
		//로그인 후 페이지 이동
		/* 나중에처리
		String backUrl = req.getParameter("backUrl");
		if(backUrl==null || backUrl.equals("")) {
			//돌아갈 url이 없다면 로그인 페이지로 다시 이동한다.
			mv.setViewName("member/mem_login");
		}
		else {
			mv.setViewName(backUrl);
		}*/
		
		if(user == 1) {
			map.put("success", 1);
			map.put("memberInfo", vo);
			session.setAttribute("memberInfo", vo);
			//System.out.println("session영역에 DTO저장됨:"+vo.getMem_idx()+vo.getMem_id()+vo.getMem_pw()+vo.getMem_name()+vo.getMem_regidate());
		}
		else {
			map.put("success", 0);
		}
		
		return map;
	}
	
	@RequestMapping("/member/find")
	public String memFind() {
		 
		return "member/mem_find";
	}
	
	//이메일인증 추가 
	@RequestMapping("/member/joinAction")
	public String memJoinAction(MemberDTO memJoinDTO, Model model, HttpServletRequest req, HttpSession session) {
		String mem_birth_year = req.getParameter("mem_birth_year"); 
		String mem_birth_month =  req.getParameter("mem_birth_month");
		String mem_birth_day = req.getParameter("mem_birth_day");
		String mem_birth = mem_birth_year+mem_birth_month+mem_birth_day;
		
		sqlSession.getMapper(MemberImpl.class).memjoinAction(
				req.getParameter("mem_id"), req.getParameter("mem_pw"), req.getParameter("mem_name"), mem_birth, 
				req.getParameter("mem_phone"), req.getParameter("mem_gender"), req.getParameter("mem_email"));
		
		mailsender.mailSendWithUserKey(memJoinDTO.getMem_email(), memJoinDTO.getMem_id(), req);

		return "member/mem_joinAction";  
	}
	 
	//이메일 인증 컨트롤러('y로바꿈')
	@RequestMapping(value = "/user/key_alter", method = RequestMethod.GET)
	public String key_alterConfirm(@RequestParam("mem_id") String user_id, @RequestParam("user_key") String key) {
	
		mailsender.alter_userKey_service(user_id, key); // mailsender의 경우 @Autowired
	
		return "member/mem_joinActionSuccess";
	}
	
	// 아이디중복확인
	@RequestMapping("/member/checkId")
	@ResponseBody
	public Map<String, Object> checkId(HttpServletRequest req, HttpSession session) 
	{
		String id = req.getParameter("mem_id");
		int userId = sqlSession.getMapper(MemberImpl.class).isUserId(id);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(userId == 1) {
			map.put("isUserId", 1);
		}
		else {
			map.put("isUserId", 0);
		}
		return map;
	}
}
