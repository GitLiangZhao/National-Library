package au.gov.library.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import au.gov.library.model.Book;
import au.gov.library.model.BookType;
import au.gov.library.model.vo.BookVo;
import au.gov.library.model.vo.Pagination;
import au.gov.library.service.BookService;
import au.gov.library.service.BooktypeService;
import au.gov.library.util.BookInfoUtil;
import au.gov.library.util.EntitiesLogPrinter;

@Controller
@RequestMapping(value = "/book")
public class BookController {

	@Autowired
	private BookService bookService;

	@Autowired
	private BooktypeService booktypeService;

	@RequestMapping(value = "/book.do", method = RequestMethod.GET)
	public String book(ModelMap modelMap) {
		List<Book> books = new ArrayList<Book>();
		Pagination pagination = new Pagination();
		pagination.setCurPage(1L);
		pagination.setPageSize(8L);
		books = bookService.selectBookByName("", "", pagination);
		pagination = bookService.count("", "", pagination);
		modelMap.addAttribute("books", books);
		modelMap.addAttribute("pagination", pagination);
		modelMap.addAttribute("searchName", "");
		return "book/book";
	}

	@RequestMapping(value = "/getBookTypes", method = RequestMethod.POST)
	@ResponseBody
	public Object getBookTypes() {
		List<BookType> list = booktypeService.selectBooktype();
		return list;
	}

	@RequestMapping(value = "/searchBook", method = RequestMethod.GET)
	public String searchBook(String query, String bookType, String page, ModelMap modelMap) {
		System.out.println("query=" + query);
		List<Book> books = new ArrayList<Book>();
		try {
			Long number = Long.parseLong(query);
			Book book = bookService.selectBook(number, bookType);
			modelMap.addAttribute("book", book);
			modelMap.addAttribute("bookResult", true);
			modelMap.addAttribute("searchType", bookType);
		} catch (NumberFormatException e) {
			Pagination pagination = new Pagination();
			pagination.setCurPage(Long.parseLong(page));
			pagination.setPageSize(8L);
			books = bookService.selectBookByName(query, bookType, pagination);
			pagination = bookService.count(query, "", pagination);
			modelMap.addAttribute("books", books);
			modelMap.addAttribute("pagination", pagination);
			modelMap.addAttribute("searchName", query);
			modelMap.addAttribute("searchType", bookType);
		}
		return "book/book";
	}

	@RequestMapping(value = "/searchBookByISBN", method = RequestMethod.POST)
	@ResponseBody
	public String searchBookByISBN(String isbn) {
		isbn = isbn.trim();
		String json = BookInfoUtil.getBookByISBN(isbn);
		System.out.println(json);
		return json;
	}

	@RequestMapping(value = "/addBook", method = RequestMethod.GET)
	public String addBook(ModelMap modelMap) {
		modelMap.addAttribute("addBook", true);

		return "book/book";
	}

	@RequestMapping(value = "/addBook", method = RequestMethod.POST)
	public String addBook(BookVo vo, ModelMap modelMap) {
		EntitiesLogPrinter.print(vo);
		bookService.insertBook(vo);
		Book book = bookService.selectBookByBookNumber(vo.getBookNumber());
		modelMap.addAttribute("bookResult", true);
		modelMap.addAttribute("book", book);
		modelMap.addAttribute("success", "Add Successfully");
		return "book/book";
	}

	@RequestMapping(value = "/checkBookNumber", method = RequestMethod.POST)
	@ResponseBody
	public String checkBookNumber(long bookNumber) {
		Book book = bookService.selectBookByBookNumber(bookNumber);
		if (book == null)
			return "200";
		else
			return "300";
	}

	@RequestMapping(value = "/deleteBook", method = RequestMethod.POST)
	@ResponseBody
	public String deleteBook(long bookNumber) {
		bookService.deleteBookByBookNumber(bookNumber);
		return "200";
	}

	@RequestMapping(value = "/modifyBook", method = RequestMethod.GET)
	public String modifyBook(Long bookNumber, ModelMap modelMap) {
		Book book = bookService.selectBookByBookNumber(bookNumber);
		List<BookType> types = booktypeService.selectBooktype();
		modelMap.addAttribute("book", book);
		modelMap.addAttribute("modifyBook", true);
		modelMap.addAttribute("bookTypes", types);
		return "book/book";
	}

	@RequestMapping(value = "/modifyBook", method = RequestMethod.POST)
	public String modifyBook(BookVo vo, ModelMap modelMap) {
		bookService.updateBook(vo, vo.getBookNumber());
		modelMap.addAttribute("bookResult", true);
		modelMap.addAttribute("success", "Modify Successfully");
		Book book = bookService.selectBookByBookNumber(vo.getBookNumber());
		modelMap.addAttribute("book", book);
		return "book/book";
	}

	@RequestMapping(value = "/getBookImage.do", method = RequestMethod.POST)
	@ResponseBody
	public String getBookImage(String id) {
		return BookInfoUtil.getBookImage(id);
	}

	@RequestMapping(value = "/getBookDetail")
	public String getBookDetail(long bookNumber, ModelMap map) {
		Book book = bookService.selectBookByBookNumber(bookNumber);
		map.addAttribute("book", book);
		return "book/book_detail";
	}

	@RequestMapping(value = "/searchBookUser", method = RequestMethod.POST)
	public String searchBookUser(String name, String type, String page, ModelMap map) {
		System.out.println("name=" + name);
		System.out.println("type=" + type);
		Pagination pagination = new Pagination();
		if (!StringUtils.isEmpty(page)) {
			pagination.setCurPage(Long.parseLong(page));
		} else {
			pagination.setCurPage(1L);
		}
		pagination.setPageSize(8L);
		List<Book> list = bookService.selectBookByName(name, type, pagination);
		pagination = bookService.count(name, type, pagination);
		map.addAttribute("books", list);
		map.addAttribute("pagination", pagination);
		map.addAttribute("searchName", name);
		map.addAttribute("searchType", type);
		return "book/book_list";
	}

	@RequestMapping(value = "/searchBookUserType")
	public String searchBookUserType(String type, ModelMap map) {
		Pagination pagination = new Pagination();
		pagination.setCurPage(1L);
		pagination.setPageSize(8L);
		List<Book> list = bookService.selectBookByName(null, type, pagination);
		pagination = bookService.count(null, type, pagination);
		map.addAttribute("books", list);
		map.addAttribute("pagination", pagination);
		map.addAttribute("searchName", "");
		map.addAttribute("searchType", type);
		return "book/book_list";
	}

	@RequestMapping(value = "/getBookInfo", method = RequestMethod.POST)
	@ResponseBody
	public Object getBookInfo(String id) {
		String content = BookInfoUtil.getBookInfo(id);
		content = content.replaceAll("\\\\n", "<br>");
		return content;
	}
}
