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

import com.softlock.model.MemberImpl;
import com.softlock.model.ReviewDTO;
import com.softlock.model.ReviewImpl;

@Controller
public class ReviewController {
	
	@Autowired
	private SqlSession sqlSession;
	@RequestMapping("/member/review")
	public void reviewinsert(HttpServletRequest req) {
		Map<String, Object> map = new HashMap<String, Object>();
		String rvw_score = req.getParameter("rvw_score");
		String rvw_mem_idx = req.getParameter("rvw_mem_idx");
		String rvw_hp_idx = req.getParameter("rvw_hp_idx");
		String comment = req.getParameter("comment");
		sqlSession.getMapper(ReviewImpl.class).reviewinsert(rvw_mem_idx,rvw_hp_idx, rvw_score, comment);
		
	}
	
	@RequestMapping("/member/ReviewView")
	public String reviewView(HttpServletRequest req, Model model) {
		String rvw_hp_idx = req.getParameter("rvw_hp_idx");
		ArrayList<ReviewDTO> dto = sqlSession.getMapper(ReviewImpl.class).reviewView(rvw_hp_idx);
		model.addAttribute("dto", dto);
		return "member/reviewView";
	}
 
}
