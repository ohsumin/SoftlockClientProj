package com.softlock.client;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.softlock.model.HospListDTO;
import com.softlock.model.HospitalDTO;
import com.softlock.model.HospitalImpl;
import com.softlock.model.MemberDTO;
import com.softlock.model.PagingUtil;
import com.softlock.model.ReservationDTO;
import com.softlock.model.TreattimeDTO;
import com.softlock.model.UserMailSendService;

@Controller
public class HospitalController {
	
	@Autowired
	private SqlSession sqlSession;
	
	//이메일인증
		@Autowired
		private UserMailSendService mailsender;
	
	@RequestMapping("/hospital/home")
	public String home() {
		
		return "/hospital/home";
	}
	
	@RequestMapping("/hospital/login")
	public String hpLogin() {
		
		return "/hospital/hp_login";
	}
	
	// 시큐리티 인증 실패시
	@RequestMapping("/hospital/accessDenied")
	public String accessDenied() {
		
		return "security/accessDenied";
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
		// 허가회원인지 판단
		String perm = sqlSession.getMapper(HospitalImpl.class).isPerm(id);
		
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
		
		// 만약 존재하는 회원이라면
		if(user == 1) {
			if(perm.equals("y")) {
				map.put("success", 1);
				map.put("hospitalInfo", vo);
				session.setAttribute("hospitalInfo", vo);
				//System.out.println("session영역에 DTO저장됨:"+vo.getMem_idx()+vo.getMem_id()+vo.getMem_pw()+vo.getMem_name()+vo.getMem_regidate());
			}
			// 허가가 안되어있으면
			else {
				map.put("success", -1);
			}
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
		//session.invalidate();
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
         HttpSession session, Authentication authentication) {
	   

	   if((HospitalDTO)session.getAttribute("hospitalInfo") == null) {
		   System.out.println("hpModify진입");
		   Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		   User user = (User)principal;
		   String username = user.getUsername();
		   
		   System.out.println(username);
			
		   HospitalDTO vo = sqlSession.getMapper(HospitalImpl.class).loginHpid(username);
		   session.setAttribute("hospitalInfo", vo);
	   }
	   
	   //병원회원상세보기 읽기 및 수정 동시에 진행함   
	   HospitalDTO hospitalInfo = (HospitalDTO)session.getAttribute("hospitalInfo");
	   System.out.println("세션확인" +  hospitalInfo.getHp_idx());
	   int hp_idx = hospitalInfo.getHp_idx();
	    
	   //병원상세정보 읽어오기 일반정보  
	   HospitalDTO dto = sqlSession.getMapper(HospitalImpl.class)
	         .viewModify(((HospitalDTO)session.getAttribute("hospitalInfo")).getHp_idx());
	  
	    //병원상세정보 읽어오기 진료시간
	   ArrayList<TreattimeDTO> treatDTOs = sqlSession.getMapper(HospitalImpl.class).viewModifytime(((HospitalDTO)session.getAttribute("hospitalInfo")).getHp_idx());
	   System.out.println("개수개수" + treatDTOs.size());
	   System.out.println(treatDTOs.get(0).getTreat_open());
	  
	   model.addAttribute("dto", dto);
	   model.addAttribute("treatDTOs",treatDTOs);
	   
	   String tab = req.getParameter("tab");
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
	      //reserDTO.setResv_time(reserDTO.getResv_time().split(" ")[1]);
	      
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
   
	
	
	/////병원정보수정액션
    @RequestMapping("/hospital/modifyAction")
    public String modifyAction(Model model, HttpServletRequest req, HttpSession session, HttpServletResponse response) throws IOException {
    	
    	
    	/*파일업로드*/
		//upload폴더의 물리적경로 얻어오기
		String path = req.getSession().getServletContext().getRealPath("/resources/upload");
		String originalName="";
		String saveFileName="";
	
		try
		{
			/*
			파일업로드를 위한 객체생성. 객체 생성과 동시에 파일업로드는
			완료되고 나머지 폼값은 Multipart객체가 통째로 받아서 
			처리한다. 
			 */
			MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest) req;
			
			//업로드폼의 file속성 필드의 이름을 모두 읽음			
			Iterator itr = mhsr.getFileNames();
			
			//파일처리를 위한 변수 생성
			MultipartFile mfile = null;			
			String fileName = "";		
				
			/*
			파일 하나의 정보를 저장하기 위한 List계열의 컬렉션을 
			생성한다. (원본파일명과 실제저장된파일명)
			 */
			List resultList = new ArrayList();
				
			String title = mhsr.getParameter("title");
				
			//업로드할 디렉토리가 없는지 확인후 디렉토리 생성
			File directory = new File(path);
			if(!directory.isDirectory()){		
				directory.mkdirs();
			}
		
						 
			
			//업로드폼의 file속성의 필드갯수만큼 반복함
			while(itr.hasNext())
			{		
				//input태그의 속성값을 읽어온다.(userfile1,2)
				fileName = (String)itr.next();
				
				//서버로 업로드된 임시파일명을 가져온다. 
				mfile = mhsr.getFile(fileName);
				System.out.println("mfile[임시파일명]="+ mfile);
				
				//한글깨짐방지처리후 업로드된 파일명을 가져온다.
				originalName = new String(mfile.getOriginalFilename()
					.getBytes(),"UTF-8");
				
				//만약 파일명이 공백이라면 while문의 처음으로 돌아간다.
				if("".equals(originalName)){
					continue;
				}
				
				/*
				파일명에서 확장자를 가져온다. 파일명에서 확장자는 마지막
				.(점) 이후에 있기때문에 lastIndexOf()를 사용한다. 				
				 */
				String ext = originalName.substring(
						originalName.lastIndexOf('.'));		
				
				//uuid로 생성한 문자열과 확장자를 합친다.
				saveFileName = getUuid() + ext;	
				
				//설정한 경로명 조립
				File serverFullName = new File(path + File.separator 
						+ saveFileName);
				
				//업로드한 파일을 지정경로에 저장한다. 
				mfile.transferTo(serverFullName);
				System.out.println("경로"+serverFullName);
			
			}
			
		}		 
		catch(IOException e){
			e.printStackTrace();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		int idx = ((HospitalDTO)session.getAttribute("hospitalInfo")).getHp_idx();
		System.out.println(idx);
		
		
		
	
		String hp_night = req.getParameter("hp_night");
		if(hp_night==null) {
			hp_night="n";
		}else {
			hp_night="y";	
		}

		//hospital 수정 영업시간제외 입력
		int sucOrFail = sqlSession.getMapper(HospitalImpl.class).modifyAction(idx, req.getParameter("hp_hpphone"), hp_night, req.getParameter("hp_detailInfo"),
    			req.getParameter("hp_etc"), originalName, saveFileName);
	
		

		
		//hospital 영업시간입력
		String[] treat_dy = {"월","화","수","목","금","토","일"};  
        String[] dyopen = {"mon_open", "tue_open", "wed_open", "thu_open", "fri_open", "sat_open", "sun_open"};
        String[] dyclose = {"mon_close", "tue_close", "wed_close", "thu_close", "fri_close", "sat_close", "sun_close"};
        
        for(int i = 0; i<dyopen.length; i++) {
        	System.out.println("dyopen"+req.getParameter(dyopen[i]));
        	System.out.println("dyclose"+req.getParameter(dyclose[i]));
        	if(req.getParameter(dyopen[i])!=null) {
        		sqlSession.getMapper(HospitalImpl.class).treatmodifyAction(idx,
    					treat_dy[i], req.getParameter(dyopen[i]), req.getParameter(dyclose[i]));
        	}
		}
       
        
       response.setContentType("text/html; charset=UTF-8");
       PrintWriter out = response.getWriter();
       out.println("<script>alert('병원정보수정이 완료되었습니다'); location.href='../hospital/home';</script>");
       out.flush();
        
        return "/hospital/hp_modify";
    }
    
	/*
	UUID를 이용한 랜덤한 문자열 생성
		: Universally unique identifier 즉 범용 고유 식별자라고 한다.
	 */
	public static String getUuid(){
		String uuid = UUID.randomUUID().toString();
		System.out.println("uuid1="+uuid);
		
		uuid = uuid.replaceAll("-", "");
		System.out.println("uuid2="+uuid);		
		
		return uuid;
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
       String hp_type = req.getParameter("hp_type");
       
       // 회원정보 저장
       sqlSession.getMapper(HospitalImpl.class).hpJoinAction(
    		   	hp_id, hp_pw, hp_name, hp_num, hp_username, hp_email, hp_phone, hp_address, hp_address2, hp_type);
       
       HospitalDTO vo = sqlSession.getMapper(HospitalImpl.class).loginHp(hp_id, hp_pw);
	   session.setAttribute("hospitalInfo", vo);
	   
	   
	   //회원가입시 treattime 테이블에 월~금 레코드 추가
	   String[] treat_dy = {"월","화","수","목","금","토","일"};  
	   String treat_open="오픈시간";
	   String treat_close="마감시간";
	   for(int i = 0; i<treat_dy.length;i++) {
		   sqlSession.getMapper(HospitalImpl.class).addTreatTime(((HospitalDTO)session.getAttribute("hospitalInfo")).getHp_idx(), treat_dy[i], treat_open, treat_close);	
	   }
	  
       return "hospital/hp_joinActionSuccess";  
    }
    
    //예약회원 상세보기
    @RequestMapping("/hospital/hp_reservView")
    public String reservView(Model model, HttpServletRequest req, HttpSession session) {
    	String resv_idx = req.getParameter("resv_idx");
       ReservationDTO dto = sqlSession.getMapper(HospitalImpl.class).reservView(resv_idx);
       //dto.setResv_time(dto.getResv_time().split(" ")[1]); 
       dto.setResv_date(dto.getResv_date().split(" ")[0]); 
       
       model.addAttribute("dto", dto);
       return "hospital/hp_reservListView";
    }
    
  //예약회원 예약확정(이메일 & SMS 보내기)
	@RequestMapping("/hospital/hp_resvConf")
	public String reservConf(HttpServletRequest req, MemberDTO memJoinDTO, HttpSession session, HttpServletResponse res) throws IOException {
		
		sqlSession.getMapper(HospitalImpl.class).reservConf(req.getParameter("resv_idx"));
		System.out.println("sdfdsf"+req.getParameter("resv_idx"));
		
		String mem_email = req.getParameter("mem_email");
		String mem_id = req.getParameter("id");
		   
		System.out.println("이메일" + mem_email + mem_id);
		//예약확정시 메일을 보냄
		mailsender.mailSendWithUserKeyForReserv(memJoinDTO.getMem_email(), memJoinDTO.getMem_id(), req); 
		//예약확정시 병원전화번호로 멤버에게 SMS 보내기
		String mem_name = (String)req.getParameter("mem_name");
		String mem_phone = (String)req.getParameter("mem_phone");
		String resv_time = (String)req.getParameter("resv_time");
		String resv_date = req.getParameter("resv_date");
		HospitalDTO hospitalInfo = (HospitalDTO) session.getAttribute("hospitalInfo");
		String hp_phone = hospitalInfo.getHp_phone();
		String hp_name = hospitalInfo.getHp_name();
		
		String api_key = "NCSTDOOHRGU6YMQP";
		String api_secret = "AAY9Y5KHW6Y3F2F4RJMFCS5DHBSBF5M8";
		//Coolsms coolsms = new Coolsms(api_key, api_secret);
		
		HashMap<String, String> set = new HashMap<String, String>();
		set.put("to", "01028700688"); // to
		
		set.put("from", "01028700688"); // from <= "01028700688" 회원번호 mem_phone 으로 수정하기 
		set.put("text", (String)(mem_name+"님 병원:"+hp_name+" 내원날짜:"+resv_date+" 예약확정. 전화걸기("+hp_phone+")")); // 문자내용
		/*                                                                                                         ........<=여기까지문자감..*/
		set.put("type", "sms"); // 문자 타입
		System.out.println(set);
		//coolsms.send(set); // 보내기(&전송결과받기)
		 return "redirect:hpModify?tab=1";
	}
    
    //예약회원 예약거절
    @RequestMapping("/hospital/hp_resvRej")
    public String reservRej(HttpServletRequest req, HttpServletResponse res) throws IOException {
    	
		sqlSession.getMapper(HospitalImpl.class).reservRej(req.getParameter("resv_idx"));
       return "redirect:hpModify?tab=1";
    }
    //예약확정된 회원중 예약확정이 y인 회원들은 진료완료 버튼이 나오게 한다. 그 버튼이 c로 바꿈
    @RequestMapping("hospital/hp_resvDone")
    public String hp_resvDone(HttpServletRequest req) {
    	System.out.println("hp_resvDone" + req.getParameter("resv_idx"));
    	sqlSession.getMapper(HospitalImpl.class).hp_resvDone(req.getParameter("resv_idx"));
    	return "redirect:hpModify?tab=1";
    }
    
    
}
