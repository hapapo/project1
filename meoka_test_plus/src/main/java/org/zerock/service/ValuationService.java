package org.zerock.service;

import java.util.List;

import org.zerock.domain.Criteria;
import org.zerock.domain.ValuationVO;

public interface ValuationService {

	public void create(ValuationVO vo) throws Exception;
	public List<ValuationVO> list(Integer recipeno) throws Exception;
	public void update(ValuationVO vo) throws Exception;
	public void delete(ValuationVO vo) throws Exception;
	public List<ValuationVO> listPage(Integer recipeno, Criteria cri)
	throws Exception;
	public int count(Integer recipeno) throws Exception;
}
