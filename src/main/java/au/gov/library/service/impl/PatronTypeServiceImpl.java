package au.gov.library.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import au.gov.library.dao.PatronTypeMapper;
import au.gov.library.model.PatronType;
import au.gov.library.model.vo.PatrontypeVo;
import au.gov.library.model.vo.Pagination;
import au.gov.library.service.PatronTypeService;

@Service
public class PatronTypeServiceImpl implements PatronTypeService{
  
  @Autowired
  private PatronTypeMapper mapper;

  public void insertPatrontype(PatrontypeVo vo) {
    mapper.insert(vo);
  }

  public void updatePatrontype(PatrontypeVo vo) {
    mapper.updateByPrimaryKey(vo);
  }

  public PatronType selectPatrontype(String name) {
    return mapper.selectByPrimaryKey(name);
  }

  public List<PatronType> selectPatrontype(Pagination pagination) {
    long offset = (pagination.getCurPage()-1) * pagination.getPageSize();
    long length = pagination.getPageSize();
    
    return mapper.selectByPage(offset, length);
  }


  public void deletePatrontype(String type) {
    mapper.deleteByPrimaryKey(type);
    
  }

  public List<PatronType> selectPatrontype() {
    return mapper.selectByExample(null);
  }

}
