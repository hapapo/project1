package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class RecipeVO {

	private Integer RECIPENO;
	private String MEMBERID;
	private Integer FOODNO;
	private String RECIPENAME;
	private Date REGDATE;
	private String COOKINGTIME;
	private String PORTION;
	private int RANKNO;
	
}
