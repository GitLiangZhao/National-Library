package au.gov.library.service;

import java.util.List;

import au.gov.library.model.Patron;
import au.gov.library.model.vo.PatronVo;
import au.gov.library.model.vo.Pagination;

public interface PatronService {
  /**
   * Add
   */
  public void insertPatron(PatronVo vo);
  
  /**
   * Update
   * @param vo
   */
  public void updatePatron(PatronVo vo);
  
  /**
   * Delete
   * @param vo
   */
  public void deletePatron(Long cardNumber);
  
  /**
   * 使用借阅卡号查找借阅者
   * @param cardNumber
   * @return
   */
  public Patron selectPatronByCardNumber(Long cardNumber, String type);
  
  /**
   * 使用姓名查找借阅者
   * @param name
   * @param pagination
   * @return
   */
  public List<Patron> selectPatronByName(String name, Pagination pagination);
  
  /**
   * 查找全部借阅者
   * @param pagination
   * @return
   */
  public List<Patron> selectPatrons(Pagination pagination);
  
  public Pagination count(Pagination pagination);
  
  public Long getNewCardNumber();
  
  public Patron selectPatronByCardNumber(long patronNumber);
    

}
