package au.gov.library.service.impl;

import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import au.gov.library.dao.BookMapper;
import au.gov.library.model.Book;
import au.gov.library.model.BookClause;
import au.gov.library.model.BookClause.Criteria;
import au.gov.library.model.vo.BookVo;
import au.gov.library.model.vo.Pagination;
import au.gov.library.service.BookService;

@Service
public class BookServiceImpl implements BookService {

	@Autowired
	private BookMapper bookMapper;

	public void insertBook(BookVo vo) {
		// price
		String price = "";
		for (int i = 0; i < vo.getPriceVo().length(); i++) {
			if (vo.getPriceVo().charAt(i) == '.') {
				break;
			} else {
				price += vo.getPriceVo().charAt(i);
			}
		}
		// Publish Date
		String[] time = vo.getPubdate().split("-");
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.YEAR, Integer.parseInt(time[0]));
		calendar.set(Calendar.MONTH, Integer.parseInt(time[1]));
		vo.setPrice(price);
		vo.setStoreDate(Calendar.getInstance().getTime());
		vo.setPublishDate(calendar.getTime());
		vo.setBorrowedNumber(0);
		bookMapper.insert(vo);

	}

	public List<Book> selectBookByName(String name, String type, Pagination pagination) {
		long offset = (pagination.getCurPage() - 1) * pagination.getPageSize();
		long length = pagination.getPageSize();
		BookClause example = new BookClause();
		Criteria criteria = new BookClause().createCriteria();
		if (!StringUtils.isEmpty(name)) {
			criteria.andBookNameLike("%" + name + "%");
		}
		if (!StringUtils.isEmpty(type))
			criteria.andBookTypeEqualTo(type);
		example.or(criteria);
		example.setOffset(offset);
		example.setLength(length);
		List<Book> books = bookMapper.selectByExample(example);

		return books;
	}

	public void updateBook(BookVo vo, Long bookNum) {
		// price
		String price = "";
		for (int i = 0; i < vo.getPriceVo().length(); i++) {
			if (vo.getPriceVo().charAt(i) == '.') {
				break;
			} else {
				price += vo.getPriceVo().charAt(i);
			}
		}
		// Publish Date
		String[] time = vo.getPubdate().split("-");
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.YEAR, Integer.parseInt(time[0]));
		calendar.set(Calendar.MONTH, Integer.parseInt(time[1]));
		vo.setPrice(price);
		vo.setPublishDate(calendar.getTime());
		BookClause bookExample = new BookClause();
		bookExample.or().andBookNumberEqualTo(bookNum);
		bookMapper.updateByExample(vo, bookExample);
	}

	public void deleteBookByBookNumber(long num) {
		BookClause bookExample = new BookClause();
		bookExample.or().andBookNumberEqualTo(num);
		bookMapper.deleteByExample(bookExample);

	}

	public Book selectBookByBookNumber(long num) {
		return bookMapper.selectByPrimaryKey(num);
	}

	public int countByName(String bookName) {
		return bookMapper.count(bookName);
	}

	public Pagination count(String name, String type, Pagination pagination) {
		BookClause example = new BookClause();
		Criteria criteria = example.createCriteria();
		if (!StringUtils.isEmpty(name)) {
			criteria.andBookNameLike("%" + name + "%");
		}
		if (!StringUtils.isEmpty(type))
			criteria.andBookTypeEqualTo(type);
		example.or(criteria);
		int num = bookMapper.countByExample(example);
		pagination.setItems(num);
		long a = pagination.getItems() % pagination.getPageSize();
		long b = pagination.getItems() / pagination.getPageSize();
		if (a == 0) {
			pagination.setPageNumber(b);
		} else {
			pagination.setPageNumber(b + 1);
		}
		return pagination;
	}

	public Book selectBook(long num, String type) {
		BookClause example = new BookClause();
		example.or().andBookNumberEqualTo(num);
		if (!StringUtils.isEmpty(type))
			example.or().andBookTypeEqualTo(type);
		List<Book> books = bookMapper.selectByExample(example);
		if (books.size() > 0)
			return books.get(0);
		else
			return null;
	}

	public List<Book> selectNewBooks(int num) {
		BookClause example = new BookClause();
		example.setOffset(0);
		example.setLength(num);
		example.setOrderByClause("store_date DESC");
		List<Book> list = bookMapper.selectByExample(example);
		return list;
	}

}
