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
import org.springframework.web.bind.annotation.ResponseBody;

import com.softlock.model.AndroidImpl;
import com.softlock.model.AppMemberImpl;
import com.softlock.model.HospitalDTO;
import com.softlock.model.MemberDTO;
import com.softlock.model.MemberImpl;
import com.softlock.model.ReservationDTO;

@Controller
public class AndroidController {
	
	@Autowired
	private SqlSession sqlSession;
	
	
	@RequestMapping("/Android/join")
	@ResponseBody
	public Map<String, Object> join(HttpServletRequest req, HttpSession session){
		
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
		String mem_auth = req.getParameter("mem_auth");
		
		System.out.println(mem_birth_year);
		System.out.println(mem_birth_month);
		System.out.println(mem_birth_day);
		System.out.println(mem_birth);
				
		Map<String, Object> map = new HashMap<String, Object>();

		// 회원가입여부 확인
		int isUser = sqlSession.getMapper(MemberImpl.class).isUserId(mem_id);
		// 만약 회원가입이 되어있지 않으면
		if(isUser != 1) {
			// 회원가입
			sqlSession.getMapper(AndroidImpl.class).memjoinAction(mem_id, mem_pw, mem_name, mem_birth, mem_phone, mem_gender, mem_email, mem_auth);
		} 	
		// 로그인
		MemberDTO vo = sqlSession.getMapper(MemberImpl.class).login(mem_id, mem_pw);
		session.setAttribute("memberInfo", vo);
		
		System.out.println(((MemberDTO)session.getAttribute("memberInfo")).getMem_name());
		
		map.put("isSuccess", "success");
		return map; 
	}
	
	@RequestMapping("/Android/searchHp")
	@ResponseBody
	public ArrayList<HospitalDTO> searchHp(HttpServletRequest req){
		
		String hp_type = req.getParameter("hp_type");
		String hp_night = req.getParameter("hp_night");
		String hp_weekend = req.getParameter("hp_weekend");
		String hp_name = req.getParameter("hp_name");
		
		if(hp_type.equals("전체과목"))
			hp_type = "";
		if(hp_night.equals(""))
			hp_night = "0";
		if(hp_weekend.equals(""))
			hp_weekend = "0";
		
		HospitalDTO hDTO = new HospitalDTO();
		hDTO.setHp_type(hp_type);
		hDTO.setHp_night(hp_night);
		hDTO.setHp_wkend(hp_weekend);
		hDTO.setHp_name(hp_name);
		
		System.out.println(hDTO.getHp_type());
		System.out.println(hDTO.getHp_night());
		System.out.println(hDTO.getHp_wkend());
		System.out.println(hDTO.getHp_name());
		
		System.out.println("searchHp호출");
		ArrayList<HospitalDTO> searchList = sqlSession.getMapper(AndroidImpl.class).searchHp(hDTO);
		for(int i=0; i<searchList.size(); i++) {
			System.out.println(searchList.get(i).getHp_idx()+"/"+searchList.get(i).getHp_name());
		}
		
		
		return searchList;
	}
	
	@RequestMapping("/Android/reservationlist")
	@ResponseBody
	public ArrayList<ReservationDTO> memberModify(Model model, HttpServletRequest req,
			HttpSession session) {
		int mem_idx = ((MemberDTO)session.getAttribute("memberInfo")).getMem_idx();
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		//회원정보 가져오기
		MemberDTO dto = sqlSession.getMapper(MemberImpl.class)
				.view(((MemberDTO)session.getAttribute("memberInfo")).getMem_id());
		model.addAttribute("dto", dto);
		
		
	
		ArrayList<ReservationDTO> reservationDTO = sqlSession.getMapper(AndroidImpl.class).reservationPage(mem_idx);
		
	    map.put("reservationDTO", reservationDTO);
		
	    return reservationDTO;
	}
	
	@RequestMapping("/Android/reservationlist2")
	@ResponseBody
	public ArrayList<ReservationDTO> memberModify2(Model model, HttpServletRequest req,
			HttpSession session) {
		int mem_idx = ((MemberDTO)session.getAttribute("memberInfo")).getMem_idx();
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		//회원정보 가져오기
		MemberDTO dto = sqlSession.getMapper(MemberImpl.class)
				.view(((MemberDTO)session.getAttribute("memberInfo")).getMem_id());
		model.addAttribute("dto", dto);
		
		
	
		ArrayList<ReservationDTO> reservationDTO = sqlSession.getMapper(AndroidImpl.class).reservationPage2(mem_idx);
		
	    map.put("reservationDTO", reservationDTO);
		
	    return reservationDTO;
	}
	
	@RequestMapping("/Android/memberClip")
	@ResponseBody
	public ArrayList<HospitalDTO> memberClip(Model model, HttpServletRequest req,
			HttpSession session) {
		
		int mem_idx = ((MemberDTO)session.getAttribute("memberInfo")).getMem_idx();
		
		Map<String, Object> map = new HashMap<String, Object>();
		//회원정보 가져오기
		MemberDTO dto = sqlSession.getMapper(MemberImpl.class)
				.view(((MemberDTO)session.getAttribute("memberInfo")).getMem_id());
		model.addAttribute("dto", dto);
				
		
		ArrayList<HospitalDTO> HospitalDTO = sqlSession.getMapper(AndroidImpl.class).clipRecordPage(mem_idx);
		
		map.put("HospitalDTO", HospitalDTO);
		
		return HospitalDTO;
	}
}
