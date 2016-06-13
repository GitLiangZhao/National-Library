package au.gov.library.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import au.gov.library.model.BookType;
import au.gov.library.model.BookTypeClause;

public interface BookTypeMapper {
    int countByExample(BookTypeClause example);

    int deleteByExample(BookTypeClause example);

    int deleteByPrimaryKey(String type);

    int insert(BookType record);

    int insertSelective(BookType record);

    List<BookType> selectByExample(BookTypeClause example);

    BookType selectByPrimaryKey(String type);

    int updateByExampleSelective(@Param("record") BookType record, @Param("example") BookTypeClause example);

    int updateByExample(@Param("record") BookType record, @Param("example") BookTypeClause example);

    int updateByPrimaryKeySelective(BookType record);

    int updateByPrimaryKey(BookType record);
    
    List<BookType> selectByPage(@Param("offset") Long offset, @Param("length")Long length);
}