package au.gov.library.service.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import au.gov.library.dao.BookMapper;
import au.gov.library.dao.BookTypeMapper;
import au.gov.library.dao.BorrowMapper;
import au.gov.library.dao.PatronMapper;
import au.gov.library.dao.PatronTypeMapper;
import au.gov.library.exception.BookException;
import au.gov.library.model.Book;
import au.gov.library.model.BookType;
import au.gov.library.model.Borrow;
import au.gov.library.model.BorrowClause;
import au.gov.library.model.BorrowKey;
import au.gov.library.model.Patron;
import au.gov.library.model.PatronType;
import au.gov.library.model.vo.BorrowVo;
import au.gov.library.model.vo.Pagination;
import au.gov.library.service.BorrowService;

@Service
public class BorrowServiceImpl implements BorrowService{
  
  @Autowired
  private BorrowMapper mapper;
  
  @Autowired
  private BookMapper bookMapper;
  
  @Autowired 
  private PatronMapper patronMapper;
  
  @Autowired
  private PatronTypeMapper patrontypeMapper;
  
  @Autowired
  private BookTypeMapper booktypeMapper;

  public void borrowBook(BorrowVo borrow) throws BookException {
    // Judge the book can be borrowed
    Book book = bookMapper.selectByPrimaryKey(borrow.getBookNumber());
    if (book.getNumber() == book.getBorrowedNumber())
      throw new BookException("Book already borrowed");
    // judge the number of borrowers who have borrowed
    Patron patron = patronMapper.selectByPrimaryKey(borrow.getPatronNumber());
    PatronType patrontype = patrontypeMapper.selectByPrimaryKey(patron.getType());
    if (patron.getBorrowed() == patrontype.getBorrowNumber())
      throw new BookException("Limited borrowed for patron");
   
    
    // add borrow record
    patron.setBorrowed(patron.getBorrowed()+1);
    patronMapper.updateByPrimaryKey(patron);
    book.setBorrowedNumber(book.getBorrowedNumber()+1);
    bookMapper.updateByPrimaryKey(book);
    mapper.insert(borrow);
    
  }

  public Borrow returnBook(BorrowKey key) {
    Borrow borrow = mapper.selectByPrimaryKey(key);
    if (borrow == null) {
      return null;
    }
    Book book = bookMapper.selectByPrimaryKey(key.getBookNumber());
    Patron patron = patronMapper.selectByPrimaryKey(key.getPatronNumber());
    book.setBorrowedNumber(book.getBorrowedNumber()-1);
    patron.setBorrowed(patron.getBorrowed()-1);
    bookMapper.updateByPrimaryKey(book);
    patronMapper.updateByPrimaryKey(patron);
    
    // add return date
    
    Date returnDate = Calendar.getInstance().getTime();
    borrow.setReturnDate(returnDate);
    BookType booktype = booktypeMapper.selectByPrimaryKey(book.getBookType());
    int canBorrowDay = booktype.getBorrowDay();     // allow date
    Date borrowDate = borrow.getBorrowedDate();
    // Calculate the number of lending and return days
    long day = (returnDate.getTime() - borrowDate.getTime()) / 1000 / 3600 / 24;
    // To judge whether or not to need a fine
    if (day > canBorrowDay)
      borrow.setFine(booktype.getDayFine() *(day-canBorrowDay));
    else 
      borrow.setFine(0L);
    mapper.updateByPrimaryKey(borrow);
    return borrow;
  }

  public void deletBorrowRecord(BorrowKey key) {
    mapper.deleteByPrimaryKey(key);
    
  }

  public List<Borrow> selectBorrowRecord(Pagination pagination) {
    long offset = (pagination.getCurPage()-1) * pagination.getPageSize();
    long length = pagination.getPageSize();
    return mapper.selectByPage(offset, length);
  }

  public List<Borrow> selectBorrowRecordByKey(BorrowKey key, Pagination pagination) {
    List<Borrow> result = new ArrayList<Borrow>();
    if (key.getBookNumber() != null && key.getPatronNumber() != null) {
      Borrow record = mapper.selectByPrimaryKey(key);
      result.add(record);
    } else if(key.getBookNumber() != null){
      result = selectBorrowByBookNumber(key.getBookNumber(), pagination);
    } else if(key.getPatronNumber() != null) {
      result = selectBorrowByCardNumber(key.getPatronNumber(), pagination);
    } else {
      result = selectBorrowRecord(pagination);
    }
    return result;
  }

  public List<Borrow> selectBorrowByCardNumber(Long cardNumber, Pagination pagination) {
    BorrowClause example = new BorrowClause();
    example.or().andPatronNumberEqualTo(cardNumber);
    example.setOffset((pagination.getCurPage()-1) * pagination.getPageSize());
    example.setLength(pagination.getPageSize());
    return mapper.selectByExample(example);
  }

  public List<Borrow> selectBorrowByBookNumber(Long bookNumber, Pagination pagination) {
    BorrowClause example = new BorrowClause();
    example.or().andBookNumberEqualTo(bookNumber);
    example.setOffset((pagination.getCurPage()-1) * pagination.getPageSize());
    example.setLength(pagination.getPageSize());

    return mapper.selectByExample(example);
  }

  public Pagination countByKey(BorrowKey key, Pagination pagination) {
    BorrowClause example = new BorrowClause();
    if (key.getBookNumber() != null)
      example.or().andBookNumberEqualTo(key.getBookNumber());
    if (key.getPatronNumber() != null)
      example.or().andPatronNumberEqualTo(key.getPatronNumber());
    int nums =  mapper.countByExample(example);
    Pagination page = new Pagination();
    page.setCurPage(pagination.getCurPage());
    page.setPageSize(pagination.getPageSize());
    page.setItems(nums);
    if (nums % page.getPageSize() == 0) {
      page.setPageNumber(nums / page.getPageSize());
    } else {
      page.setPageNumber(nums / page.getPageSize()+1);
    }
    return page;
  }
  

}
