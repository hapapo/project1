package org.zerock.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.zerock.domain.RecipeRequest;
import org.zerock.domain.UtensilVO;
import org.zerock.persistence.UtensilDAO;

@Service
public class UtensilServiceImpl implements UtensilService {

	@Inject
	private UtensilDAO dao;

	// 도구 작성
	public RecipeRequest recipeno(int recipeno) throws Exception {
		return dao.recipeno(recipeno);
	}

	public void writeUtensil(UtensilVO rd) throws Exception {
		dao.writeUtensil(rd);
	}

	
	// 도구 삭제
	public void deleteUtensil(int recipeno) throws Exception{
		dao.deleteUtensil(recipeno);
	}
	
	// 도구 수정
	public void modifyUtensil(UtensilVO vo) throws Exception{
		dao.modifyUtensil(vo);
	}
	
	// 도구 추가
	public List<UtensilVO> getUtensilList(int recipeno) throws Exception {
		return dao.getUtensilList(recipeno);

	}




}
