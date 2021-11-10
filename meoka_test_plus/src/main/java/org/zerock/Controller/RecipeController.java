package org.zerock.Controller;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.zerock.domain.Criteria;
import org.zerock.domain.IngredientVO;
import org.zerock.domain.PageMaker;
import org.zerock.domain.RecipeDetailVO;
import org.zerock.domain.RecipeRequest;
import org.zerock.domain.RecipeVO;
import org.zerock.domain.SearchCriteria;
import org.zerock.domain.UtensilVO;
import org.zerock.domain.ValuationVO;
import org.zerock.service.IngredientService;
import org.zerock.service.RecipeService;
import org.zerock.service.UtensilService;
import org.zerock.service.ValuationService;

@Controller
@RequestMapping("/recipe/*")
public class RecipeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Inject
	RecipeService service;
	
	@Inject
	ValuationService service2;
	
	@Inject
	UtensilService serviceUtensil;
	
	@Inject
	IngredientService serviceIngredient;

	// 게시물 목록
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public void getList(Model model) throws Exception {

		List<RecipeVO> list = null;
		list = service.list();
		System.out.println(list.toString());

		model.addAttribute("list", list);

	}

	// 게시물 작성
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public void getWrite() throws Exception {

	}

	// 게시물 작성
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String getWrite(RecipeRequest recipeRequest) throws Exception {

		// SELECT SEQ.NEXTVAL FROM DUAL
		// 1.RECIPEVO 객체 생성 setter로 recipeno 지정
		// 2.RECIPEDETAIL 객체 생성 (반복문)
		// 1,2 를 서비스로 전달

		// recipe 테이블에 입력

		int recipeno = service.write(recipeRequest);
		recipeRequest.setRECIPENO(recipeno);
		int i = 1;
		for (RecipeDetailVO rd : recipeRequest.getRecipeDetail()) {
		
			 rd.setRECIPENO(recipeno); rd.setRECIPEDETAILNO(i);
			 
			i++;
			service.writeRecipeDetail(rd);
		}
		
		i=1;
		for (UtensilVO rd : recipeRequest.getUtensil()) {
			rd.setRecipeNO(recipeno);
			rd.setUtensilNO(i);
			 //rd.setRECIPENO(recipeno); 
			 //rd.setRECIPEDETAILNO(i);
			 
			i++;
			//service.writeRecipeDetail(rd);
			serviceUtensil.writeUtensil(rd);
		}
		i=1;
		for (IngredientVO rd : recipeRequest.getIngredient()) {
			//rd.setRecipeNO(recipeno);
			//rd.setUtensilNO(i);
			 rd.setRecipeNo(recipeno);
			 rd.setIngredientNo(i);
			i++;
			//serviceUtensil.writeUtensil(rd);
			serviceIngredient.writeIngredient(rd);
		}

		// 입력한 데이터에 대한 recipeno를 찾아온다.

		// recipeno를 이용하여 세부정보(recipedetail 테이블)에 저장한다.
		System.out.println("***************************************************");
		System.out.println(recipeRequest);
		System.out.println("***************************************************");

		return "redirect:/recipe/list";
	}

	// 게시물 조회
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public void getView(@RequestParam("RECIPENO") int RECIPENO, Model model) throws Exception {

		RecipeVO vo = service.view(RECIPENO);
		model.addAttribute("view", vo);
		System.out.println("실행중입니다.");
		logger.info(model.toString());

		// 추가
		List<RecipeDetailVO> list = service.getRecipeDetailList(RECIPENO);
		model.addAttribute("RecipeVO", vo);
		model.addAttribute("list", list);
		
		//도구 추가
		List<UtensilVO> getUtensilList = serviceUtensil.getUtensilList(RECIPENO);
		model.addAttribute("RecipeVO", vo);
		model.addAttribute("getUtensilList",getUtensilList);
		System.out.println(getUtensilList);
		System.out.println("**************여기까지2222222");
		//재료추가
		List<IngredientVO> getIngredientList = serviceIngredient.getIngredientList(RECIPENO);
		model.addAttribute("RecipeVO", vo);
		model.addAttribute("getIngredientList",getIngredientList);
		System.out.println(getIngredientList);
		System.out.println("**************여기까지333333");
	}

	// 게시물 수정

	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public void getmodify(@RequestParam("RECIPENO") int RECIPENO, Model model) throws Exception {
		System.out.println(RECIPENO);
		RecipeVO vo = service.view(RECIPENO);

		model.addAttribute("view", vo);

		// 추가
		List<RecipeDetailVO> list = service.getRecipeDetailList(RECIPENO);
		System.out.println(list);
		System.out.println("실행중입니다.");
		model.addAttribute("RecipeVO", vo);
		model.addAttribute("list", list);
	}
	/*
	 * @RequestMapping(value = "/modify", method = RequestMethod.GET) public void
	 * getModify(@RequestParam("RECIPENO") int RECIPENO, Model model) throws
	 * Exception { System.out.println(RECIPENO); RecipeVO vo =
	 * service.view(RECIPENO); //List<RecipeDetailVO> vo2 =
	 * service.getRecipeDetailList(RECIPENO); model.addAttribute("view", vo);
	 * 
	 * for(RecipeDetailVO rd : ((RecipeRequest) vo2).getRecipeDetail()) {
	 * rd.setRECIPENO(recipeno); rd.setRECIPEDETAILNO(i); i++;
	 * service.deleteRecipeDetail(RECIPENO); service.writeRecipeDetail(rd);}
	 * List<RecipeDetailVO> list = service.getRecipeDetailList(RECIPENO);
	 * model.addAttribute("list", list); }
	 */

	
	  @RequestMapping(value = "/modify", method = RequestMethod.POST) public String
	  postModify(@RequestParam("RECIPENO") int RECIPENO, RecipeRequest recipeRequest) throws Exception {
		  System.out.println("*************recipeRequest: " + recipeRequest);
	  RecipeVO vo = service.view(RECIPENO);
	  int recipeno  = vo.getRECIPENO();
	  //int recipeno = service.write(recipeRequest);
	  System.out.println("===========");
	  System.out.println(recipeno);
	  recipeRequest.setRECIPENO(recipeno); 
	  //List<RecipeDetailVO> list = service.getRecipeDetailList(recipeno);
	  //ArrayList<RecipeDetailVO> rd = recipeRequest.getRecipeDetail();
	  
	  
	  serviceUtensil.deleteUtensil(recipeno);
	  serviceIngredient.deleteIngredient(recipeno);
	  service.deleteRecipeDetail(recipeno);
		int i=1;
		for (UtensilVO rd : recipeRequest.getUtensil()) {
			rd.setRecipeNO(recipeno);
			rd.setUtensilNO(i);
			i++;
			serviceUtensil.writeUtensil(rd);
		}
		 System.out.println("===========");
		  System.out.println("도구 수정 완료.");
		  
		 i=1;
		for (IngredientVO rd : recipeRequest.getIngredient()) {
		    rd.setIngredientNo(i);
			rd.setRecipeNo(recipeno);
			i++;
			serviceIngredient.writeIngredient(rd);
		}
		 System.out.println("===========");
		  System.out.println("재료 수정 완료.");
	  
	   i = 1; 
	  for (RecipeDetailVO rd : recipeRequest.getRecipeDetail()) {
		  rd.setRECIPENO(recipeno);
		  rd.setRECIPEDETAILNO(i);
	  i++; 
	  
	  service.writeRecipeDetail(rd); 
	  }
	  service.modify(recipeRequest);
	  
	  
	  return "redirect:/recipe/view?RECIPENO=" + recipeRequest.getRECIPENO(); }
	 

	// 게시물 삭제
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String getDelete(@RequestParam("RECIPENO") int recipeno,ValuationVO vo) throws Exception {
		
		System.out.println("recipeno******"+vo.getRecipeno());
		service2.deleteRecipeValuation(recipeno);
		System.out.println("후기 삭제 완료");
		serviceUtensil.deleteUtensil(recipeno);
		System.out.println("도구 삭제 완료");
	    serviceIngredient.deleteIngredient(recipeno);
	    System.out.println("재료 삭제 완료");
		service.deleteRecipeDetail(recipeno);
		System.out.println("세부 내용 삭제 완료 ******************");

		service.delete(recipeno);
		System.out.println("레시피 삭제 완료 *******************");

		return "redirect:/recipe/list";
	}

	/*
	 * //게시물 목록+페이징 추가
	 * 
	 * @RequestMapping(value = "/list", method = RequestMethod.GET) public void
	 * getListPage(Model model) throws Exception{
	 * 
	 * List<RecipeVO> list = null; list = service.list();
	 * 
	 * model.addAttribute("list", list);
	 * 
	 * }
	 */

	// 글 목록 + 페이징
	@RequestMapping(value = "/listPage", method = RequestMethod.GET)
	public void listPage(@ModelAttribute("cri") Criteria cri, Model model) throws Exception {
		logger.info("get list page");

		List<RecipeVO> list = service.listPage(cri);
		model.addAttribute("list", list);

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.listCount());
		model.addAttribute("pageMaker", pageMaker);

	}

	// 글 목록 + 페이징 + 검색
	@RequestMapping(value = "/listSearch", method = RequestMethod.GET)
	public void listPage(@ModelAttribute("scri") SearchCriteria scri, Model model) throws Exception {
		logger.info("get list search");

		List<RecipeVO> list = service.listSearch(scri);
		model.addAttribute("list", list);

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		// pageMaker.setTotalCount(service.listCount());
		pageMaker.setTotalCount(service.countSearch(scri));
		model.addAttribute("pageMaker", pageMaker);
	}

}
