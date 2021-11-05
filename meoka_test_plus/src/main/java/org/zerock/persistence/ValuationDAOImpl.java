package org.zerock.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.zerock.domain.Criteria;
import org.zerock.domain.ValuationVO;

@Repository
public class ValuationDAOImpl implements ValuationDAO {
	
	@Inject
	private SqlSession session;
	private static String namespace = "org.zerock.mapper.ValuationMapper";
	@Override
	public List<ValuationVO> list(Integer recipeno) throws Exception {
	return session.selectList(namespace + ".list", recipeno);
	}
	@Override
	public void create(ValuationVO vo) throws Exception {
	session.insert(namespace + ".create", vo);
	}
	@Override
	public void update(ValuationVO vo) throws Exception {
	session.update(namespace + ".update", vo);
	}
	@Override
	public void delete(ValuationVO vo) throws Exception {
	session.delete(namespace + ".delete", vo);
	}
	@Override
	public List<ValuationVO> listPage(Integer recipeno, Criteria cri)
	throws Exception {
	System.out.println("/* rowStart="+cri.getRowStart());
	System.out.println("/* rowEnd="+cri.getRowEnd());
	Map<String, Object> paramMap = new HashMap<>();
	//paramMap.put("recipeno", recipeno);
	paramMap.put("cri", cri);
	return session.selectList(namespace + ".listPage", paramMap);
	}
	@Override
	public int count(Integer recipeno) throws Exception {
	return session.selectOne(namespace + ".count", recipeno);
	}

}
