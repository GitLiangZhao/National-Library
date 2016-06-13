package au.gov.library.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import au.gov.library.model.PatronType;
import au.gov.library.model.PatronTypeClause;

public interface PatronTypeMapper {
    int countByExample(PatronTypeClause example);

    int deleteByExample(PatronTypeClause example);

    int deleteByPrimaryKey(String type);

    int insert(PatronType record);

    int insertSelective(PatronType record);

    List<PatronType> selectByExample(PatronTypeClause example);

    PatronType selectByPrimaryKey(String type);

    int updateByExampleSelective(@Param("record") PatronType record, @Param("example") PatronTypeClause example);

    int updateByExample(@Param("record") PatronType record, @Param("example") PatronTypeClause example);

    int updateByPrimaryKeySelective(PatronType record);

    int updateByPrimaryKey(PatronType record);
    
    List<PatronType> selectByPage(@Param("offset")Long offset, @Param("length")Long lenght);
}