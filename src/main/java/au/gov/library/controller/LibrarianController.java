package au.gov.library.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import au.gov.library.model.Librarian;
import au.gov.library.model.vo.LibrarianVo;
import au.gov.library.service.LibrarianService;

@Controller
@RequestMapping(value="/librarian")
public class LibrarianController {
  
  @Autowired
  private LibrarianService userService;
  
  
  /**
   * Verify user login
   * @param user
   * @param request
   * @param redirectAttr
   * @return
   */
  @RequestMapping(value="/login.do", method = RequestMethod.POST)
  public String login(LibrarianVo userVo, HttpServletRequest request, RedirectAttributes redirectAttr) {
    request.getSession().setAttribute("title", "Login");
    Librarian user = userService.login(userVo);
    if (user != null) {
      request.getSession().setAttribute("user", user);
      redirectAttr.addFlashAttribute("success", "Login Successful");
      return "redirect:/index.do";
    }
    else {
      redirectAttr.addFlashAttribute("error", " Incorrect username or password");
      return "redirect:/librarian/login.do";
    }
  }
  
  /**
   * User login page
   * @param request
   * @return
   */
  @RequestMapping(value="/login.do", method = RequestMethod.GET)
  public String login(HttpServletRequest request) {
    request.getSession().setAttribute("title", "Login");
    return "librarian/login";
  }
  
  /**
   * Logout
   * @param request
   * @param redirectAttr
   * @return
   */
  @RequestMapping(value="/logout.do", method=RequestMethod.GET)
  public String logout(HttpServletRequest request, RedirectAttributes redirectAttr) {
    request.getSession().setAttribute("user", null);
    redirectAttr.addFlashAttribute("success", "Logout Successful");
    return "redirect:/index.do";
  }
  
  /**
   * User Profile
   * @return
   */
  @RequestMapping(value="/user_center", method = RequestMethod.GET)
  public String userCenter(HttpServletRequest request) {
    request.getSession().setAttribute("title", "Patron Center");
    Librarian user = (Librarian)request.getSession().getAttribute("user");
    if (user.getIsAdmin() == 1)
      return "librarian/admin_center";
    else
      return "librarian/user_center";
  }
  
  @RequestMapping(value="manageUser")
  public String manageUser(ModelMap map) {
    List<Librarian> list = userService.selectUsers(null);
    map.addAttribute("userList", list);
    return "librarian/manage_user";
  }
  
  @RequestMapping(value="addUser", method=RequestMethod.POST)
  public String addUser(LibrarianVo vo, ModelMap map) {
    userService.insertUser(vo);
    List<Librarian> list = userService.selectUsers(null);
    map.addAttribute("userList", list);
    map.addAttribute("success", "Add Librarian \'" + vo.getUsername() + "\' Successful");
    return "librarian/manage_user";
  }
  
  @RequestMapping(value="deleteUser", method=RequestMethod.POST)
  @ResponseBody
  public String deleteUser(String name) {
    userService.deleteUser(name);
    return "200";
  }
}
