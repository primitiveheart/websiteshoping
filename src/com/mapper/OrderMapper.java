package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.entity.Order;

public interface OrderMapper {
	
	Integer addOrder(Order order);
	
	List<Order> queryOrderByUsername(String username);
	
	Integer totalOrderNum();
	
	List<Order> queryAllOrder();
	
	Order queryOrderByUUID(String uuid);
	
	List<Order> getPageData(@Param("pageSize")Integer pageSize, @Param("pageIndex")Integer pageIndex);
}
