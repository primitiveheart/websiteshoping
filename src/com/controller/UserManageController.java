package com.controller;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.annotations.Param;
import org.junit.runners.Parameterized.Parameters;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.entity.Message;
import com.entity.Order;
import com.entity.Product;
import com.entity.ProductSecretKey;
import com.entity.User;
import com.mapper.IndexMapper;
import com.mapper.MessageMapper;
import com.mapper.OrderMapper;
import com.mapper.ProductMapper;

@Controller
@RequestMapping("home")
public class UserManageController {
	
	private final static Logger logger = LoggerFactory.getLogger(UserManageController.class);
	
	@Autowired
	private IndexMapper indexMapper;
	
	@Autowired
	private MessageMapper messageMapper;
	
	@Autowired
	private ProductMapper productMapper;
	
	@Autowired
	private OrderMapper orderMapper;
	
	@RequestMapping("userhome.html")
	public String order(HttpServletRequest request){
    	String index = indexMapper.getIndex();
    	List<String> result = new ArrayList<String>();
    	
    	if(index != null && StringUtils.isNotEmpty(index)){
    		JSONObject jsonObject1 = JSONObject.parseObject(index);
    		String temp = jsonObject1.getString("result");
    		JSONObject eng_name = JSONObject.parseObject(temp);
    		result = JSONArray.parseArray(eng_name.getString("eng_name")).toJavaList(String.class);
    	}
	
    	request.setAttribute("index", result);
		return "home/user-home";
	}
	
	/**
	 * 进入到我的消息界面
	 * @return
	 */
	@RequestMapping("myMessage.html")
	public String myMessage(HttpSession session, HttpServletRequest request){
		User user = (User) session.getAttribute("user");
		List<ProductSecretKey> productSecretKeys = new ArrayList<ProductSecretKey>();
		try {
			//获取消息
			List<Message> messages = messageMapper.queryMessageByUsername(user.getUsername());
			for(Message message : messages){
				Product product = productMapper.queryProductById(message.getProduct_id());
				Order order = orderMapper.queryOrderByUUID(product.getOrder_uuid());
				ProductSecretKey productSecretKey = new ProductSecretKey(order.getDate(), order.getUuid(), message.getAccount_num(), message.getAccount_pwd(), product);
				productSecretKeys.add(productSecretKey);
			}
		} catch (Exception e) {
			logger.error("UserManageController myMessage 查询失败", e);
		}
		
		request.setAttribute("productSecretKeys", productSecretKeys);
		
		return "home/myMessage";
	}
	
	@RequestMapping("productResultDisplay.html")
	public String productResultDisplay(HttpSession session, Integer productId){
		//这里要进行密钥的验证
		
    	//VIEWPARAMS=lon:100;lat:29; radius:3;fld: gb1999;year_=2010;usr_name:'sha';pwd:'zongyao'
    	String VIEWPARAMS = "";
    	//第一步:获取密钥
    	String secretKey = indexMapper.getSecretKey();
		JSONObject jsonObject = JSONObject.parseObject(secretKey);
		String account_num = jsonObject.getString("acc_num");
		String account_pwd = jsonObject.getString("pwd");
		
		//获取产品
	    Product product = productMapper.queryProductById(productId);
	    
	    //获取订单
	    Order order = orderMapper.queryOrderByUUID(product.getOrder_uuid());
	    
	    //获取数据选项
		String middle = product.getIndex();
		if(middle.contains(",")){
			String[] middleIndex = middle.split(","); 
			//TODO 需要增强
			//目前只有查询一个指标的结果
			VIEWPARAMS = order.getScope() + ";fld:"+middleIndex[0] + "year_=" + product.getYear() + ";usr_name:" + "'" + account_num +"';pwd:" + account_pwd + "'"; 
		}else{
			VIEWPARAMS = order.getScope() + ";fld:"+ middle + "year_=" + product.getYear() + ";usr_name:" + "'" + account_num +"';pwd:" + account_pwd + "'";
		}
		String inputForm = product.getInputForm();
		
		session.setAttribute("shape", order.getShape());
		session.setAttribute("VIEWPARAMS", VIEWPARAMS);
    	
    	if(inputForm.equals("data")){
    		return "redirect:../result/vector.html";
    	}else if(inputForm.equals("special")){
    		return "redirect:../result/special.html";
    	}else{
    		return "redirect:../result/sum.html";
    	}
	}
	
}
