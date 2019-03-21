package com.softlock.client;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.softlock.model.InfoHpImpl;
import com.softlock.model.TreattimeDTO;

@Controller
public class ResvController {

	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/member/resv")
	public String memberResv(HttpServletRequest req, Model model) {
		
		//영업시간 가져오기
		//String hp_idx = req.getParameter("hp_idx");
		
		String[] treat_dy= {"월","화","수","목","금","토","일"};
		ArrayList<TreattimeDTO> tDTO = new ArrayList<TreattimeDTO>();
		for(int i = 0; i<treat_dy.length; i++) {
			tDTO.addAll(sqlSession.getMapper(InfoHpImpl.class).getHpTimeInfo("103", treat_dy[i]));//7개찍힘
			//tDTO = sqlSession.getMapper(InfoHpImpl.class).getHpTimeInfo(hp_idx, treat_dy[i]); 1개찍힘
		}
		model.addAttribute("tDTO", tDTO);
		
		return "member/resv_hp";
	}
	
}
