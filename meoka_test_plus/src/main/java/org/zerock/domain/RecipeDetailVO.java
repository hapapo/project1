package org.zerock.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Data
@ToString
public class RecipeDetailVO {
	private Integer RECIPENO;
	private Integer RECIPEDETAILNO;
	private String RECIPEDETAIL;
	private String PHOTO;
}