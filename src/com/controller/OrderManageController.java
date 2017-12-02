package com.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.entity.Order;
import com.entity.OrderProduct;
import com.entity.Product;
import com.entity.User;
import com.mapper.OrderMapper;
import com.mapper.ProductMapper;
import com.utils.UUIDUtil;

@Controller
@RequestMapping("home")
public class OrderManageController {
	
	private final static Logger logger = LoggerFactory.getLogger(OrderManageController.class);
	
	@Autowired
	private ProductMapper productMapper;
	
	@Autowired
	private OrderMapper orderMapper;
	
	/**
	 * 转向订单成功页面
	 * @return
	 */
	@RequestMapping("createOrderSuccess.html")
	public String creataOrderSuccess(){
		return "home/create-order-success";
	}
	
	/**
	 * 我的订单
	 * @return
	 */
	@RequestMapping("myOrder.html")
	public String myOrder(HttpSession session, HttpServletRequest request){
		User user = (User) session.getAttribute("user");
		List<OrderProduct> orderProudcts = new ArrayList<OrderProduct>();
		if(user == null){
			return "redirect:login.html";
		}else{
			try{
				List<Order> orders = orderMapper.queryOrderByUsername(user.getUsername());
				for(Order order : orders){
					List<Product> products = productMapper.queryProductByOrderUUID(order.getUuid());
					OrderProduct orderProduct = new OrderProduct(order, products);
					orderProudcts.add(orderProduct);
				}
			}catch (Exception e) {
				logger.error("OrderManageController myOrder 查找数据失败", e);
			}
		}
		
		request.setAttribute("orderProudcts", orderProudcts);
		
		//这里主要进行查询数据库
		return "home/myOrder";
	}
	
	
	/**
	 * 创建订单
	 * @return
	 */
	@RequestMapping("createOrder.html")
	public String createOrder(HttpSession session, Product product, String scope, String shape){
		//获取用户名
		User user = (User) session.getAttribute("user");
		if(user == null){
			return "redirect:home/login.html";
		}else{
			//创建订单
			Order order = new Order();
			String order_uuid = UUIDUtil.getUUID();
			String order_num = "1";
			String order_price = Integer.valueOf(product.getArea()) * 100 + "";
			String order_state = "审核中";
			order.setUuid(order_uuid);
			order.setNumber(order_num);
			order.setPrice(order_price);
			order.setState(order_state);
			order.setUsername(user.getUsername());
			order.setScope(scope);
			order.setShape(shape);
			try{
				//把订单插入到数据库中
				orderMapper.addOrder(order);
			}catch (Exception e) {
				logger.error("OrderManageController createOrder 订单数据插入失败", e);
			}
			
			String year = product.getYear();
			String[] yearProduct = year.split(",");
			try{
				for(int i=0; i < yearProduct.length; i++){
					Product tempProduct = new Product();
					tempProduct.setYear(yearProduct[i]);
					tempProduct.setArea(product.getArea());
					tempProduct.setIndex(product.getIndex());
					tempProduct.setInputForm(product.getInputForm());
					tempProduct.setOrder_uuid(order_uuid);
					tempProduct.setState(order_state);
					
					//把产品数据插入到数据库中
					productMapper.addProduct(tempProduct);
				}
			}catch (Exception e) {
				logger.error("OrderManageController createOrder 产品数据插入失败", e);
			}
			
			//创建订单成功后转向成功的页面
			return "redirect:createOrderSuccess.html";
		}
		
	}
}
