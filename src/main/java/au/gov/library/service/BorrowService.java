package au.gov.library.service;

import java.util.List;

import au.gov.library.exception.BookException;
import au.gov.library.model.Borrow;
import au.gov.library.model.BorrowKey;
import au.gov.library.model.vo.BorrowVo;
import au.gov.library.model.vo.Pagination;

public interface BorrowService {
  void borrowBook(BorrowVo borrow) throws BookException;
  
  Borrow returnBook(BorrowKey key);
  
  void deletBorrowRecord(BorrowKey key);
  
  List<Borrow> selectBorrowRecord(Pagination pagination);
  
  List<Borrow> selectBorrowByCardNumber(Long cardNumber, Pagination pagination);
  
  List<Borrow> selectBorrowByBookNumber(Long bookNumber, Pagination pagination);
  
  List<Borrow> selectBorrowRecordByKey(BorrowKey key, Pagination pagination);
  
  Pagination countByKey(BorrowKey key, Pagination pagination);
}
