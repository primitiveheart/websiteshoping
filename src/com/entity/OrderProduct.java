package com.entity;

import java.sql.Date;
import java.util.List;

public class OrderProduct {
	private String uuid;//订单号
	private String number;//数量
	private String price;//价格
	private Date date;
	
	private String username;
	
	private List<Product> products;

	public OrderProduct() {
		super();
	}

	public OrderProduct(String uuid, String number, String price,
			Date date, String username, List<Product> products) {
		super();
		this.uuid = uuid;
		this.number = number;
		this.price = price;
		this.date = date;
		this.username = username;
		this.products = products;
	}
	
	public OrderProduct(Order order, List<Product> products){
		this(order.getUuid(), order.getNumber(), order.getPrice(), order.getDate(), order.getUsername(), products);
	}

	
	
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}


	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public List<Product> getProducts() {
		return products;
	}

	public void setProducts(List<Product> products) {
		this.products = products;
	}
	
	
}
