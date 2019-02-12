package com.shopping.mall.controller;


import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.shopping.mall.model.OrderGoods;
import com.shopping.mall.model.Product;
import com.shopping.mall.model.ShoppingMallClient;
import com.shopping.mall.model.ShoppingMallOrder;
import com.shopping.mall.service.ClientService;
import com.shopping.mall.service.OrderGoodsService;
import com.shopping.mall.service.OrderService;
import com.shopping.mall.util.LineNo;
import com.shopping.mall.util.StringUtil;

@Controller
public class OrderController2 {
	//private static Logger logger = Logger.getLogger(OrderController.class);
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private ClientService clientService;
	
	@Autowired
	private OrderGoodsService orderGoodsService;
	
	@RequestMapping("/order/hello")
    public String hello(Model model) {
        return "redirect:/order/list2";
    }
	
    @RequestMapping("/order/list2")
    @ResponseBody
    public List<ShoppingMallOrder> list(HttpServletRequest request) {
    	System.out.println("Thymeleaf查询所有");
        List<ShoppingMallOrder> orders=orderService.findAll();
        return orders;
    } 
    
    @RequestMapping("/order/toAdd2")
    public String toAdd() {
    	System.out.println("开始添加1");
        return "order/Add2";
    }
        
    
    @RequestMapping(value ="/order/getOrderListByClientName", method = { RequestMethod.POST })
    @ResponseBody
    public List<ShoppingMallOrder> getOrderListByClientName(HttpServletRequest request, @RequestParam String clientName) throws Exception{  
    	String name = StringUtil.cutTabReturn(clientName);
    	if(name.length() == 0) {
    		return orderService.findAll();
    	}
        
        return  orderService.findOrderListByClientName(name);
    } 
    
    @RequestMapping(value ="/order/getOrderListByClientId", method = { RequestMethod.POST })
    @ResponseBody
    public List<ShoppingMallOrder> getOrderListByClientId(HttpServletRequest request, @RequestParam String clientId) throws Exception{  
    	String id = StringUtil.cutTabReturn(clientId);
    	if(id.length() == 0) {
    		return orderService.findAll();
    	}
        
        return  orderService.findOrderListByClientId(Integer.valueOf(id));
    } 
    
    @RequestMapping(value ="/order/add2", method = { RequestMethod.POST })
    public String add(HttpServletRequest request, @RequestBody String idlistJson) throws Exception{  
        System.out.println(idlistJson);  
        
        List<String> jsonStrlist = Arrays.asList(idlistJson.split("&"));
        ShoppingMallOrder order = new ShoppingMallOrder();
        for(String jsonStr: jsonStrlist) {

        	
        }
        System.out.println(order);
        orderService.addOrder(order);
        return "redirect:/order/list2";
    }      
    
    @RequestMapping(value ="/order/create2", method = { RequestMethod.POST })
    @ResponseBody
    public String create2(HttpServletRequest request, @RequestParam String id){  
        
    	ShoppingMallClient client = clientService.findClientById(Integer.valueOf(id));
    	
    	ShoppingMallOrder order = new ShoppingMallOrder();
    	order.setId(System.currentTimeMillis());
    	order.setClientId(client.getId());
    	order.setClientName(client.getName());
    	order.setClientChineseName(client.getChineseName());
    	
    	String createTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(System.currentTimeMillis());
    	order.setCreateTime(createTime);
    	order.setReceiverMobile(client.getTelephone());
    	order.setConsignTime("未发货");
    	order.setPaymentTime("未付款");
    	order.setReceiverAreaName(client.getAddress());
    	try {
        	orderService.addOrder(order);
        	return "OK";
    	}catch(Exception e) {
    		return "FAIL";
    	}
    }      
    
    @RequestMapping(value = "/order/deleteOrders", method = { RequestMethod.POST })
    @ResponseBody
    public String deleteClients(HttpServletRequest request, @RequestBody String idlistJson) throws Exception{  
        System.out.println(idlistJson);  
        List<String> jsonStrlist = Arrays.asList(idlistJson.split("&"));
        List<String>  idlist = new ArrayList<String>();
        for(String jsonStr: jsonStrlist) {
        	
        	//Integer.valueOf(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()));
        	idlist.add(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()));
        	
        }
        System.out.println(idlist);
        orderService.deleteOrders(idlist);
        return "ok";
    }
    
    @RequestMapping(value ="/order/modify", method = { RequestMethod.POST })
    @ResponseBody
    public String modify(HttpServletRequest request, @RequestParam String id, 
    		@RequestParam String status, @RequestParam String paymentType, 
    		@RequestParam String payment, @RequestParam String paymentTime,
    		@RequestParam String consignTime, @RequestParam String endTime, 
    		@RequestParam String clientChineseName, @RequestParam String receiverMobile,
    		@RequestParam String receiverAreaName) {
        
    	System.out.println("[" + LineNo.getFileName() + "]" + LineNo.getLineNumber() +  "=====");
    	
        try {
	        ShoppingMallOrder  order = orderService.findOrderById(Long.valueOf(id));
	        order.setStatus(status);
	        order.setPayment(new BigDecimal(payment));
	        order.setPaymentType(paymentType);
	        order.setPaymentTime(paymentTime);
	        order.setConsignTime(consignTime);
	        order.setEndTime(endTime);
	        order.setClientChineseName(clientChineseName);
	        order.setReceiverMobile(receiverMobile);
	        order.setReceiverAreaName(receiverAreaName);
	        
	        orderService.updateOrder(order);
	        return "OK";
        }catch(Exception e) {
        	System.out.println("修改订单失败");
        	return "FAIL";
        }
    }
    


    @RequestMapping("/order/toEdit2")
    @ResponseBody
    public ShoppingMallOrder toEdit(HttpServletRequest request, @RequestParam String id) {
    	System.out.println("开始编辑");
        
        ShoppingMallOrder  order = orderService.findOrderById(Long.valueOf(id));
        request.getSession().setAttribute("clientorder", order);
        return order;
    }
    
    @RequestMapping(value ="/order/getOrderById", method = { RequestMethod.POST })
    @ResponseBody
    public List<ShoppingMallOrder> getOrderById(HttpServletRequest request, @RequestParam String id) throws Exception{       	
     	String clientId = StringUtil.cutTabReturn(id);
    	if((clientId == null) || (clientId.trim().length() == 0)) {
        	return orderService.findAll();
        }
    	
    	
    	List<ShoppingMallOrder> orderList = new ArrayList<>();
    	ShoppingMallOrder order = orderService.findOrderById(Long.valueOf(clientId));
    	orderList.add(order);
        return orderList;
    } 
    
    

    @RequestMapping("/order/toDelete2")
    public String delete(long id) {
        orderService.deleteOrder(id);
        return "redirect:/order/list2";
    }
}

