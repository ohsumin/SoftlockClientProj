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

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class FileuploadController {

	//물리적 경로 확인하기
	@RequestMapping("/fileUpload/uploadPath.do")
	public void uploadPath(HttpServletRequest req,  
			HttpServletResponse resp) {
		
		String path = req.getSession().getServletContext()
				.getRealPath("/resource/upload");		
		try {
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter print = resp.getWriter();
			print.println("/upload 폴더의 물리적경로");
			print.print(path);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	@RequestMapping("/fileUpload/uploadForm.do")
	public String uploadForm() {
		return "07Fileupload/uploadForm";
	}
	
	
	@RequestMapping("/fileUpload/uploadAction.do")
	public String uploadAction(HttpServletRequest req,
			Model model)
	{
		//upload폴더의 물리적경로 얻어오기
		String path = 
			req.getSession().getServletContext()
				.getRealPath("/resources/upload");
		
		//뷰로 전달할 정보를 저장하기위해 Map컬렉션 생성
		Map returnObj = new HashMap();		
		try
		{
			/*
			파일업로드를 위한 객체생성. 객체 생성과 동시에 파일업로드는
			완료되고 나머지 폼값은 Multipart객체가 통째로 받아서 
			처리한다. 
			 */
			MultipartHttpServletRequest mhsr = 
				(MultipartHttpServletRequest) req;
			
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
				String originalName = new String(mfile.getOriginalFilename()
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
				String saveFileName = getUuid() + ext;	
				
				//설정한 경로명 조립
				File serverFullName = new File(path + File.separator 
						+ saveFileName);
				
				//업로드한 파일을 지정경로에 저장한다. 
				mfile.transferTo(serverFullName);
				
				Map file = new HashMap();
				file.put("originalName", originalName);//원본파일명
				file.put("saveFileName", saveFileName);//저장된파일명
				//file.put("serverFullName", serverFullName);
				//file.put("title", title);//타이틀
					
				resultList.add(file);
			}
			returnObj.put("files", resultList);
		}		 
		catch(IOException e){
			e.printStackTrace();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("returnObj", returnObj);	
		
		return "07Fileupload/uploadAction";
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
	
	
	//파일목록보기
	@RequestMapping("/fileUpload/uploadList.do")
	public String uploadList(HttpServletRequest req, 
			Model model)
	{
		//물리적 경로 얻어오기
		String path = 
			req.getSession().getServletContext()
				.getRealPath("/resources/upload");
		//File객체 생성
		File file = new File(path);
		//파일 목록 얻어오기
		File[] fileArray = file.listFiles();
		/*
		파일의 정보를 저장하기 위한 Map 생성
		Map(파일명(key), 파일용량(value))
		 */
		Map<String, Integer> fileMap = 
			new HashMap<String, Integer>();
		
		//확장for문으로 파일목록의 갯수만큼 반복
		for(File f : fileArray)
		{
			fileMap.put(f.getName(), 
				(int)Math.ceil(f.length()/1024.0));
		}
		//파일정보를 모델에 저장후 View로 전달
		model.addAttribute("fileMap", fileMap);
				
		return "07Fileupload/uploadList";
	}
	
	//파일 다운로드
	@RequestMapping("/fileUpload/download.do")
	public ModelAndView download(HttpServletRequest req
		, HttpServletResponse resp) throws Exception
	{
		//서버에 실제 저장된 파일명
		String fileName = req.getParameter("fileName");
		//원본 파일명
		String oriFileName = req.getParameter("oriFileName");
		//물리적경로 가져오기
		String saveDirectory = 
			req.getSession().getServletContext()
				.getRealPath("/resources/upload/");
		//경로+파일명 으로 File객체 생성
		File downloadFile = 
			new File(saveDirectory+"/"+fileName);
		
		if(!downloadFile.canRead()) {
			throw new Exception("파일을 찾을 수 없습니다");
		}		
		/*
		원본파일명, 저장된파일명을 Model에 저장한 후 
		fileDownloadView 뷰를 호출한다. 그러면 servlet-context.xml에서
		이미 생성한 빈을 호출하게 되어 다운로드가 진행된다. 
		 */
		ModelAndView mv = new ModelAndView();
		mv.setViewName("fileDownloadView");
		mv.addObject("downloadFile", downloadFile);
		mv.addObject("oriFileName", oriFileName);
		return mv;		
	}
	
	
	
	
}
