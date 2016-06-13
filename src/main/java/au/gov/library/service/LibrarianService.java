package au.gov.library.service;

import java.util.List;

import au.gov.library.model.Librarian;
import au.gov.library.model.vo.Pagination;
import au.gov.library.model.vo.LibrarianVo;

public interface LibrarianService {
  /**
   * Add Librarian
   * @param user
   */
  public void insertUser(LibrarianVo user);
   
  public List<Librarian> selectUsers(Pagination pagination);
  
  public void deleteUser(String username);
  
  public Librarian login(LibrarianVo user);
}
