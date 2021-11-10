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

	// 재료 작성
	public RecipeRequest recipeno(int recipeno) throws Exception {
		return sql.selectOne(namespace + ".recipeno", recipeno);
	}
	
	public void writeIngredient(IngredientVO rd) throws Exception {
		sql.insert(namespace + ".writeIngredient", rd);
	}

	// 재료 삭제
	public void deleteIngredient(int recipeno) throws Exception{
		sql.delete(namespace+".deleteIngredient", recipeno);
	}
	
	// 재료 수정
	public void modifyIngredient(IngredientVO vo) throws Exception{
		sql.update(namespace+".modifyIngredient");
	}

	@Override
	public List<IngredientVO> getIngredientList(int recipeno) throws Exception {
		return sql.selectList(namespace + ".listIngredient", recipeno);
	}
}
