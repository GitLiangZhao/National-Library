package au.gov.library.service;

import java.util.List;

import au.gov.library.model.Book;
import au.gov.library.model.vo.BookVo;
import au.gov.library.model.vo.Pagination;

public interface BookService {
  
  public void insertBook(BookVo vo);
  
  public List<Book> selectBookByName(String name, String type, Pagination pagination);
  
  public void updateBook(BookVo vo, Long bookNum);
  
  public void deleteBookByBookNumber(long num);
  
  public Book selectBookByBookNumber(long num);
  
  public int countByName(String bookName);
  
  public Pagination count(String name, String type, Pagination pagination);
  
  /**
   * According to the number and type of search books
   * @param num
   * @param type
   * @return
   */
  public Book selectBook(long num, String type);
  
  public List<Book> selectNewBooks(int num);
}
