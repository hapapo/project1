package org.zerock.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.zerock.domain.Criteria;
import org.zerock.domain.RecipeDetailVO;
import org.zerock.domain.RecipeRequest;
import org.zerock.domain.RecipeVO;
import org.zerock.domain.SearchCriteria;
import org.zerock.persistence.RecipeDAO;

@Service
public class RecipeServiceImpl implements RecipeService {

	@Inject
	private RecipeDAO dao;

	@Override
	public List<RecipeVO> list() throws Exception {

		return dao.list();

	}

	// 레시피 작성
	@Override
	public int write(RecipeRequest recipeRequest) throws Exception {
		return dao.write(recipeRequest);
	}

	// 레시피 디테일 작성
	public RecipeRequest recipeno(int recipeno) throws Exception {
		return dao.recipeno(recipeno);
	}

	public void writeRecipeDetail(RecipeDetailVO rd) throws Exception {
		dao.writeRecipeDetail(rd);
	}

	// 게시물 조회
	@Override
	public RecipeVO view(int RECIPENO) throws Exception {

		return dao.view(RECIPENO);
	}

	// 게시물 수정
	@Override
	public void modify(RecipeRequest recipeRequest) throws Exception {

		dao.modify(recipeRequest);
	}

	// 게시물 삭제
	public void delete(int recipeno) throws Exception {
		dao.delete(recipeno);
	}

	// 레시피 세부내용
	public void deleteRecipeDetail(int recipeno) throws Exception{
		dao.deleteRecipeDetail(recipeno);
	}
	
	// 게시물 총 갯수
	@Override
	public int count() throws Exception {
		return dao.count();
	}

	// 게시물 목록 + 페이징
	@Override
	public List<RecipeVO> listPage(Criteria cri) throws Exception {
		return dao.listPage(cri);
	}

	public int listCount() throws Exception {
		return dao.listCount();

	}

	// 목록+페이징+검색
	public List<RecipeVO> listSearch(SearchCriteria scri) throws Exception {
		return dao.listSearch(scri);
	}

	// 게시물 검색
	public int countSearch(SearchCriteria scri) throws Exception {
		return dao.countSearch(scri);
	}

	// 조회 추가
	public List<RecipeDetailVO> getRecipeDetailList(int recipeno) throws Exception {
		return dao.getRecipeDetailList(recipeno);

	}

}
