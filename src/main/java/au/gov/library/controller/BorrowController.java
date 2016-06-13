package au.gov.library.controller;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import au.gov.library.exception.BookException;
import au.gov.library.model.Book;
import au.gov.library.model.BookType;
import au.gov.library.model.Borrow;
import au.gov.library.model.BorrowKey;
import au.gov.library.model.Patron;
import au.gov.library.model.PatronType;
import au.gov.library.model.vo.BorrowVo;
import au.gov.library.model.vo.Pagination;
import au.gov.library.service.BookService;
import au.gov.library.service.BooktypeService;
import au.gov.library.service.BorrowService;
import au.gov.library.service.PatronService;
import au.gov.library.service.PatronTypeService;

@Controller
@RequestMapping(value="/borrow")
public class BorrowController {
  
  @Autowired
  private BorrowService borrowService;
  
  @Autowired
  private PatronService patronService;
  
  @Autowired
  private BookService bookService;
  
  @Autowired
  private PatronTypeService patrontypeService;
  
  @Autowired
  private BooktypeService booktypeService;
  
  @RequestMapping(value="/borrow.do", method = RequestMethod.GET)
  public String borrow(){
    return "borrow/borrow";
  }
  
  /**
   * Get Patron information
   * @param patronNumber
   * @return
   */
  @RequestMapping(value = "/getPatronInfo", method=RequestMethod.POST)
  @ResponseBody
  public Object getPatronInfo(long patronNumber) {
    Patron patron = patronService.selectPatronByCardNumber(patronNumber);    
    Map<String, Object> result = new HashMap<String, Object>();
    if (patron != null) {
      PatronType patronType = patrontypeService.selectPatrontype(patron.getType());
      result.put("name", patron.getName());
      result.put("type", patron.getType());
      result.put("canBorrowNumber", patronType.getBorrowNumber());
      result.put("borrowedNumber", patron.getBorrowed());
      result.put("status", "200");
    } else {
      result.put("status", "300");
      result.put("msg", "No match Patron");
    }
    return result;
  }
  
  @RequestMapping(value="/getBookInfo", method=RequestMethod.POST)
  @ResponseBody
  public Object getBookInfo(long bookNumber) {
    Book book = bookService.selectBookByBookNumber(bookNumber);
    Map<String, Object> result = new HashMap<String, Object>();
    if (book != null) {
      BookType bookType = booktypeService.selectBooktypeByName(book.getBookType());
      result.put("name", book.getBookName());
      result.put("author", book.getAuthor());
      result.put("type", book.getBookType());
      result.put("day", bookType.getBorrowDay());
      result.put("number",book.getNumber());
      result.put("canBorrow", book.getNumber() - book.getBorrowedNumber());
      result.put("status", "200");
    } else {
      result.put("status", "300");
      result.put("msg", "No match Book");
    }
    return result;
  }
  
  @RequestMapping(value="/borrowBook")
  public String borrowBook(Long patronNumber, Long bookNumber, ModelMap modelMap) {
    Book book = bookService.selectBookByBookNumber(bookNumber);
    Patron patron = patronService.selectPatronByCardNumber(patronNumber);
    BorrowVo vo = new BorrowVo();
    vo.setBookNumber(bookNumber);
    vo.setPatronNumber(patronNumber);
    vo.setBookName(book.getBookName());
    vo.setPatronName(patron.getName());
    vo.setBorrowedDate(Calendar.getInstance().getTime());
    try {
      borrowService.borrowBook(vo);
      modelMap.addAttribute("borrow_result", true);
      modelMap.addAttribute("success", "Borrow Successfully");
    } catch (BookException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
    return "borrow/borrow";
  }
 
  
  @RequestMapping(value="/searchBorrow")
  public String searchBorrow(String patronNumber, String bookNumber, String page ,ModelMap map) {
    Long cardNum = null;
    Long bookNum = null;
    Pagination pagination = new Pagination();
    if (!StringUtils.isEmpty(patronNumber))
      cardNum = Long.parseLong(patronNumber);
    else if (!StringUtils.isEmpty(bookNumber))
      bookNum = Long.parseLong(bookNumber);
    if (StringUtils.isEmpty(page)) {
      pagination.setCurPage(1);
    } else {
      pagination.setCurPage(Long.parseLong(page));
    }
    pagination.setPageSize(9);
    
    BorrowKey key = new BorrowKey();
    key.setBookNumber(bookNum);
    key.setPatronNumber(cardNum);
    List<Borrow> records = borrowService.selectBorrowRecordByKey(key, pagination);
    pagination = borrowService.countByKey(key, pagination);
    
    if (records != null) {
      map.addAttribute("records", records);
    } else {
      map.addAttribute("error", "No records");
    }
    map.addAttribute("borrowResult", true);
    map.addAttribute("pagination", pagination);
    map.addAttribute("patronNumber", patronNumber);
    map.addAttribute("bookNumber", bookNumber);
    return "borrow/borrow";
    
  }
  
  @RequestMapping(value="/returnBook", method=RequestMethod.POST)
  @ResponseBody
  public Object returnBook(BorrowKey key) {
    Borrow borrow = borrowService.returnBook(key);
    Map<String, Object> result = new HashMap<String, Object>();
    if (borrow != null) {
      result.put("status", "200");
      result.put("borrow", borrow);
    } else {
      result.put("status", "300");
      result.put("msg", "Record not exists");
    }
    return result;
  }
  
  @RequestMapping(value="/deleteBook", method=RequestMethod.POST)
  @ResponseBody
  public Object deleteBook(BorrowKey key) {
    borrowService.deletBorrowRecord(key);
    Map<String, Object> result = new HashMap<String, Object>();
    result.put("status", "200");
    return result;
  }
}
