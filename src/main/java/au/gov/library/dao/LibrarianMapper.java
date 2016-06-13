package au.gov.library.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import au.gov.library.model.Librarian;
import au.gov.library.model.LibrarianClause;

public interface LibrarianMapper {

	int deleteByExample(LibrarianClause example);

	int insert(Librarian record);

	List<Librarian> selectByExample(LibrarianClause example);

	List<Librarian> selectByPage(@Param("offset") long offset, @Param("length") long length);
}