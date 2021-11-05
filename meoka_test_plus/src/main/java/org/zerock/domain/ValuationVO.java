package org.zerock.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ValuationVO {
		private Integer recipeno;
		private String memberid;
		private int point;
		private String comments;
		private Date regDate;
}
