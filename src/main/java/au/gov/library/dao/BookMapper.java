package au.gov.library.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import au.gov.library.model.Book;
import au.gov.library.model.BookClause;

public interface BookMapper {
    int countByExample(BookClause example);

    int deleteByExample(BookClause example);

    int deleteByPrimaryKey(Long bookNumber);

    int insert(Book record);

    int insertSelective(Book record);

    List<Book> selectByExample(BookClause example);

    Book selectByPrimaryKey(Long bookNumber);

    int updateByExampleSelective(@Param("record") Book record, @Param("example") BookClause example);

    int updateByExample(@Param("record") Book record, @Param("example") BookClause example);

    int updateByPrimaryKeySelective(Book record);

    int updateByPrimaryKey(Book record);
    
    List<Book> selectByName(@Param("bookName") String bookName, @Param("offset") Long offset, @Param("length")Long length, @Param("orderBy")String orderBy);
    
    int count(@Param("bookName")String bookName);
}