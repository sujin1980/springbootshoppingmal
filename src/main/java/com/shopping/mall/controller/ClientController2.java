package com.shopping.mall.controller;


import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
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

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import org.springframework.web.bind.annotation.ModelAttribute;
import com.shopping.mall.model.ShoppingMallClient;
import com.shopping.mall.model.ShoppingMallOrder;
import com.shopping.mall.model.Product;
import com.shopping.mall.service.ClientService;
import com.shopping.mall.service.OrderService;
import com.shopping.mall.util.StringUtil;

@Controller
public class ClientController2 {
	//private static Logger logger = Logger.getLogger(ClientController.class);
	
	@Autowired
	private ClientService clientService;
	
	@Autowired
	private OrderService  orderService;

	
	@RequestMapping("/client/hello")
    public String hello(Model model) {
        return "redirect:/client/list2";
    }

    @RequestMapping("/client/list2")
    @ResponseBody
    public  List<ShoppingMallClient> list(HttpServletRequest request) {
    	System.out.println("Thymeleaf查询所有");
        List<ShoppingMallClient> clients=clientService.findAll();
        return clients;
    }

    @RequestMapping("/client/toOrder2")
    public String clientOrder(Model model, int id) {
    	System.out.println("Thymeleaf查询所有");
        
        model.addAttribute("orders",  orderService.findOrderListByClientId(id));
        ShoppingMallClient client = clientService.findClientById(id);
        model.addAttribute("clientName",  client.getName());
        model.addAttribute("clientPhone",  client.getTelephone());
        return "client/order2";
    }

    @RequestMapping("/client/alltoOrder2")
    public String allclientOrder(Model model) {
    	System.out.println("Thymeleaf查询所有");
        
        model.addAttribute("orders",  orderService.findAll());
        return "client/order2";
    }
    
    @RequestMapping(value = "/client/deleteClients", method = { RequestMethod.POST })
    public String deleteClients(HttpServletRequest request, @RequestBody String idlistJson) throws Exception{  
        System.out.println(idlistJson);  
        List<String> jsonStrlist = Arrays.asList(idlistJson.split("&"));
        List<String>  idlist = new ArrayList<String>();
        for(String jsonStr: jsonStrlist) {
        	
        	Integer.valueOf(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()));
        	idlist.add(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()));
        	
        }
        System.out.println(idlist);
        clientService.deleteClients(idlist);
        return "redirect:/client/list2";
    }  
    
    
    
    @RequestMapping("/client/toAdd2")
    public String toAdd() {
        return "client/Add2";
    }
        
    
    @RequestMapping(value ="/client/findClientByName", method = { RequestMethod.POST })
    @ResponseBody
    public List<ShoppingMallClient> findClientByName(HttpServletRequest request, @RequestParam String name) throws Exception{  
    	String clientName = StringUtil.cutTabReturn(name);
    
    	if(clientName.length() == 0) {
        	return clientService.findAll();
        }
    	
    	List<ShoppingMallClient> clientList = new ArrayList<>();
    	ShoppingMallClient client = clientService.findOneByName(clientName);
    	
    	if(client == null) {
    		return null;
    	}
	    
    	clientList.add(clientService.findOneByName(clientName));
        return clientList;
    }  
    
    @RequestMapping(value ="/client/getClientById", method = { RequestMethod.POST })
    @ResponseBody
    public ShoppingMallClient getClientById(HttpServletRequest request, @RequestParam Integer id) throws Exception{  
      
    	System.out.println("id = " + id + "=========================================");
    	ShoppingMallClient client = clientService.findClientById(Integer.valueOf(id));
        return client;
    } 
//        
    @RequestMapping(value ="/client/add2", method = { RequestMethod.POST })
    public String add(HttpServletRequest request, @RequestBody String idlistJson){  
        System.out.println(idlistJson);  
        
        List<String> jsonStrlist = Arrays.asList(idlistJson.split("&"));
        ShoppingMallClient client = new ShoppingMallClient();

        
        System.out.println(client);
        clientService.addClient(client);
        return "redirect:/client/list2";
    }      

    @RequestMapping("/client/toEdit2")
    public String toEdit(Model model,int id) {
    	System.out.println("开始编辑");
        
        ShoppingMallClient  client = clientService.findClientById(id);
        model.addAttribute("client", client);
        return "client/order2";
    }

    @RequestMapping("/client/edit2")
    public String edit(HttpServletRequest request, @RequestBody String idlistJson) throws UnsupportedEncodingException {
    	List<String> jsonStrlist = Arrays.asList(idlistJson.split("&"));
        ShoppingMallClient client = new ShoppingMallClient();
        for(String jsonStr: jsonStrlist) {
        	if((jsonStr.substring(0, jsonStr.indexOf("=")).equals("id") )){
        		client.setId(Integer.valueOf(URLDecoder.decode(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()), "UTF-8")));
        	}else if((jsonStr.substring(0, jsonStr.indexOf("=")).equals("name") )){
        		client.setName(URLDecoder.decode(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()), "UTF-8"));
        	}
        	
        }
        System.out.println(client);
        clientService.updateClient(client);
        return "redirect:/client/list2";
    }

    @RequestMapping("/client/toDelete2")
    public String delete(int id) {
        clientService.deleteClient(id);
        return "redirect:/client/list2";
    }
}

