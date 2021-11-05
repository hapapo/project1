package org.zerock.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.zerock.domain.Criteria;
import org.zerock.domain.ValuationVO;
import org.zerock.persistence.ValuationDAO;

@Service
public class ValuationServiceImpl implements ValuationService {
	
	@Inject
	private ValuationDAO dao;
	
	@Override
	public void create(ValuationVO vo) throws Exception {
	dao.create(vo);
	}
	@Override
	public List<ValuationVO> list(Integer recipeno) throws Exception {
	return dao.list(recipeno);
	}
	@Override
	public void update(ValuationVO vo) throws Exception {
	dao.update(vo);
	}
	@Override
	public void delete(ValuationVO vo) throws Exception {
	dao.delete(vo);
	}
	@Override
	public List<ValuationVO> listPage(Integer recipeno, Criteria cri)throws Exception {
	return dao.listPage(recipeno, cri);
	}
	@Override
	public int count(Integer recipeno) throws Exception {
	return dao.count(recipeno);
	}
	

}
