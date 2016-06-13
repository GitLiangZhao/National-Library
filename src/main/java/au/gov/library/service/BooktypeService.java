package au.gov.library.service;

import java.util.List;

import au.gov.library.model.BookType;
import au.gov.library.model.vo.BooktypeVo;
import au.gov.library.model.vo.Pagination;

public interface BooktypeService {
  void insertBooktype(BooktypeVo vo);
  
  void updateBooktype(BooktypeVo newBooktypeVo, BooktypeVo oldBooktypeVo);
  
  BookType selectBooktypeByName(String name);
  
  List<BookType> selectBooktype(Pagination pagination);
  
  List<BookType> selectBooktype();
    
  void deleteBooktype(String name);
}
