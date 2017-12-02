package com.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.commons.Page;
import com.entity.Order;
import com.mapper.OrderMapper;

/**
 * 获得每页的服务
 * @author admin
 *
 */
@Service
public class PageService {

	@Autowired
	private OrderMapper orderMapper;
	
	public Page getPageData(String pageNum, String pageSize){
		int totalRecords = orderMapper.totalOrderNum();
		int middlePageSize = Integer.valueOf(pageSize);
		int middlePageNum = 1;
		if(pageNum != null){
			middlePageNum = Integer.valueOf(pageNum);
		}
		int pageIndex = (middlePageNum - 1) * middlePageSize;
		
		Page page = new Page(totalRecords, middlePageSize, middlePageNum);
		
		List<Order> orders = orderMapper.getPageData(middlePageSize, pageIndex);
		page.setList(orders);
		return page;
	}
}
