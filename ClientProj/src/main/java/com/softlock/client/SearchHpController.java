package com.softlock.client;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.softlock.model.HospitalDTO;
import com.softlock.model.SearchHpImpl;

@Controller
public class SearchHpController {
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/member/searchHp")
	public String searchHp() {
		
		return "member/search_hp";
	}
	
	@RequestMapping("/member/searchHpType")
	@ResponseBody
	public ArrayList<HospitalDTO> searchHpType(HttpServletRequest req, HttpSession session) {
		
		String hp_type = req.getParameter("hp_type");
		
		ArrayList<HospitalDTO> searchList = (ArrayList<HospitalDTO>) sqlSession.getMapper(SearchHpImpl.class).searchHpType(hp_type);
		
		return searchList;
	}
	
	@RequestMapping("/member/searchHpName")
	@ResponseBody
	public ArrayList<HospitalDTO> searchHpName(HttpServletRequest req, HttpSession session){
		
		String searchStr = req.getParameter("searchStr");
		
		ArrayList<HospitalDTO> searchList = (ArrayList<HospitalDTO>) sqlSession.getMapper(SearchHpImpl.class).searchHpName(searchStr);
		
		return searchList;
	}
	
	@RequestMapping("/member/searchHpNight")
	@ResponseBody
	public ArrayList<HospitalDTO> searchHpNight(HttpServletRequest req, HttpSession session){
		
		ArrayList<HospitalDTO> searchList = (ArrayList<HospitalDTO>) sqlSession.getMapper(SearchHpImpl.class).searchHpNight();
		
		return searchList;
	}
	
	@RequestMapping("/member/searchHpWeekend")
	@ResponseBody
	public ArrayList<HospitalDTO> searchHpWeekend(HttpServletRequest req, HttpSession session){
		
		
		ArrayList<HospitalDTO> searchList = (ArrayList<HospitalDTO>) sqlSession.getMapper(SearchHpImpl.class).searchHpWeekend();
		
		return searchList;
	}
}
