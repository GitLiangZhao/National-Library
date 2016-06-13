package au.gov.library.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import au.gov.library.model.Patron;
import au.gov.library.model.PatronClause;

public interface PatronMapper {
    int countByExample(PatronClause example);

    int deleteByExample(PatronClause example);

    int deleteByPrimaryKey(Long cardNumber);

    int insert(Patron record);

    int insertSelective(Patron record);

    List<Patron> selectByExample(PatronClause example);

    Patron selectByPrimaryKey(Long cardNumber);

    int updateByExampleSelective(@Param("record") Patron record, @Param("example") PatronClause example);

    int updateByExample(@Param("record") Patron record, @Param("example") PatronClause example);

    int updateByPrimaryKeySelective(Patron record);

    int updateByPrimaryKey(Patron record);
    
    List<Patron> selectByName(@Param("name")String name, @Param("offset")Long offset, @Param("length")Long length);
    
    Long getLastCardNumber();
}