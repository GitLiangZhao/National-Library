package au.gov.library.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import au.gov.library.model.Book;
import au.gov.library.model.BookType;
import au.gov.library.service.BookService;
import au.gov.library.service.BooktypeService;

@Controller
public class IndexController {
  @Autowired
  private BookService bookService;
  
  @Autowired 
  private BooktypeService bookTypeService;
  
  @RequestMapping("/index.do")
  public String index(HttpServletRequest request, ModelMap map) {
    request.getSession().setAttribute("title", "Home");
//    System.out.println("===========liang=====");
    List<Book> book = bookService.selectNewBooks(8);
    List<BookType> bookTypes = bookTypeService.selectBooktype();
    map.addAttribute("bookTypes", bookTypes);
    map.addAttribute("books", book);
    return "index";
  }
}
