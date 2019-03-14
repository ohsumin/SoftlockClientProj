package com.softlock.client;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.softlock.model.HospListDTO;
import com.softlock.model.HospitalDTO;
import com.softlock.model.HospitalImpl;

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
	
    @RequestMapping("/hospList/RealtimeSearch")
    @ResponseBody
    public ArrayList<HospListDTO> searchName(HttpServletRequest req){
    	String searchStr = req.getParameter("searchStr");
    	System.out.println(searchStr);
    	
    	HospListDTO hDto = new HospListDTO();
    	hDto.setHosplist_name(searchStr);
    	
    	/*//JSON배열을 만들기 위한 선언
        //List<HospListDTO> searchResult = sqlSession.getMapper(HospitalImpl.class).searchHp(searchStr);
        List<HospListDTO> searchResult = sqlSession.getMapper(HospitalImpl.class).searchHp(hDto);
      
        Map<String, Object> map = new HashMap<String, Object>(); 
        ArrayList<Object> searchList = new ArrayList<Object>();          
        
        ArrayList<String> listName = new ArrayList<String>();
        ArrayList<String> listAdrs = new ArrayList<String>();
        for(HospListDTO m : searchResult) {
           map.put("resultName", m.getHosplist_name());
           map.put("resultAddr", m.getHosplist_adrs());
           
           searchList.add(map);
        }*/
    	
    	ArrayList<HospListDTO> searchList = (ArrayList<HospListDTO>) sqlSession.getMapper(HospitalImpl.class).searchHp(hDto);
   /*     map.put("getHosplist_name", listName);
        map.put("getHosplist_adrs", listAdrs);*/
        return searchList;
    }
    
    // 회원가입
    @RequestMapping("/hospital/join")
    public String hpJoin() {
    	
    	return "/hospital/hp_join";
    }
    
    @RequestMapping("/hospital/joinAction")
    @ResponseBody
    public String hpjoinAction(HttpServletRequest req, HttpSession session) {
        
       String hp_id = req.getParameter("hp_id");
       String hp_pw = req.getParameter("hp_pw");
       String hp_name = req.getParameter("hp_name");
       String hp_num = req.getParameter("hp_num");
       String hp_username = req.getParameter("hp_username");
       String hp_email = req.getParameter("hp_email");
       String hp_phone = req.getParameter("hp_phone");
       String hp_address = req.getParameter("hp_address");
       
       // Mybatis 사용
       // 회원정보 저장
       ArrayList<HospitalDTO> vo = sqlSession.getMapper(HospitalImpl.class).hpjoinAction(hp_id, hp_pw, hp_name, hp_num, hp_username, hp_email, 
             hp_phone, hp_address);
       
       return "hospital/hp_joinAction";
    }
}
