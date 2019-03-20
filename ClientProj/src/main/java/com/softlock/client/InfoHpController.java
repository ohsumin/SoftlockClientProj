package com.softlock.client;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.softlock.model.HospitalDTO;
import com.softlock.model.InfoHpImpl;
import com.softlock.model.TreattimeDTO;

@Controller
public class InfoHpController {

	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/member/infoHp")
	public String infoHp(HttpServletRequest req, Model model) {
		
		String hp_idx = req.getParameter("hp_idx");
		
		HospitalDTO hDTO = sqlSession.getMapper(InfoHpImpl.class).getHpInfo(hp_idx);
		model.addAttribute("hDTO", hDTO);
		
		String[] treat_dy= {"월","화","수","목","금","토","일"};
		ArrayList<TreattimeDTO> tDTO = new ArrayList<TreattimeDTO>();
		for(int i = 0; i<treat_dy.length; i++) {
			tDTO.addAll(sqlSession.getMapper(InfoHpImpl.class).getHpTimeInfo(hp_idx, treat_dy[i]));//7개찍힘
			//tDTO = sqlSession.getMapper(InfoHpImpl.class).getHpTimeInfo(hp_idx, treat_dy[i]); 1개찍힘
		}
		model.addAttribute("tDTO", tDTO);
		
		return "member/info_hp";
	}
	
	/*@RequestMapping("/member/infoHpAction")
	public HospitalDTO infoHpAction(HttpServletRequest req, Model model) {
		
		
	}*/
}
