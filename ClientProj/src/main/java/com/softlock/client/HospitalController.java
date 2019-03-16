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
import com.softlock.model.PagingUtil;
import com.softlock.model.ReservationDTO;

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
	
	// 아이디중복확인
	@RequestMapping("/hospital/checkId")
	@ResponseBody
	public Map<String, Object> checkId(HttpServletRequest req, HttpSession session) 
	{
		String hp_id = req.getParameter("hp_id");
		String hp_pw = req.getParameter("hp_pw");
		int userId = sqlSession.getMapper(HospitalImpl.class).isUserId(hp_id);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(userId == 1) {
			
			map.put("isUserId", 1);
		}
		else {
			map.put("isUserId", 0);
		}
		return map;
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
		HospitalDTO vo = sqlSession.getMapper(HospitalImpl.class).loginHp(id, pass);
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
			map.put("hospitalInfo", vo);
			session.setAttribute("hospitalInfo", vo);
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
		session.setAttribute("hospitalInfo", null);
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
		
    //마이페이지 진입
   @RequestMapping("/hospital/hpModify")
   public String hpModify(Model model, HttpServletRequest req,
         HttpSession session) {
   
   HospitalDTO hospitalInfo = (HospitalDTO)session.getAttribute("hospitalInfo");
   int hp_idx = hospitalInfo.getHp_idx();
   
   String tab = req.getParameter("tab");
    System.out.println("tab="+tab);
      
   HospitalDTO dto = sqlSession.getMapper(HospitalImpl.class)
         .view(((HospitalDTO)session.getAttribute("hospitalInfo")).getHp_id());
   model.addAttribute("dto", dto);

   
   //회원리스트보기
   int totalRecordCount = sqlSession
         .getMapper(HospitalImpl.class)
         .getTotalCount(dto.getHp_idx());
   ReservationDTO reservationDTO = new ReservationDTO();
   String addQueryString = "";
   
   //페이지 처리를 위한 설정값
   int pageSize = 4;
   int blockPage = 4;
   
   //전체페이지수계산하기
   int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);

   //시작 및 끝 rownum 구하기
   int nowPage = req.getParameter("nowPage")==null ? 1 :
      Integer.parseInt(req.getParameter("nowPage"));
   int start = (nowPage-1) * pageSize + 1;
   int end = nowPage * pageSize;
   System.out.println("나우페이지="+nowPage);//읽음
   ArrayList<ReservationDTO> lists = sqlSession
         .getMapper(HospitalImpl.class).listPage(start, end, hp_idx);

   int virtualNum = 0;
   int countNum = 0;
    for(ReservationDTO reserDTO : lists) {
      reserDTO.setResv_date(reserDTO.getResv_date().split(" ")[0]); 
      reserDTO.setResv_time(reserDTO.getResv_time().split(" ")[1]);
      
      //가상번호
       virtualNum = totalRecordCount - (((nowPage-1)*pageSize) + countNum++);
       reserDTO.setVirtualNum(virtualNum);
      }
   


   //페이지 처리를 위한 처리부분
   String pagingImg = PagingUtil.pagingImg(totalRecordCount,
         pageSize, blockPage, nowPage,
         req.getContextPath()+"/hospital/hpModify?"+addQueryString,tab);

   model.addAttribute("totalRecordCount", totalRecordCount);
   model.addAttribute("pagingImg", pagingImg);
   model.addAttribute("tab", tab);
   model.addAttribute("lists", lists);
   model.addAttribute("nowPage", nowPage);
   
   System.out.println("nowPge");
   System.out.println("병원인덱스" + dto.getHp_idx());
   System.out.println("총게시물수222=" + totalRecordCount);
   return "hospital/hp_myPage";
   }
   
	
	
	/////회원정보수정액션
    @RequestMapping("/hospital/modifyAction")
    public void modifyAction(Model model, HttpServletRequest req, HttpSession session, HttpServletResponse response) throws IOException {
       String dym = req.getParameter("dym");
       
       System.out.println("아이디" +((HospitalDTO)session.getAttribute("hospitalInfo")).getHp_id());
       sqlSession.getMapper(HospitalImpl.class).modifyAction(
             req.getParameter("hp_hpphone"), req.getParameter("hp_night"), req.getParameter("hp_wkend"), req.getParameter("hp_intro"),
             req.getParameter("hp_notice"), req.getParameter("hp_image"), ((HospitalDTO)session.getAttribute("hospitalInfo")).getHp_id());
        
       sqlSession.getMapper(HospitalImpl.class).tmodifyAction(
             req.getParameter("monOpt"), req.getParameter("monClt"), ((HospitalDTO)session.getAttribute("hospitalInfo")).getHp_idx(), dym );
       
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
    
    @RequestMapping("/hospital/joinAction")
    public String hpjoinAction(HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws IOException {
        
       String hp_id = req.getParameter("hp_id");
       String hp_pw = req.getParameter("hp_pw");
       String hp_name = req.getParameter("hp_name");
       String hp_num = req.getParameter("hp_num");
       String hp_username = req.getParameter("hp_username");
       String hp_email = req.getParameter("hp_email");
       String hp_phone = req.getParameter("hp_phone");
       String hp_address = req.getParameter("hp_address");
       String hp_address2 = req.getParameter("hp_address2");
       
       System.out.println(hp_id);
       System.out.println(hp_pw);
       System.out.println(hp_name);
       System.out.println(hp_num);
       System.out.println(hp_username);
       System.out.println(hp_email);
       System.out.println(hp_phone);
       System.out.println(hp_address);
       System.out.println(hp_address2);
       
       // Mybatis 사용
       // 회원정보 저장
       sqlSession.getMapper(HospitalImpl.class).hpJoinAction(
    		   	hp_id, hp_pw, hp_name, hp_num, hp_username, hp_email, hp_phone, hp_address, hp_address2);
       
       HospitalDTO vo = sqlSession.getMapper(HospitalImpl.class).loginHp(hp_id, hp_pw);
	   session.setAttribute("hospitalInfo", vo);
	
       return "hospital/hp_joinActionSuccess";
    }
    
    //예약회원 상세보기
    @RequestMapping("/hospital/hp_reservView")
    public String reservView(Model model, HttpServletRequest req, HttpSession session) {
    	String resv_idx = req.getParameter("resv_idx");
       ReservationDTO dto = sqlSession.getMapper(HospitalImpl.class).reservView(resv_idx);
       dto.setResv_time(dto.getResv_time().split(" ")[1]); 
       dto.setResv_date(dto.getResv_date().split(" ")[0]); 
       
       model.addAttribute("dto", dto);
       return "hospital/hp_reservListView";
    }
    
    //예약회원 예약확정
    @RequestMapping("/hospital/hp_resvConf")
    public String reservConf(HttpServletRequest req) {
       sqlSession.getMapper(HospitalImpl.class).reservConf(req.getParameter("resv_idx"));
       System.out.println("sdfdsf"+req.getParameter("resv_idx"));
       return "리턴페이지";
    }
    //예약회원 예약거절
    @RequestMapping("/hospital/hp_resvRej")
    public String reservRej(HttpServletRequest req) {
       sqlSession.getMapper(HospitalImpl.class).reservRej(req.getParameter("resv_idx"));
       return "리턴페이지";
    }
    
    
}
