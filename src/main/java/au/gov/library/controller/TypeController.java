package au.gov.library.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import au.gov.library.model.BookType;
import au.gov.library.model.PatronType;
import au.gov.library.model.vo.BooktypeVo;
import au.gov.library.model.vo.PatrontypeVo;
import au.gov.library.service.BooktypeService;
import au.gov.library.service.PatronTypeService;

@Controller
@RequestMapping(value="/type")
public class TypeController {
  
  @Autowired
  private PatronTypeService patronTypeService;
  
  @Autowired
  private BooktypeService bookTypeService;
  
  @RequestMapping(value="/patronType")
  public String patronType(ModelMap map) {
    List<PatronType> list = patronTypeService.selectPatrontype();
    map.put("typeList", list);
    return "type/patron_type";
  }

  @RequestMapping(value="addPatronType", method=RequestMethod.POST)
  public String addPatronType(PatrontypeVo vo, ModelMap map) {
    patronTypeService.insertPatrontype(vo);
    List<PatronType> list = patronTypeService.selectPatrontype();
    map.put("typeList", list);
    return "type/patron_type";
  }
  
  @RequestMapping(value="deletePatronType", method=RequestMethod.GET)
  public String deletePatronType(String type, ModelMap map) {
    patronTypeService.deletePatrontype(type);
    List<PatronType> list = patronTypeService.selectPatrontype();
    map.put("typeList", list);
    return "type/patron_type";
  }
  
  @RequestMapping(value="bookType")
  public String bookType(ModelMap map){
    List<BookType> list = bookTypeService.selectBooktype();
    map.put("typeList", list);
    return "type/book_type";
  }
  
  @RequestMapping(value="addBookType", method=RequestMethod.POST)
  public String addBookType(BooktypeVo vo, ModelMap map) {
    bookTypeService.insertBooktype(vo);
    List<BookType> list = bookTypeService.selectBooktype();
    map.put("typeList", list);
    return "type/book_type";
  }
  
  @RequestMapping(value="deleteBookType", method=RequestMethod.POST)
  @ResponseBody
  public String deleteBookType(String type, ModelMap map) {
    bookTypeService.deleteBooktype(type);
    return "200";
  }
}
