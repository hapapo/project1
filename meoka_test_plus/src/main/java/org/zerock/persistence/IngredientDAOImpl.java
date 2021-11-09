package org.zerock.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.zerock.domain.IngredientVO;
import org.zerock.domain.RecipeRequest;

@Repository
public class IngredientDAOImpl implements IngredientDAO {

	@Inject
	private SqlSession sql;

	private static String namespace = "org.zerock.mappers.ToolMapper";

	// 레시피 디테일 작성
	public RecipeRequest recipeno(int recipeno) throws Exception {
		return sql.selectOne(namespace + ".recipeno", recipeno);
	}
	
	public void writeIngredient(IngredientVO rd) throws Exception {
		sql.insert(namespace + ".writeIngredient", rd);
	}

	// 레시피 세부내용 삭제
	public void deleteIngredient(int recipeno) throws Exception{
		sql.delete(namespace+".deleteIngredient", recipeno);
	}

	@Override
	public List<IngredientVO> getIngredientList(int recipeno) throws Exception {
		return sql.selectList(namespace + ".listIngredient", recipeno);
	}
}
