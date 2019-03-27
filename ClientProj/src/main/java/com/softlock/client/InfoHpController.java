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
import com.softlock.model.MemberDTO;
import com.softlock.model.ReviewDTO;
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
		
		//후기리스트 가져오기
		ArrayList<ReviewDTO> rDTO = sqlSession.getMapper(InfoHpImpl.class).getHpReview(hp_idx);
		//날짜만 가져오기
		for(ReviewDTO rDTODate : rDTO) {
			rDTODate.setRvw_regidate(rDTODate.getRvw_regidate().split(" ")[0]);
		}
		
		
		model.addAttribute("rDTO", rDTO);
		
		//후기전체 개수 가져오기
		String rvwCount = sqlSession.getMapper(InfoHpImpl.class).getRvwCount(hp_idx);
		model.addAttribute("rvwCount", rvwCount);
		
		//후기 평균점수가져오기
		String rvwAvg = sqlSession.getMapper(InfoHpImpl.class).getRvwAvg(hp_idx);
		model.addAttribute("rvwAvg", rvwAvg);
		
		
		//병원 상세정보페이지의 통계에 쓰일 함수
		String wCount = sqlSession.getMapper(InfoHpImpl.class).getWNum(hp_idx);
		String mCount = sqlSession.getMapper(InfoHpImpl.class).getMNum(hp_idx);
		model.addAttribute("wCount",wCount);
		model.addAttribute("mCount",mCount);
		System.out.println("mCount="+mCount);
		
		
		ArrayList<MemberDTO> mDTO = new ArrayList<MemberDTO>();
		mDTO = sqlSession.getMapper(InfoHpImpl.class).getCountAge(hp_idx);
		System.out.println(mDTO.size());
		//for(int i=0; i<mDTO.size(); i++) {
		String mem1 = mDTO.get(0).getMem_birth();
		String mem2 = mDTO.get(1).getMem_birth();
		String mem3 = mDTO.get(2).getMem_birth();
		String mem4 = mDTO.get(3).getMem_birth();
		String mem5 = mDTO.get(4).getMem_birth();
		model.addAttribute("mem1", mem1);
		model.addAttribute("mem2", mem2);
		model.addAttribute("mem3", mem3);
		model.addAttribute("mem4", mem4);
		model.addAttribute("mem5", mem5);
		//}
		model.addAttribute("mDTO", mDTO);
		
		
		return "member/info_hp";
	}
	
	/*@RequestMapping("/member/infoHpReview")
	public String infoHpReview(HttpServletRequest req, Model model) {
		String hp_idx = req.getParameter("hp_idx");
		
		
		return "member/info_hp";
		
	}*/
	
	
}
