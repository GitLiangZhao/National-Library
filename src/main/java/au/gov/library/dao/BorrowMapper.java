package au.gov.library.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import au.gov.library.model.Borrow;
import au.gov.library.model.BorrowClause;
import au.gov.library.model.BorrowKey;

public interface BorrowMapper {
    int countByExample(BorrowClause example);

    int deleteByExample(BorrowClause example);

    int deleteByPrimaryKey(BorrowKey key);

    int insert(Borrow record);

    int insertSelective(Borrow record);

    List<Borrow> selectByExample(BorrowClause example);

    Borrow selectByPrimaryKey(BorrowKey key);

    int updateByExampleSelective(@Param("record") Borrow record, @Param("example") BorrowClause example);

    int updateByExample(@Param("record") Borrow record, @Param("example") BorrowClause example);

    int updateByPrimaryKeySelective(Borrow record);

    int updateByPrimaryKey(Borrow record);
    
    List<Borrow> selectByPage(@Param("offset") Long offset, @Param("length")Long length);
    
    List<Borrow> selectByCardNumber(@Param("cardNumber") Long cardNumber, @Param("offset") Long offset, @Param("length")Long length);
    
    List<Borrow> selectByBookNumber(@Param("bookNumber") Long bookNumber, @Param("offset") Long offset, @Param("length")Long length);
}