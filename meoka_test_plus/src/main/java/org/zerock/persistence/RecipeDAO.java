package org.zerock.persistence;

import java.util.List;

import org.zerock.domain.Criteria;
import org.zerock.domain.RecipeDetailVO;
import org.zerock.domain.RecipeRequest;
import org.zerock.domain.RecipeVO;
import org.zerock.domain.SearchCriteria;

public interface RecipeDAO {

	public List<RecipeVO> list() throws Exception;

	// 레시피 작성
	public int write(RecipeRequest recipeRequest) throws Exception;

	// 레시피 디테일 작성
	public RecipeRequest recipeno(int recipeno) throws Exception;

	public void writeRecipeDetail(RecipeDetailVO rd) throws Exception;

	// 게시물 조회
	public RecipeVO view(int recipeno) throws Exception;

	public void modify(RecipeRequest recipeRequest) throws Exception;

	// 조회 추가
	public List<RecipeDetailVO> getRecipeDetailList(int recipeno) throws Exception;

	// 게시물 삭제
	public void delete(int recipeno) throws Exception;
	// 레시피 세부내용
	public void deleteRecipeDetail(int recipeno) throws Exception;

	// 게시물 총 갯수
	public int count() throws Exception;

	// 게시물 목록 + 페이징
	public List<RecipeVO> listPage(Criteria cri) throws Exception;

	public int listCount() throws Exception;

	// 목록+페이징+검색
	public List<RecipeVO> listSearch(SearchCriteria scri) throws Exception;

	// 게시물 검색
	public int countSearch(SearchCriteria scri) throws Exception;

}
