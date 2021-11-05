package org.zerock.domain;

import java.util.ArrayList;
import java.util.Date;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Data
@Getter
@Setter
@ToString
public class RecipeRequest {
	//recipe	
	private Integer RECIPENO;
	private String MEMBERID;
	private Integer FOODNO;
	private String RECIPENAME;
	private Date REGDATE;
	private String COOKINGTIME;
	private String PORTION;
	private int RANKNO;
	
	ArrayList<RecipeDetailVO> recipeDetail;
	
	/*	private Integer recipeNo;
	private Integer recipeDetailNo;
	private String recipeDetail;
	private String photo;*/
	//key recipeDetail : value list
}
