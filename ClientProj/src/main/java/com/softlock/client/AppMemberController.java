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

import com.softlock.model.AppMemberImpl;
import com.softlock.model.MemberDTO;
import com.softlock.model.MemberImpl;
import com.softlock.model.ReservationDTO;

@Controller
public class AppMemberController {

	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/member/reservationlist")
	@ResponseBody
	public ArrayList<ReservationDTO> memberModify(Model model, HttpServletRequest req,
			HttpSession session) {
		int mem_idx = ((MemberDTO)session.getAttribute("memberInfo")).getMem_idx();
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		//회원정보 가져오기
		MemberDTO dto = sqlSession.getMapper(MemberImpl.class)
				.view(((MemberDTO)session.getAttribute("memberInfo")).getMem_id());
		model.addAttribute("dto", dto);
		
		
	
		ArrayList<ReservationDTO> reservationDTO = sqlSession.getMapper(AppMemberImpl.class).reservationPage(mem_idx);
		
	    map.put("reservationDTO", reservationDTO);
		
	    return reservationDTO;
	}
	
	
}
