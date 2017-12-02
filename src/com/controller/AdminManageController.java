package com.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import com.alibaba.fastjson.JSONObject;
import com.commons.Page;
import com.entity.Message;
import com.entity.Order;
import com.entity.OrderProduct;
import com.entity.Product;
import com.mapper.IndexMapper;
import com.mapper.MessageMapper;
import com.mapper.OrderMapper;
import com.mapper.ProductMapper;
import com.service.PageService;
import com.utils.ResponseUtil;

/**
 * 管理员管理订单的界面
 * @author admin
 *
 */
@Controller
@RequestMapping("admin")
public class AdminManageController {
	
	private final static Logger logger = LoggerFactory.getLogger(AdminManageController.class);
	
	@Autowired
	private OrderMapper orderMapper;
	
	@Autowired
	private ProductMapper productMapper;
	
	@Autowired
	private IndexMapper indexMapper;
	
	@Autowired
	private MessageMapper messageMapper;
	
	@Autowired
	private PageService pageService;
	
//	@RequestMapping("manage.html")
	public String manage(HttpServletRequest request){
		List<OrderProduct> orderProducts = new ArrayList<OrderProduct>();
		try{
			List<Order> orders = orderMapper.queryAllOrder();
			for(Order order : orders){
				List<Product> products = productMapper.queryProductByOrderUUID(order.getUuid());
				OrderProduct orderProduct = new OrderProduct(order, products);
				orderProducts.add(orderProduct);
			}
		}catch (Exception e) {
			logger.error("AdminManageController manage 数据查找失败", e);
		}
		
		request.setAttribute("orderProducts", orderProducts);
		return "admin/manage";
	}
	
	/**
	 * 进入到管理员的主界面
	 * @param request
	 * @return
	 */
	@RequestMapping("manage.html")
	public String getPageData(Model model, String pageSize, String pageNum){
		List<OrderProduct> orderProducts = new ArrayList<OrderProduct>();
		if(pageSize == null){
			pageSize = "2";
			Page page = new Page();
			try {
				page = pageService.getPageData(pageNum, pageSize);
				List<Order> orders = page.getList();
				for(Order order : orders){
					List<Product> products = productMapper.queryProductByOrderUUID(order.getUuid());
					OrderProduct orderProduct = new OrderProduct(order, products);
					orderProducts.add(orderProduct);
				}
			} catch (Exception e) {
				logger.error("AdminManageController manage 数据查找失败", e);
			}
			
			page.setList(orderProducts);
			
			model.addAttribute("page", page);
		}else{
			Page page = new Page();
			try {
				page = pageService.getPageData(pageNum, pageSize);
				List<Order> orders = page.getList();
				for(Order order : orders){
					List<Product> products = productMapper.queryProductByOrderUUID(order.getUuid());
					OrderProduct orderProduct = new OrderProduct(order, products);
					orderProducts.add(orderProduct);
				}
			} catch (Exception e) {
				logger.error("AdminManageController manage 数据查找失败", e);
			}
			
			page.setList(orderProducts);
			
			model.addAttribute("page", page);
		}
		
		return "admin/manage";
	}
	
	@RequestMapping(value="acquireSecretKey.html", method=RequestMethod.POST)
	public void acquireSecretKey(HttpServletResponse response, String order_uuid, String product_id, String username, String state){
		//TODO 这里需要写日志
		JSONObject jsonObject = new JSONObject();
		
		if("审核中".equals(state)){
			try {
				//第一步：获取密钥
				String account = indexMapper.getSecretKey();
				JSONObject accountJson = JSONObject.parseObject(account);
				
				//第二步：改变的订单的状态
				//1.获得产品
				Product product = productMapper.queryProductById(Integer.valueOf(product_id));
				//2.更新状态
				product.setState("审核通过");
				productMapper.updateProductById(product);
				
				//第三步：把消息写到数据库中
				Message message = new Message();
				message.setAccount_num(accountJson.getString("acc_num"));
				message.setAccount_pwd(accountJson.getString("pwd"));
				message.setUsername(username);
				message.setProduct_id(Integer.valueOf(product_id));
				
				messageMapper.addMessage(message);
			} catch (Exception e) {
				logger.error("AdminManageController acquireSecretKey 产品更新数据失败或是消息插入数据库失败", e);
			}
		}
		
		jsonObject.put("success", true);
		ResponseUtil.renderJson(response, jsonObject);
	}
}
