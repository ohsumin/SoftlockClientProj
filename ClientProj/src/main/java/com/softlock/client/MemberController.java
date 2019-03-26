package com.softlock.client;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.softlock.model.GlobalDicDTO;
import com.softlock.model.HospitalDTO;
import com.softlock.model.InfoHpImpl;
import com.softlock.model.MemberDTO;
import com.softlock.model.MemberImpl;
import com.softlock.model.ReservationDTO;
import com.softlock.model.UserMailSendService;
import com.softlock.model.UserSearchService;

@Controller
public class MemberController {
	
	@Autowired
	private SqlSession sqlSession;
	
	//이메일인증
	@Autowired
	private UserMailSendService mailsender;
	
	@RequestMapping("/member/home")
	public String memHome(Model model) {
		/*
		String NumHospital = sqlSession.getMapper(InfoHpImpl.class).getNumHospital();
		System.out.println("NumHospital"+NumHospital);

		String NumReserv = sqlSession.getMapper(InfoHpImpl.class).getNumReserv();
		System.out.println("NumReserv"+NumReserv);
		
		model.addAttribute("NumHospital",NumHospital);
		model.addAttribute("NumReserv",NumReserv);*/
		
		return "member/home";
	}
	@RequestMapping("/member/Captcha")
	public String Captcha(Model model, HttpSession session, HttpServletRequest req, HttpServletResponse resp) {
		String clientId = "2WQHXW_ouJyzabqjO8zn";
	      String clientSecret = "Nlwn_kYZq9";
	      try {
	          String code = "0"; // 키 발급 받을 때는 0으로 설정
	          String apiURL = "https://openapi.naver.com/v1/captcha/nkey?code=" + code;
	          URL url = new URL(apiURL);
	          HttpURLConnection con = (HttpURLConnection)url.openConnection();
	          con.setRequestMethod("GET");
	          con.setRequestProperty("X-Naver-Client-Id", clientId);
	          con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
	          int responseCode = con.getResponseCode();
	          BufferedReader br;
	          if(responseCode==200) { 
	              br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	          } else {  
	              br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	          }
	          String inputLine;
	          StringBuffer response = new StringBuffer();
	          while ((inputLine = br.readLine()) != null) {
	              response.append(inputLine);
	          }
	          br.close();
	          System.out.println(response.toString());
	          resp.setContentType("text/html;charset=UTF-8");
	          
				
				//서블릿에서 세션객체를 얻어온다.
				session = req.getSession();
				
				session.setAttribute("key", response.toString());
	          
	      } catch (Exception e) {
	          System.out.println(e);
	      }
		return "member/captcha/captcha";
	}
	
	
	@RequestMapping("/member/CaptchaRes")
	public String result(Model model, HttpSession session, HttpServletRequest req, HttpServletResponse resp) {
		String clientId = "2WQHXW_ouJyzabqjO8zn";
        String clientSecret = "Nlwn_kYZq9";
        session = req.getSession();
        StringBuffer response = new StringBuffer();
        String apiResult = null;
        try {
            String code = "1"; 
            String key = session.getAttribute("vkey").toString(); 
            String value = req.getParameter("inputText"); 
            String apiURL = "https://openapi.naver.com/v1/captcha/nkey?code=" + code +"&key="+ key + "&value="+ value;

            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("X-Naver-Client-Id", clientId);
            con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
            int responseCode = con.getResponseCode();
            BufferedReader br;
            if(responseCode==200) { 
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;
            //response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();
            System.out.println(response.toString());
        } catch (Exception e) {
            System.out.println(e);
        }
        
        apiResult = response.toString();
        System.out.println(apiResult);
        
		JSONParser parser = new JSONParser();
		Object obj = null;
		try {
			obj = parser.parse(apiResult);
		} catch (ParseException e) {
			
			e.printStackTrace();
		}
		JSONObject jsonobj = (JSONObject) obj;

		Boolean result = (Boolean) jsonobj.get("result");
        if(result == true) {
        	//한글처리
			resp.setContentType("text/html;charset=UTF-8");
			
			return "member/mem_join";
        }else {
        	//한글처리
			resp.setContentType("text/html;charset=UTF-8");
			//서블릿에서 out객체를 얻어온다.
			return "member/captcha/false";
        }		
		
	}
/*	@RequestMapping("/member/join")
	public String memJoin() {
		 
		return "member/mem_join";
	}*/
	
	@RequestMapping("/member/login")
	public String memLogin(HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws IOException {
		Map<String, Object> map = new HashMap<String, Object>();
		//key초기화
		String key = "";
		
		//존재하지 않는 회원이거나 아이디or비밀번호 틀렸을때 캡차
		String clientId = "2WQHXW_ouJyzabqjO8zn";
		String clientSecret = "Nlwn_kYZq9";
		
		try {
			String code = "0"; // 키 발급 받을 때는 0으로 설정
			String apiURL = "https://openapi.naver.com/v1/captcha/nkey?code=" + code;
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			
				con.setRequestMethod("GET");
				con.setRequestProperty("X-Naver-Client-Id", clientId);
				con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
				
			int responseCode = con.getResponseCode();
			
			BufferedReader br;
			
			if(responseCode==200) { 
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else {
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer response = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				response.append(inputLine);
			}
			br.close();
			System.out.println(response.toString());
			resp.setContentType("text/html;charset=UTF-8");
				
			session = req.getSession();
			session.setAttribute("key", response.toString());
			key = response.toString();
			map.put("key", response.toString());
			System.out.println(map.get("key"));
			System.out.println(map);
			System.out.println(session.getAttribute("key"));
		} catch (Exception e) {
		System.out.println(e);
		}
		
		return "member/mem_login";
	}
	
	//로그아웃 
	@RequestMapping("/member/logout")
	public String memLogout(HttpSession session) {
		session.setAttribute("memberInfo", null);
		//session.invalidate();
		return "member/home";
	}
	
	@RequestMapping("/member/loginAction")          
	@ResponseBody
	public Map<String, Object> loginAction(HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws IOException
	{                       
		int checkFlag = 2;
		String id = req.getParameter("id");
		String pass = req.getParameter("pass");
		System.out.println("inputText="+req.getParameter("inputText"));
		if(req.getParameter("inputText")!=null&&!req.getParameter("inputText").equals("")) {
			String clientId = "2WQHXW_ouJyzabqjO8zn";
	        String clientSecret = "Nlwn_kYZq9";
	        session = req.getSession();
	        StringBuffer response = new StringBuffer();
	        String apiResult = null;
	        try {
	            String code = "1"; 
	            String key = session.getAttribute("vkey").toString(); 
	            String value = req.getParameter("inputText"); 
	            String apiURL = "https://openapi.naver.com/v1/captcha/nkey?code=" + code +"&key="+ key + "&value="+ value;
	
	            URL url = new URL(apiURL);
	            HttpURLConnection con = (HttpURLConnection)url.openConnection();
	            con.setRequestMethod("GET");
	            con.setRequestProperty("X-Naver-Client-Id", clientId);
	            con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
	            int responseCode = con.getResponseCode();
	            BufferedReader br;
	            if(responseCode==200) { 
	                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	            } else {  
	                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	            }
	            String inputLine;
	            //response = new StringBuffer();
	            while ((inputLine = br.readLine()) != null) {
	                response.append(inputLine);
	            }
	            br.close();
	            System.out.println(response.toString());
	        } catch (Exception e) {
	            System.out.println(e);
	        }
	        
	        apiResult = response.toString();
	        System.out.println(apiResult);
	        
			JSONParser parser = new JSONParser();
			Object obj = null;
			try {
				obj = parser.parse(apiResult);
			} catch (ParseException e) {
				
				e.printStackTrace();
			}
			JSONObject jsonobj = (JSONObject) obj;
	
			Boolean result = (Boolean) jsonobj.get("result");
			
	        if(result == true) {
	        	//한글처리
				resp.setContentType("text/html;charset=UTF-8");
				checkFlag = 1;
				
				/*return "member/mem_join";*/
	        }else {
	        	//한글처리
				resp.setContentType("text/html;charset=UTF-8");
				checkFlag = 0;
				//서블릿에서 out객체를 얻어온다.   
				/*return "member/captcha/false";*/
	        }
	        
		}
		
		
		System.out.println(id);
		System.out.println(pass);
		
		// Mybatis 사용
		// 회원정보 저장
		MemberDTO vo = sqlSession.getMapper(MemberImpl.class).login(id, pass);
		// 회원존재여부 판단
		int user = sqlSession.getMapper(MemberImpl.class).isUser(id, pass);
		// 회원이메일인증 여부 판단
		String auth = sqlSession.getMapper(MemberImpl.class).isAuth(id);
		
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
			
			if(auth.equals("y")&&checkFlag==2) {
				map.put("success", 1);
				map.put("memberInfo", vo);
				map.put("checkFlag", 2);
				session.setAttribute("memberInfo", vo);
				//System.out.println("session영역에 DTO저장됨:"+vo.getMem_idx()+vo.getMem_id()+vo.getMem_pw()+vo.getMem_name()+vo.getMem_regidate());     
			}
			else if(auth.equals("y")&&checkFlag==1){
				map.put("success", 1);
				map.put("checkFlag", 1);
				map.put("memberInfo", vo);
				session.setAttribute("memberInfo", vo);
			}
			else if(auth.equals("n") && checkFlag == 1){
				map.put("checkFlag", 1);
				map.put("success", -1);
			}
			else if(auth.equals("n") && checkFlag == 0){
				map.put("checkFlag", 0);
				map.put("success", -1);
			}
		}
		else {
			if(checkFlag == 2) {
				map.put("checkFlag", 2);
				map.put("success", 0);
			}else if(checkFlag == 1) {
				map.put("checkFlag", 1);
				map.put("success", 0);
			}
			else if(checkFlag == 0) {
				map.put("checkFlag", 0);
				map.put("success", 0);
			}
		}
		
		System.out.println("checkFlag="+checkFlag);
		System.out.println("map="+map);
		return map;
	}
	
	@RequestMapping("/member/find")
	public String memFind() {
		 
		return "member/mem_find";
	}
	
	//이메일인증 추가 
	@RequestMapping("/member/joinAction")
	public String memJoinAction(MemberDTO memJoinDTO, Model model, HttpServletRequest req, HttpServletResponse resp, HttpSession session) 
			throws IOException {
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
		
		String isNaver = req.getParameter("hiddenPw");
		
		if(isNaver.equals("NAVERLOGIN!")) {
			mem_id = req.getParameter("hiddenId");
			mem_pw = req.getParameter("hiddenPw");
			mem_gender = req.getParameter("hiddenGender");
			mem_birth_month = req.getParameter("hiddenMonth");
			mem_birth_day = req.getParameter("hiddenDay");
			mem_birth = mem_birth_year+mem_birth_month+mem_birth_day;
		}
		System.out.println("아이디:"+mem_id);
		System.out.println("비번:"+mem_pw);
		System.out.println("이름:"+mem_name);
		System.out.println("폰:"+mem_phone);
		System.out.println("성별:"+mem_gender);
		System.out.println("이메일:"+mem_email);
		System.out.println("생일:"+mem_birth);
			
		sqlSession.getMapper(MemberImpl.class).memjoinAction(mem_id, mem_pw, mem_name, mem_birth,mem_phone, mem_gender, mem_email);
		
		if(isNaver.equals("NAVERLOGIN!")) {
			// y로 바꿔주고, 세션추가후  홈으로 이동
			System.out.println("joinAction호출");
			MemberDTO vo = sqlSession.getMapper(MemberImpl.class).login(mem_id, mem_pw);
			session.setAttribute("memberInfo", vo);
			sqlSession.getMapper(MemberImpl.class).alter_naverKey(mem_id);
			resp.setContentType("text/html; charset=UTF-8");
			PrintWriter out = resp.getWriter();
			out.println("<script>alert('회원가입이 완료되었습니다.');</script>");
			out.flush();
			return "member/home";
		}
		else
			// 일반회원일때는 메일보냄
			mailsender.mailSendWithUserKey(memJoinDTO.getMem_email(), memJoinDTO.getMem_id(), req);

		return "member/mem_joinAction";  
	}
	
	//회원가입버튼 클릭시 호출됨
	@RequestMapping("/Captcha")
	public String captcha(Model model, HttpSession session, HttpServletRequest req, HttpServletResponse resp) {
		String clientId = "2WQHXW_ouJyzabqjO8zn";
	      String clientSecret = "Nlwn_kYZq9";
	      try {
	          String code = "0"; // 키 발급 받을 때는 0으로 설정
	          String apiURL = "https://openapi.naver.com/v1/captcha/nkey?code=" + code;
	          URL url = new URL(apiURL);
	          HttpURLConnection con = (HttpURLConnection)url.openConnection();
	          con.setRequestMethod("GET");
	          con.setRequestProperty("X-Naver-Client-Id", clientId);
	          con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
	          int responseCode = con.getResponseCode();
	          BufferedReader br;
	          if(responseCode==200) { 
	              br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	          } else {  
	              br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	          }
	          String inputLine;
	          StringBuffer response = new StringBuffer();
	          while ((inputLine = br.readLine()) != null) {
	              response.append(inputLine);
	          }
	          br.close();
	          System.out.println(response.toString());
	          resp.setContentType("text/html;charset=UTF-8");
	          
				
				//서블릿에서 세션객체를 얻어온다.
				session = req.getSession();
				
				session.setAttribute("key", response.toString());
	          
	      } catch (Exception e) {
	          System.out.println(e);
	      }
		
		return "member/captcha";
	}
	 
	//이메일 인증 컨트롤러('y로바꿈')
	@RequestMapping(value = "/user/key_alter", method = RequestMethod.GET)
	public String key_alterConfirm(@RequestParam("mem_id") String user_id, @RequestParam("user_key") String key) {
	
		mailsender.alter_userKey_service(user_id, key); // mailsender의 경우 @Autowired
	
		return "member/mem_joinActionSuccess";
	}
	
	// 아이디중복확인
	@RequestMapping("/member/checkId")
	@ResponseBody
	public Map<String, Object> checkId(HttpServletRequest req, HttpSession session) 
	{
		String mem_id = req.getParameter("mem_id");
		String mem_pw = req.getParameter("mem_pw");
		int userId = sqlSession.getMapper(MemberImpl.class).isUserId(mem_id);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(userId == 1) {
			// 로그인할때 네이버로그인이면 세션에 추가
			if(mem_pw.equals("NAVERLOGIN!")) {
				MemberDTO vo = sqlSession.getMapper(MemberImpl.class).login(mem_id, mem_pw);
				session.setAttribute("memberInfo", vo);
			}
			map.put("isUserId", 1);
		}
		else {
			map.put("isUserId", 0);
		}
		return map;
	}
	
	////회원정보수정폼진입
	@RequestMapping("/member/memberModify")
	public String memberModify(Model model, HttpServletRequest req,
			HttpSession session) {
		String tab = req.getParameter("tab");
		System.out.println("tab="+tab);
		
	//회원정보 가져오기
	MemberDTO dto = sqlSession.getMapper(MemberImpl.class)
			.view(((MemberDTO)session.getAttribute("memberInfo")).getMem_id());
	model.addAttribute("dto", dto);
	
	
	/*********페이지처리>접수현황**********/
	//멤버의 접수현황 레코드 갯수
	String addQueryString = "";
	int totalRecordCount = 0;
	if(tab==null) tab = "0";
	int temp = Integer.parseInt(tab);
	if(temp==2) {totalRecordCount = sqlSession.getMapper(MemberImpl.class).reserCount(((MemberDTO)session.getAttribute("memberInfo")).getMem_idx());}
	else{totalRecordCount = sqlSession.getMapper(MemberImpl.class).reserMemCount(((MemberDTO)session.getAttribute("memberInfo")).getMem_idx());}
	System.out.println("totalRecordCount="+totalRecordCount);
	int mem_idx = ((MemberDTO)session.getAttribute("memberInfo")).getMem_idx();
	
	int pageSize = 5;
	int blockPage = 5;
	
	//전체페이지수계산하기
	int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);
	System.out.println("totalPage="+totalPage);
	//시작 및 끝 rownum 구하기
	int nowPage = req.getParameter("nowPage")==null ? 1 :
		Integer.parseInt(req.getParameter("nowPage"));
	int start = (nowPage-1) * pageSize + 1;
	int end = nowPage * pageSize;
	System.out.println("start="+start);
	System.out.println("end="+end);

	//접수현황 가져오기
	System.out.println("tab="+tab);
	ArrayList<ReservationDTO> reservationDTO = null;
	if(temp==2) {reservationDTO = sqlSession.getMapper(MemberImpl.class).reserPage(start, end, mem_idx);}
	else {reservationDTO = sqlSession.getMapper(MemberImpl.class).reservationPage(start, end, mem_idx);}
	//ArrayList<ReservationDTO> reservationDTO = sqlSession.getMapper(MemberImpl.class).reservationPage(start, end, mem_idx);
    int virtualNum = 0;
    int countNum = 0;
	for(ReservationDTO reserDTO : reservationDTO) {
		
		reserDTO.setResv_date(reserDTO.getResv_date().split(" ")[0]); 
		//reserDTO.setResv_time(reserDTO.getResv_time().split(" ")[1]);
		
		virtualNum = totalRecordCount - (((nowPage-1)*pageSize) + countNum++);
        reserDTO.setVirtualNum(virtualNum);
	}
	//페이지 처리를 위한 처리부분
		String pagingImg = com.softlock.model.utilMem.PagingUtil.pagingImg(totalRecordCount,
		pageSize, blockPage, nowPage, 
		req.getContextPath()+"/member/memberModify?"+addQueryString, tab);
	
	model.addAttribute("tab", tab);
	model.addAttribute("virtualNum", virtualNum);
	model.addAttribute("pagingImg", pagingImg);
	model.addAttribute("totalRecordCount", totalRecordCount);
	model.addAttribute("reservationDTO", reservationDTO);
	model.addAttribute("mem_idx", mem_idx);
	return "member/mem_myPage";
	}
	
	//예약 삭제 처리
	@RequestMapping("/member/reserdelete")
	public void reserdelete(HttpServletRequest req,HttpServletResponse response) throws IOException {
		
		String resv_idx = req.getParameter("resv_idx");
		String hp_name = req.getParameter("hp_name");
		String resv_date = req.getParameter("resv_date");
		
		System.out.println("resv_idx="+resv_idx);
		System.out.println("hp_name="+hp_name);
		System.out.println("resv_date="+resv_date);
		
		//ReservationDTO rDTO = sqlSession.getMapper(MemberImpl.class).reservation(resv_idx);
		sqlSession.getMapper(MemberImpl.class).reserdelete(resv_idx);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script>alert('삭제되었습니다.'); location.href='memberModify?tab=1';</script>");
		//out.println("<script>var ans = confirm('예약 병원명 : '+hp_name+' 예약시간 : '+resv_date+'정말로 삭제하시겠습니까?');location.href='memberModify?tab=1';</script>");
		out.flush();

	}
	
	/////회원정보수정액션
	@RequestMapping("/member/modifyAction")
	public void modifyAction(Model model, HttpServletRequest req, HttpSession session, HttpServletResponse response) throws IOException {
		System.out.println("아이디" +((MemberDTO)session.getAttribute("memberInfo")).getMem_id());
		sqlSession.getMapper(MemberImpl.class).modifyAction(
				req.getParameter("mem_pw"), req.getParameter("mem_name"), req.getParameter("mem_phone"), ((MemberDTO)session.getAttribute("memberInfo")).getMem_id());
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script>alert('정보수정이 완료되었습니다'); location.href='../member/home';</script>");
		out.flush();
	}
	
	//회원탈퇴처리 비밀번호확인폼 진입
	@RequestMapping("/member/memberDeleteCk")
	public String memDeleteck() {
		return "member/mem_pwCk";
	}
	
	//회원탈퇴처리
	@RequestMapping("/member/memDelteAction")
	@ResponseBody
	public Map<String, Object> memDelteAction(HttpServletRequest req, HttpSession session, HttpServletResponse response) throws IOException {
		Map<String, Object> map = new HashMap<String, Object>();
		
		String id = req.getParameter("id");
		String pass = req.getParameter("pass");
		
		int user = sqlSession.getMapper(MemberImpl.class).isUser(id, pass);
		
		String retrunLoc="";
	
		if(user==1) {
		
			sqlSession.getMapper(MemberImpl.class).delete(id);
			map.put("success", "1");
			session.invalidate();
			map.put("returnLoc", "../member/home");
		
		} else {
			map.put("success", "0");
			map.put("msg", "아이디 및 비밀번호를 확인해주세요");
			
		}
		return map;
		
	}
	
	
	@Autowired
	private UserSearchService searchService;
	
	// 아이디 찾기
	@RequestMapping(value = "/member/memSearch", method = RequestMethod.POST)
	@ResponseBody
	public String userIdSearch(@RequestParam("mem_name") String  mem_name, 
			@RequestParam("mem_phone") String mem_phone) {
		
		String result = searchService.get_searchId(mem_name, mem_phone);
		System.out.println("mem_name="+mem_name);
		System.out.println("mem_phone="+mem_phone);
		return result;
	}
	
	// 비밀번호 찾기
	@RequestMapping("/member/memSearchPassword")
	public String searchPassword(
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String mem_id = request.getParameter("mem_id");
		String mem_email = request.getParameter("mem_email");
		
		System.out.println("mem_id="+mem_id);
		System.out.println("mem_email="+mem_email);
		
		//유저 확인하기
		MemberDTO memberDTO = sqlSession.getMapper(MemberImpl.class).userInfo(mem_id);
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		if(memberDTO==null) {
			System.out.println("memberDTO="+memberDTO);
			out.println("<script>alert('해당 아이디가 없습니다.'); location.href='../member/find'; </script>");
			out.flush();
		}else {
			out.println("<script>alert('해당이메일로 임시 비밀번호가 발송되었습니다.'); </script>");
			out.flush();
			System.out.println("mem_id="+mem_id);
			System.out.println("mem_email="+mem_email);
			//메일 보내기
			mailsender.mailSendWithPassword(mem_id,mem_email, request);
		}
		
		return "member/mem_login";
		
	}
	
		//스크랩(1.병원상세보기)
		@RequestMapping("/member/memHpView")
		public String memHpView(HttpServletRequest req) {
			return "member/mem_hpView";	
		}
		
		//스크랩(2.체크하기)
		@RequestMapping("/member/ClipCheck")
		@ResponseBody
		public Map<String, Object> ClipCheck(HttpServletRequest req){
			String clip_mem_idx = req.getParameter("clip_mem_idx");
			String clip_hp_idx = req.getParameter("clip_hp_idx");
			System.out.println("clip_mem_idx="+clip_mem_idx);
			System.out.println("clip_hp_idx="+clip_hp_idx);

			Map<String, Object> map = new HashMap<String, Object>();
			int isClip = sqlSession.getMapper(MemberImpl.class).ClipCheck(clip_mem_idx, clip_hp_idx);
			boolean isCheck;
			if(isClip == 0)
				isCheck = false;
			else
				isCheck = true;
			System.out.println("isCheck="+isCheck);
			if(isCheck == true)
				map.put("result", 1);
			else
				map.put("result", 0);
			System.out.println("map="+map.get("result"));
			return map;
		}
		
		//스크랩(3.추가하기)
		@RequestMapping("/member/ClipAdd")
		@ResponseBody
		public Map<String, Object> ClipAdd(HttpServletRequest req){
			String clip_mem_idx = req.getParameter("clip_mem_idx");
			String clip_hp_idx = req.getParameter("clip_hp_idx");
			System.out.println("clip_mem_idx="+clip_mem_idx);
			System.out.println("clip_hp_idx="+clip_hp_idx);

			Map<String, Object> map = new HashMap<String, Object>();
			sqlSession.getMapper(MemberImpl.class).instClip(clip_mem_idx, clip_hp_idx);
			map.put("result", 1);
			
			return map;
		}
		//스크랩(4.삭제하기)
		@RequestMapping("/member/ClipDelete")
		@ResponseBody
		public Map<String, Object> ClipDelete(HttpServletRequest req){
			String clip_mem_idx = req.getParameter("clip_mem_idx");
			String clip_hp_idx = req.getParameter("clip_hp_idx");
			System.out.println("clip_mem_idx="+clip_mem_idx);
			System.out.println("clip_hp_idx="+clip_hp_idx);

			Map<String, Object> map = new HashMap<String, Object>();
			sqlSession.getMapper(MemberImpl.class).ClipDelete(clip_mem_idx, clip_hp_idx);
			map.put("result", 1);
				
			return map;
		}
		
		////스크랩 페이지
		@RequestMapping("/member/memberClip")
		public String memberClip(Model model, HttpServletRequest req,
				HttpSession session) {
			String tab = req.getParameter("tab");
			System.out.println("tab="+tab);
		
		/*********페이지처리>접수현황**********/
		//스크랩 레코드 갯수
		String addQueryString = "";
		int totalRecordCount = sqlSession.getMapper(MemberImpl.class).clipRecordCount(((MemberDTO)session.getAttribute("memberInfo")).getMem_idx());
		System.out.println("totalRecordCount="+totalRecordCount);
		
		int mem_idx = ((MemberDTO)session.getAttribute("memberInfo")).getMem_idx();
		
		int pageSize = 5;
		int blockPage = 5;
		
		//전체페이지수계산하기
		int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);
		System.out.println("totalPage="+totalPage);
		//시작 및 끝 rownum 구하기
		int nowPage = req.getParameter("nowPage")==null ? 1 :
			Integer.parseInt(req.getParameter("nowPage"));
		int start = (nowPage-1) * pageSize + 1;
		int end = nowPage * pageSize;
		System.out.println("start="+start);
		System.out.println("end="+end);

		//접수현황 가져오기
		System.out.println("tab="+tab);
		ArrayList<HospitalDTO> HospitalDTO = sqlSession.getMapper(MemberImpl.class).clipRecordPage(start, end, mem_idx);
		
	    int virtualNum = 0;
	    int countNum = 0;
		for(HospitalDTO HosDTO : HospitalDTO) {
			
			/*reserDTO.setResv_date(reserDTO.getResv_date().split(" ")[0]); 
			reserDTO.setResv_time(reserDTO.getResv_time().split(" ")[1]);*/
			virtualNum = totalRecordCount - (((nowPage-1)*pageSize) + countNum++);
			HosDTO.setVirtualNum(virtualNum);
		}
		//페이지 처리를 위한 처리부분
			String pagingImg = com.softlock.model.utilMem.PagingUtil.pagingImg(totalRecordCount,
			pageSize, blockPage, nowPage, 
			req.getContextPath()+"/member/memberClip?"+addQueryString, tab);
		
		model.addAttribute("tab", tab);
		model.addAttribute("virtualNum", virtualNum);
		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("totalRecordCount", totalRecordCount);
		/*model.addAttribute("reservationDTO", reservationDTO);*/
		model.addAttribute("HospitalDTO", HospitalDTO);
		model.addAttribute("mem_idx", mem_idx);
		return "member/mem_clip";
		}
		
		//스크랩(4.삭제하기)
		@RequestMapping("/member/memClipDelete")
		public void memClipDelete(HttpServletRequest req, HttpServletResponse response) throws IOException{
			String clip_mem_idx = req.getParameter("clip_mem_idx");
			String clip_hp_idx = req.getParameter("hp_idx");
			System.out.println("clip_mem_idx="+clip_mem_idx);
			System.out.println("clip_hp_idx="+clip_hp_idx);

			sqlSession.getMapper(MemberImpl.class).memClipDelete(clip_mem_idx, clip_hp_idx);
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('삭제되었습니다.'); location.href='memberClip?tab=4';</script>");
			//out.println("<script>var ans = confirm('예약 병원명 : '+hp_name+' 예약시간 : '+resv_date+'정말로 삭제하시겠습니까?');location.href='memberModify?tab=1';</script>");
			out.flush();
			
		}
		
		//건강정보
		@RequestMapping("/information/information")
		public String information() {
			
			return "information/information";
		}
		
		@RequestMapping("/information/searchInformation")
	    @ResponseBody
	    public ArrayList<GlobalDicDTO> searchInformation(HttpServletRequest req){
	    	String title = req.getParameter("title");
	    	System.out.println("title="+title);
	    	
	    	GlobalDicDTO gDto = new GlobalDicDTO();
	    	gDto.setTitle(title);
	    	
	    	ArrayList<GlobalDicDTO> searchList = (ArrayList<GlobalDicDTO>) sqlSession.getMapper(MemberImpl.class).searchGlo(gDto);
	        return searchList;
	    }
		
	/*	@RequestMapping("/information/searchInfo")
		public String searchInfo(HttpServletRequest req, Model model) {
			if(!req.getParameter("title").equals("")) {
			
			String title = req.getParameter("title");
			System.out.println("title="+title);
			
			
	    	GlobalDicDTO gDto = sqlSession.getMapper(MemberImpl.class).searchInfo(title);
	    	model.addAttribute(gDto);
			
			return "information/information";
			} else {	@RequestMapping("/information/searchInformation")
		
	
				return "information/information";
			}
		}*/
		
		@RequestMapping("/information/searchInfo")
		@ResponseBody
		public GlobalDicDTO searchInfo(HttpServletRequest req){
			String title = req.getParameter("title");
			System.out.println("title="+title);
			
			GlobalDicDTO globalDicDTO = sqlSession.getMapper(MemberImpl.class).searchInfo(title);
			/*System.out.println("globalDicDTO.getDic_contents="+globalDicDTO.getDic_contents());*/
			return globalDicDTO;
		}
		
		@RequestMapping("/chat")
		public String sock(Model model, HttpSession session) {
			
			return "chat";
		}
}
