package au.gov.library.service;

import java.util.List;

import au.gov.library.model.PatronType;
import au.gov.library.model.vo.PatrontypeVo;
import au.gov.library.model.vo.Pagination;

public interface PatronTypeService {
  void insertPatrontype(PatrontypeVo vo);
  
  void updatePatrontype(PatrontypeVo vo);
  
  PatronType selectPatrontype(String name);
  
  List<PatronType> selectPatrontype(Pagination pagination);
  
  List<PatronType> selectPatrontype();
  
  void deletePatrontype(String type);
}
