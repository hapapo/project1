package org.zerock.persistence;

import java.util.List;

import org.zerock.domain.IngredientVO;
import org.zerock.domain.RecipeRequest;

public interface IngredientDAO {

	// 도구 작성
	public RecipeRequest recipeno(int recipeno) throws Exception;

	public void writeIngredient(IngredientVO rd) throws Exception;

	// 도구 조회
	public List<IngredientVO> getIngredientList(int recipeno) throws Exception;

	// 게시물 삭제
	public void deleteIngredient(int recipeno) throws Exception;
		
}
