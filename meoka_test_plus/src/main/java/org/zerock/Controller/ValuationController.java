package org.zerock.Controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageMaker;
import org.zerock.domain.ValuationVO;
import org.zerock.service.ValuationService;

@RestController
@RequestMapping("/valuation")
public class ValuationController {
	@Inject
	private ValuationService service;

	@RequestMapping(value = "", method = RequestMethod.POST)
	public ResponseEntity<String> register(@RequestBody ValuationVO vo) {
		ResponseEntity<String> entity = null;

		System.out.println("*********************************");
		try {
			service.create(vo);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/all/{recipeno}", method = RequestMethod.GET)
	public ResponseEntity<List<ValuationVO>> list(@PathVariable("recipeno") Integer recipeno) {
		ResponseEntity<List<ValuationVO>> entity = null;
		try {
			entity = new ResponseEntity<>(service.list(recipeno), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/{recipeno}", method = { RequestMethod.PUT, RequestMethod.PATCH })
	public ResponseEntity<String> update(@PathVariable("bno") Integer bno, @RequestBody ValuationVO vo) {
		System.out.println("실행중입니다.");
		System.out.println(bno);
		ResponseEntity<String> entity = null;
		try {


			service.update(vo);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/delete", method = RequestMethod.DELETE)
	public ResponseEntity<String> remove(ValuationVO vo) {
		ResponseEntity<String> entity = null;
		System.out.println("***********"+vo);
/*
		System.out.println("**************"+recipeno);
		System.out.println("**************"+memberid);
		ValuationVO vo = new ValuationVO();
		vo.setMemberid(memberid);
		vo.setRecipeno(recipeno);
		*/
		try {			
			service.delete(vo);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/{recipeno}/{page}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listPage(@PathVariable("recipeno") Integer recipeno,
			@PathVariable("page") Integer page) {
		System.out.println("실행중입니다.");
		ResponseEntity<Map<String, Object>> entity = null;
		try {
			Criteria cri = new Criteria();
			cri.setPage(page);
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			Map<String, Object> map = new HashMap<String, Object>();
			List<ValuationVO> list = service.listPage(recipeno, cri);
			map.put("list", list);
			int ValCount = service.count(recipeno);
			pageMaker.setTotalCount(ValCount);
			map.put("pageMaker", pageMaker);
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
