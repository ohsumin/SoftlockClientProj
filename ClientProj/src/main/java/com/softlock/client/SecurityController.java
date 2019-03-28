package com.softlock.client;

import java.security.Principal;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SecurityController {
		
	@RequestMapping("/security/login_secu")
	public String login_secu(Model model, Principal principal, Authentication authentication) {
		
		/*UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		String username = userDetails.getUsername();	
		String password = userDetails.getPassword();
		
		model.addAttribute("username", username);
		model.addAttribute("password", password);*/
		
		/*try {
			String username = principal.getName();	
			model.addAttribute("username",username);
			//String password = principal.getPassword();

			//model.addAttribute("password",password);	
			System.out.println(username);
		}
		catch (Exception e) {			
			System.out.println("예외발생");
			e.printStackTrace();
		}*/
		
		return "security/hp_login_secu";
	}
	
	@RequestMapping("/security/hp_Denied")
	public String hp_Denied() {
		
		// 접근거부 페이지
		return "security/hp_Denied";
	}
}