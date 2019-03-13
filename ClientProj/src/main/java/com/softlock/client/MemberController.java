package com.softlock.client;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import com.softlock.model.UserSearchService;

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
	
	//로그아웃 
	@RequestMapping("/member/logout")
	public String memLogout(HttpSession session) {
		session.setAttribute("memberInfo", null);
		session.invalidate();
		return "member/home";
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
		MemberDTO vo = sqlSession.getMapper(MemberImpl.class).login(id, pass);
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
	public String memJoinAction(MemberDTO memJoinDTO, Model model, HttpServletRequest req, HttpServletResponse resp, HttpSession session) 
			throws IOException {
		String mem_id = req.getParameter("mem_id");
		String mem_pw = req.getParameter("mem_pw");
		String mem_name = req.getParameter("mem_name");
		String mem_phone = req.getParameter("mem_phone");
		String mem_gender = req.getParameter("mem_gender");
		String mem_email = req.getParameter("mem_email");
		String mem_birth_year = req.getParameter("mem_birth_year"); 
		String mem_birth_month =  req.getParameter("mem_birth_month");
		String mem_birth_day = req.getParameter("mem_birth_day");
		String mem_birth = mem_birth_year+mem_birth_month+mem_birth_day;
		
		String isNaver = req.getParameter("hiddenPw");
		
		if(isNaver.equals("NAVERLOGIN!")) {
			mem_id = req.getParameter("hiddenId");
			mem_pw = req.getParameter("hiddenPw");
			mem_gender = req.getParameter("hiddenGender");
			mem_birth_month = req.getParameter("hiddenMonth");
			mem_birth_day = req.getParameter("hiddenDay");
			mem_birth = mem_birth_year+mem_birth_month+mem_birth_day;
		}
		System.out.println("아이디:"+mem_id);
		System.out.println("비번:"+mem_pw);
		System.out.println("이름:"+mem_name);
		System.out.println("폰:"+mem_phone);
		System.out.println("성별:"+mem_gender);
		System.out.println("이메일:"+mem_email);
		System.out.println("생일:"+mem_birth);
			
		sqlSession.getMapper(MemberImpl.class).memjoinAction(mem_id, mem_pw, mem_name, mem_birth,mem_phone, mem_gender, mem_email);
		
		if(isNaver.equals("NAVERLOGIN!")) {
			// y로 바꿔주고, 세션추가후  홈으로 이동
			System.out.println("joinAction호출");
			MemberDTO vo = sqlSession.getMapper(MemberImpl.class).login(mem_id, mem_pw);
			session.setAttribute("memberInfo", vo);
			sqlSession.getMapper(MemberImpl.class).alter_naverKey(mem_id);
			PrintWriter out = resp.getWriter();
			out.println("<script>alert('회원가입이 완료되었습니다.');</script>");
			out.flush();
			return "member/home";
		}
		else
			// 일반회원일때는 메일보냄
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
		String mem_id = req.getParameter("mem_id");
		String mem_pw = req.getParameter("mem_pw");
		int userId = sqlSession.getMapper(MemberImpl.class).isUserId(mem_id);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(userId == 1) {
			// 로그인할때 네이버로그인이면 세션에 추가
			if(mem_pw.equals("NAVERLOGIN!")) {
				MemberDTO vo = sqlSession.getMapper(MemberImpl.class).login(mem_id, mem_pw);
				session.setAttribute("memberInfo", vo);
			}
			map.put("isUserId", 1);
		}
		else {
			map.put("isUserId", 0);
		}
		return map;
	}
	
	////회원정보수정폼진입
	@RequestMapping("/member/memberModify")
	public String memberModify(Model model, HttpServletRequest req,
			HttpSession session) {
	
		
	MemberDTO dto = sqlSession.getMapper(MemberImpl.class)
			.view(((MemberDTO)session.getAttribute("memberInfo")).getMem_id());
	model.addAttribute("dto", dto);
		return "member/mem_myPage";
	}
	
	
	/////회원정보수정액션
	@RequestMapping("/member/modifyAction")
	public void modifyAction(Model model, HttpServletRequest req, HttpSession session, HttpServletResponse response) throws IOException {
		System.out.println("아이디" +((MemberDTO)session.getAttribute("memberInfo")).getMem_id());
		sqlSession.getMapper(MemberImpl.class).modifyAction(
				req.getParameter("mem_pw"), req.getParameter("mem_name"), req.getParameter("mem_phone"), ((MemberDTO)session.getAttribute("memberInfo")).getMem_id());
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script>alert('정보수정이 완료되었습니다'); location.href='../member/home';</script>");
		out.flush();
	}
	
	//회원탈퇴처리 비밀번호확인폼 진입
	@RequestMapping("/member/memberDeleteCk")
	public String memDeleteck() {
		return "member/mem_pwCk";
	}
	
	//회원탈퇴처리
	@RequestMapping("/member/memDelteAction")
	@ResponseBody
	public Map<String, Object> memDelteAction(HttpServletRequest req, HttpSession session, HttpServletResponse response) throws IOException {
		Map<String, Object> map = new HashMap<String, Object>();
		
		String id = req.getParameter("id");
		String pass = req.getParameter("pass");
		
		int user = sqlSession.getMapper(MemberImpl.class).isUser(id, pass);
		
		String retrunLoc="";
	
		if(user==1) {
		
			sqlSession.getMapper(MemberImpl.class).delete(id);
			map.put("success", "1");
			session.invalidate();
			map.put("returnLoc", "../member/home");
		
		} else {
			map.put("success", "0");
			map.put("msg", "아이디 및 비밀번호를 확인해주세요");
			
		}
		return map;
		
	}
	
	
	@Autowired
	private UserSearchService searchService;
	
	// 아이디 찾기
	@RequestMapping(value = "/member/memSearch", method = RequestMethod.POST)
	@ResponseBody
	public String userIdSearch(@RequestParam("mem_name") String  mem_name, 
			@RequestParam("mem_phone") String mem_phone) {
		
		String result = searchService.get_searchId(mem_name, mem_phone);
		System.out.println("mem_name="+mem_name);
		System.out.println("mem_phone="+mem_phone);
		return result;
	}
	
	// 비밀번호 찾기
	@RequestMapping("/member/memSearchPassword")
	public String searchPassword(
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String mem_id = request.getParameter("mem_id");
		String mem_email = request.getParameter("mem_email");
		
		System.out.println("mem_id="+mem_id);
		System.out.println("mem_email="+mem_email);
		
		//유저 확인하기
		MemberDTO memberDTO = sqlSession.getMapper(MemberImpl.class).userInfo(mem_id);
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		if(memberDTO==null) {
			System.out.println("memberDTO="+memberDTO);
			out.println("<script>alert('해당 아이디가 없습니다.'); location.href='../member/find'; </script>");
			out.flush();
		}else {
			out.println("<script>alert('해당이메일로 임시 비밀번호가 발송되었습니다.'); </script>");
			out.flush();
			System.out.println("mem_id="+mem_id);
			System.out.println("mem_email="+mem_email);
			//메일 보내기
			mailsender.mailSendWithPassword(mem_id,mem_email, request);
		}
		
		return "member/mem_login";
		
	}
	
	
}
