package org.zerock.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.zerock.domain.IngredientVO;
import org.zerock.domain.RecipeRequest;
import org.zerock.persistence.IngredientDAO;

@Service
public class IngredientServiceImpl implements IngredientService {

	@Inject
	private IngredientDAO dao;

	// 재료 작성
	public RecipeRequest recipeno(int recipeno) throws Exception {
		return dao.recipeno(recipeno);
	}

	public void writeIngredient(IngredientVO rd) throws Exception {
		dao.writeIngredient(rd);
	}



	// 재료 삭제
	public void deleteIngredient(int recipeno) throws Exception{
		dao.deleteIngredient(recipeno);
	}
	
	// 재료 수정
	public void modifyIngredient(IngredientVO vo) throws Exception{
		dao.modifyIngredient(vo);
	}

	// 재료 추가
	public List<IngredientVO> getIngredientList(int recipeno) throws Exception {
		return dao.getIngredientList(recipeno);

	}







}
