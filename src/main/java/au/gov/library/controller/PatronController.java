package au.gov.library.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import au.gov.library.model.Librarian;
import au.gov.library.model.Patron;
import au.gov.library.model.PatronType;
import au.gov.library.model.vo.Pagination;
import au.gov.library.model.vo.PatronVo;
import au.gov.library.service.PatronService;
import au.gov.library.service.PatronTypeService;
import au.gov.library.util.EntitiesLogPrinter;

@Controller
@RequestMapping(value = "/patron")
public class PatronController {

	@Autowired
	private PatronService patronService;

	@Autowired
	private PatronTypeService patrontypeService;
	
	
	@RequestMapping(value = "/patron.do", method = RequestMethod.GET)
	public String Patron(ModelMap modelMap, HttpServletRequest request){
		List<Patron> patrons = new ArrayList<Patron>();
		Pagination pagination = new Pagination();
		pagination.setCurPage(1L);
		pagination.setPageSize(16L);
		patrons = patronService.selectPatrons(pagination);
		pagination = patronService.count(pagination);
		modelMap.addAttribute("patrons", patrons);
		modelMap.addAttribute("pagination", pagination);
		
		
	    request.getSession().setAttribute("title", "Patron Center");
	    Librarian user = (Librarian)request.getSession().getAttribute("user");
	    if (user.getIsAdmin() == 1)
	      return "librarian/admin_center";
	    else
	      return "librarian/user_center";
	}
	
	@RequestMapping(value = "/searchPatronbyPage", method = RequestMethod.POST)
	public String searchBookUser(String page, ModelMap map, HttpServletRequest request) {
		Pagination pagination = new Pagination();
		System.out.println("====laign======" + page);
		if (!StringUtils.isEmpty(page)) {
			pagination.setCurPage(Long.parseLong(page));
		} else {
			pagination.setCurPage(1L);
		}
		pagination.setPageSize(16L);
		List<Patron> patrons = patronService.selectPatrons(pagination);
		pagination = patronService.count(pagination);
		map.addAttribute("patrons", patrons);
		map.addAttribute("pagination", pagination);
		Librarian user = (Librarian)request.getSession().getAttribute("user");
	    if (user.getIsAdmin() == 1)
		      return "librarian/admin_center";
		    else
		      return "librarian/user_center";
	}

	@RequestMapping(value = "/searchPatron", method = RequestMethod.POST)
	@ResponseBody
	public Object searchPatron(String cardNumber, String patronType) {
		Patron patron = patronService.selectPatronByCardNumber(Long.parseLong(cardNumber), patronType);
		Map<String, Object> map = new HashMap<String, Object>();
		if (patron == null)
			map.put("status", "300");
		else {
			map.put("status", "200");
			map.put("patron", patron);
		}
		return map;
	}

	@RequestMapping(value = "/getPatronType", method = RequestMethod.POST)
	@ResponseBody
	public Object getPatronType() {
		List<PatronType> list = patrontypeService.selectPatrontype();
		return list;
	}

	@RequestMapping(value = "/getNewCardNumber", method = RequestMethod.POST)
	@ResponseBody
	public Object getNewCardNumber() {
		Long newCardNumber = patronService.getNewCardNumber();
		return newCardNumber;
	}

	@RequestMapping(value = "/addPatron", method = RequestMethod.POST)
	@ResponseBody
	public Object addPatron(PatronVo vo) {
		EntitiesLogPrinter.print(vo);
		vo.setCardNumber(patronService.getNewCardNumber());
		vo.setCreateTime(Calendar.getInstance().getTime());
		vo.setBorrowed(0);
		vo.setIsLost(0);
		patronService.insertPatron(vo);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("status", 200);
		result.put("cardNumber", vo.getCardNumber());
		result.put("type", vo.getType());
		return result;
	}

	@RequestMapping(value = "/updatePatron", method = RequestMethod.POST)
	@ResponseBody
	public Object updatePatron(PatronVo vo) {
		EntitiesLogPrinter.print(vo);
		patronService.updatePatron(vo);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("status", 200);
		result.put("cardNumber", vo.getCardNumber());
		result.put("type", vo.getType());

		return result;
	}

	@RequestMapping(value = "/deletePatron", method = RequestMethod.POST)
	@ResponseBody
	public Object deletePatron(long cardNumber) {
		patronService.deletePatron(cardNumber);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("status", 200);
		return result;
	}

}
