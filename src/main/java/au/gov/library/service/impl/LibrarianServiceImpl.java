package au.gov.library.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import au.gov.library.dao.LibrarianMapper;
import au.gov.library.model.Librarian;
import au.gov.library.model.LibrarianClause;
import au.gov.library.model.vo.Pagination;
import au.gov.library.model.vo.LibrarianVo;
import au.gov.library.service.LibrarianService;

@Service
public class LibrarianServiceImpl implements LibrarianService {

  @Autowired
  private LibrarianMapper userMapper;
  
  public void insertUser(LibrarianVo user) {
    userMapper.insert(user);
  }

  public void deleteUser(String name) {
    LibrarianClause userExample = new LibrarianClause();
    userExample.or().andUsernameEqualTo(name);
    userMapper.deleteByExample(userExample);
  }

  public List<Librarian> selectUsers(Pagination pagination) {
    return userMapper.selectByExample(null);
    
  }

  public Librarian login(LibrarianVo user) {
    LibrarianClause example = new LibrarianClause();
    example.or().andUsernameEqualTo(user.getUsername()).andPasswordEqualTo(user.getPassword());
    List<Librarian> records = userMapper.selectByExample(example);
    if (records.size() > 0 )
      return records.get(0);
    else
      return null;
  }

}
