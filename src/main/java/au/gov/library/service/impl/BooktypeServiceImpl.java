package au.gov.library.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import au.gov.library.dao.BookTypeMapper;
import au.gov.library.model.BookType;
import au.gov.library.model.BookTypeClause;
import au.gov.library.model.vo.BooktypeVo;
import au.gov.library.model.vo.Pagination;
import au.gov.library.service.BooktypeService;

@Service
public class BooktypeServiceImpl implements BooktypeService{

  @Autowired
  private BookTypeMapper booktypeMapper;
  
  public void insertBooktype(BooktypeVo vo) {
    booktypeMapper.insert(vo);
    
  }

  public void updateBooktype(BooktypeVo newBooktypeVo, BooktypeVo oldBooktypeVo) {
    BookTypeClause example = new BookTypeClause();
    example.or().andTypeEqualTo(oldBooktypeVo.getType());
    booktypeMapper.updateByExample(newBooktypeVo, example);
    
  }

  public BookType selectBooktypeByName(String name) {
    return booktypeMapper.selectByPrimaryKey(name);
  }

  public List<BookType> selectBooktype(Pagination pagination) {
    long offset = (pagination.getCurPage()-1) * pagination.getPageSize();
    long length = pagination.getPageSize();
    return booktypeMapper.selectByPage(offset, length);
  }

  public List<BookType> selectBooktype() {
    return booktypeMapper.selectByExample(null);
  }

  public void deleteBooktype(String name) {
    booktypeMapper.deleteByPrimaryKey(name);
  }

}
