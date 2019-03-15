package com.softlock.client;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.softlock.model.HospListDTO;
import com.softlock.model.HospitalDTO;
import com.softlock.model.HospitalImpl;

@Controller
public class HospitalController {
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/hospital/home")
	public String home() {
		
		return "/hospital/home";
	}
	
	@RequestMapping("/hospital/login")
	public String hpLogin() {
		
		return "/hospital/hp_login";
	}
	
	@RequestMapping("/hospital/loginAction")
	@ResponseBody
	public Map<String, Object> loginAction(HttpServletRequest req, HttpSession session) 
	{
		String id = req.getParameter("id");
		String pass = req.getParameter("pass");
		
		System.out.println(id);
		System.out.println(pass);
		
		// Mybatis 사용
		// 회원정보 저장
		HospitalDTO vo = sqlSession.getMapper(HospitalImpl.class).login(id, pass);
		// 회원존재여부 판단
		int user = sqlSession.getMapper(HospitalImpl.class).isUser(id, pass);
		
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
			map.put("hpInfo", vo);
			session.setAttribute("hpInfo", vo);
			//System.out.println("session영역에 DTO저장됨:"+vo.getMem_idx()+vo.getMem_id()+vo.getMem_pw()+vo.getMem_name()+vo.getMem_regidate());
		}
		else {
			map.put("success", 0);
		}
		
		return map;
	}
	
	//로그아웃 
	@RequestMapping("/hospital/logout")
	public String hpLogout(HttpSession session) {
		session.setAttribute("hpInfo", null);
		session.invalidate();
		return "hospital/home";
	}

	//회원탈퇴처리 비밀번호확인폼 진입
	@RequestMapping("/hospital/hospitalDeleteCk")
	public String hpDeleteck() {
		return "hospital/hp_pwCk";
	}
	
	//회원탈퇴처리
	@RequestMapping("/hospital/hpDelteAction")
	@ResponseBody
	public Map<String, Object> hpDelteAction(HttpServletRequest req, HttpSession session, HttpServletResponse response) throws IOException {
		Map<String, Object> map = new HashMap<String, Object>();
		
		String id = req.getParameter("id");
		String pass = req.getParameter("pass");
		
		int user = sqlSession.getMapper(HospitalImpl.class).isUser(id, pass);
		
		String retrunLoc="";
	
		if(user==1) {
		
			sqlSession.getMapper(HospitalImpl.class).delete(id);
			map.put("success", "1");
			session.invalidate();
			map.put("returnLoc", "../hospital/home");
		
		} else {
			map.put("success", "0");
			map.put("msg", "아이디 및 비밀번호를 확인해주세요");
			
		}
		return map;
		
	}
		
    //회원정보수정폼진입
	@RequestMapping("/hospital/hpModify")
	public String hpModify(Model model, HttpServletRequest req,
			HttpSession session) {
	
		
	HospitalDTO dto = sqlSession.getMapper(HospitalImpl.class)
			.view(((HospitalDTO)session.getAttribute("hpInfo")).getHp_id());
	model.addAttribute("dto", dto);
		return "hospital/hp_myPage";
	}
	
	
	 /////회원정보수정액션
    @RequestMapping("/hospital/modifyAction")
    public void modifyAction(Model model, HttpServletRequest req, HttpSession session, HttpServletResponse response) throws IOException {
       String dym = req.getParameter("dym");
       
       System.out.println("아이디" +((HospitalDTO)session.getAttribute("hpInfo")).getHp_id());
       sqlSession.getMapper(HospitalImpl.class).modifyAction(
             req.getParameter("hp_hpphone"), req.getParameter("hp_night"), req.getParameter("hp_wkend"), req.getParameter("hp_intro"),
             req.getParameter("hp_notice"), req.getParameter("hp_image"), ((HospitalDTO)session.getAttribute("hpInfo")).getHp_id());
        
       sqlSession.getMapper(HospitalImpl.class).tmodifyAction(
             req.getParameter("monOpt"), req.getParameter("monClt"), ((HospitalDTO)session.getAttribute("hpInfo")).getHp_idx(), dym );
       
       response.setContentType("text/html; charset=UTF-8");
       PrintWriter out = response.getWriter();
       out.println("<script>alert('정보수정이 완료되었습니다'); location.href='../hospital/home';</script>");
       out.flush();
    }

    @RequestMapping("/hospList/RealtimeSearch")
    @ResponseBody
    public ArrayList<HospListDTO> searchName(HttpServletRequest req){
    	String searchStr = req.getParameter("searchStr");
    	System.out.println(searchStr);
    	
    	HospListDTO hDto = new HospListDTO();
    	hDto.setHosplist_name(searchStr);
    	
    	ArrayList<HospListDTO> searchList = (ArrayList<HospListDTO>) sqlSession.getMapper(HospitalImpl.class).searchHp(hDto);
        return searchList;
    }
    
    // 회원가입
    @RequestMapping("/hospital/join")
    public String hpJoin() {
    	
    	return "/hospital/hp_join";
    }
    
    /*@RequestMapping("/hospital/joinAction")
    @ResponseBody
    public String hpjoinAction(HttpServletRequest req, HttpSession session) {
        
       String hp_id = req.getParameter("hp_id");
       String hp_pw = req.getParameter("hp_pw");
       String hp_name = req.getParameter("hp_name");
       String hp_num = req.getParameter("hp_num");
       String hp_username = req.getParameter("hp_username");
       String hp_email = req.getParameter("hp_email");
       String hp_phone = req.getParameter("hp_phone");
       String hp_address = req.getParameter("hp_address");
       
       // Mybatis 사용
       // 회원정보 저장
       ArrayList<HospitalDTO> vo = sqlSession.getMapper(HospitalImpl.class).hpjoinAction(hp_id, hp_pw, hp_name, hp_num, hp_username, hp_email, 
             hp_phone, hp_address);
       
       return "hospital/hp_joinAction";
    }*/
}
