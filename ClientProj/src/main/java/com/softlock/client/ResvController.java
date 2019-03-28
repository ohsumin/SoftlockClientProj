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

import com.softlock.model.HospitalDTO;
import com.softlock.model.InfoHpImpl;
import com.softlock.model.MemberDTO;
import com.softlock.model.ReservationDTO;
import com.softlock.model.ResvImpl;
import com.softlock.model.TreattimeDTO;

@Controller
public class ResvController {

	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/member/resv")
	public String memberResv(HttpServletRequest req, Model model) {
		
		//영업시간 가져오기
		String[] treat_dy= {"월","화","수","목","금","토","일"};
		ArrayList<TreattimeDTO> tDTO = new ArrayList<TreattimeDTO>();
		for(int i = 0; i<treat_dy.length; i++) {
			tDTO.addAll(sqlSession.getMapper(InfoHpImpl.class).getHpTimeInfo("103", treat_dy[i]));//7개찍힘
			//tDTO = sqlSession.getMapper(InfoHpImpl.class).getHpTimeInfo(hp_idx, treat_dy[i]); 1개찍힘
		}
		model.addAttribute("tDTO", tDTO);
		
		String hp_idx = req.getParameter("hp_idx");
		
		HospitalDTO hDTO = sqlSession.getMapper(InfoHpImpl.class).getHpInfo(hp_idx);
		model.addAttribute("hDTO", hDTO);
		
		return "member/resv_hp";
	}
	
	@RequestMapping("/member/getTime")
	@ResponseBody
	public Map<String, Object> memberGetTime(HttpServletRequest req, Model model) {
		
		String dy = req.getParameter("dy");
		String hp_idx = req.getParameter("hp_idx");
		if(dy.equals("1")) dy="월";
		if(dy.equals("2")) dy="화";
		if(dy.equals("3")) dy="수";
		if(dy.equals("4")) dy="목";
		if(dy.equals("5")) dy="금";
		if(dy.equals("6")) dy="토";
		if(dy.equals("7")) dy="일";
		TreattimeDTO tDTO = sqlSession.getMapper(ResvImpl.class).getTime(hp_idx, dy);
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println(tDTO.getTreat_open());
		System.out.println(tDTO.getTreat_close());
		map.put("open", tDTO.getTreat_open());
		map.put("close", tDTO.getTreat_close());
		
		return map; 
	}
	
	@RequestMapping("/member/getResv")
	@ResponseBody
	public ArrayList<ReservationDTO> memberGetResv(HttpServletRequest req, Model model) {
	
		String hp_idx = req.getParameter("hp_idx");	
		String date = req.getParameter("date");
		ArrayList<ReservationDTO> resvList = sqlSession.getMapper(ResvImpl.class).getResv(hp_idx, date);
		for(int i=0; i<resvList.size(); i++) {
			resvList.get(i).getResv_time();
		}
		
		return resvList;
	}
	
	@RequestMapping("/member/resvAction")
	public String resvAction(HttpServletRequest req, Model model, HttpSession session) {
		
		String hp_idx = req.getParameter("hp_idx");
		int mem_idx = ((MemberDTO)session.getAttribute("memberInfo")).getMem_idx();
		String resv_symp = req.getParameter("resv_symp");
		String resv_req = req.getParameter("resv_req");
		String resv_date = req.getParameter("date-input");
		String resv_time = req.getParameter("time");
		System.out.println(hp_idx);
		System.out.println(mem_idx);
		System.out.println(resv_symp);
		System.out.println(resv_req);
		System.out.println(resv_date);
		System.out.println(resv_time);
		
		
		sqlSession.getMapper(ResvImpl.class).resvInsert(hp_idx, mem_idx, resv_symp, resv_req, resv_date, resv_time);
		
		
		
		return "member/resv_success";
	}
}
