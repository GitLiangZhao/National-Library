package au.gov.library.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import au.gov.library.dao.PatronMapper;
import au.gov.library.model.Patron;
import au.gov.library.model.PatronClause;
import au.gov.library.model.PatronClause.Criteria;
import au.gov.library.model.vo.PatronVo;
import au.gov.library.model.vo.Pagination;
import au.gov.library.service.PatronService;

@Service
public class PatronServiceImpl implements PatronService {

	@Autowired
	private PatronMapper patronMapper;

	public void insertPatron(PatronVo vo) {
		patronMapper.insert(vo);

	}

	public void updatePatron(PatronVo vo) {
		patronMapper.updateByPrimaryKey(vo);

	}

	public void deletePatron(Long cardNumber) {
		patronMapper.deleteByPrimaryKey(cardNumber);

	}

	public Patron selectPatronByCardNumber(Long cardNumber, String type) {
		PatronClause example = new PatronClause();
		example.or().andCardNumberEqualTo(cardNumber).andTypeEqualTo(type);
		List<Patron> patrons = patronMapper.selectByExample(example);
		if (patrons.size() > 0)
			return patrons.get(0);
		else
			return null;
	}

	public List<Patron> selectPatronByName(String name, Pagination pagination) {
		long offset = (pagination.getCurPage() - 1) * pagination.getPageSize();
		long length = pagination.getPageSize();

		return patronMapper.selectByName(name, offset, length);
	}

	public List<Patron> selectPatrons(Pagination pagination) {
		long offset = (pagination.getCurPage() - 1) * pagination.getPageSize();
		long length = pagination.getPageSize();
		PatronClause clause = new PatronClause();
		Criteria criteria = new PatronClause().createCriteria();
		clause.or(criteria);
		clause.setOffset(offset);
		clause.setLength(length);
		List<Patron> patrons = patronMapper.selectByExample(clause);
		return patrons;
	}

	public Pagination count(Pagination pagination) {
		PatronClause clause = new PatronClause();
		Criteria criteria = new PatronClause().createCriteria();
		clause.or(criteria);
		int num = patronMapper.countByExample(clause);
		pagination.setItems(num);
		long a = pagination.getItems() % pagination.getPageSize();
		long b = pagination.getItems() / pagination.getPageSize();
		if (a == 0) {
			pagination.setPageNumber(b);
		} else {
			pagination.setPageNumber(b + 1);
		}
		return pagination;
	}

	public Long getNewCardNumber() {
		Long lastCardNumber = patronMapper.getLastCardNumber();
		if (lastCardNumber == null)
			return 1L;
		else
			return lastCardNumber + 1;
	}

	public Patron selectPatronByCardNumber(long patronNumber) {
		return patronMapper.selectByPrimaryKey(patronNumber);
	}

}
