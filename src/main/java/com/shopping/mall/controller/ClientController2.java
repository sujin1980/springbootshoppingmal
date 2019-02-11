package com.shopping.mall.controller;


import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

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
	
//    @RequestMapping("/client/list2")
//    public String list(Model model) {
//    	System.out.println("Thymeleaf查询所有");
//        List<Client> clients=clientService.findAll();
//        model.addAttribute("clients", clients);
//        return "client/list2";
//    }
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
      
        
    	List<ShoppingMallClient> clientList = new ArrayList<>();
		if(name.length() == 0) {
			clientList = clientService.findAll();
		}else {
	        //System.out.println(name);
	        clientList.add(clientService.findOneByName(name));
		}
        
        return clientList;
    }  
    
    
    
    
//  //直接省略注解
//    @RequestMapping("/jsontest.do")
//    public void test(User user,String username,String password,Boolean rememberMe){
//        System.out.println(user);
//        System.out.println("username: " + username);
//        System.out.println("password: " + password);
//        System.out.println("rememberMe: " + rememberMe);
//        
    @RequestMapping(value ="/client/add2", method = { RequestMethod.POST })
    public String add(HttpServletRequest request, @RequestBody String idlistJson){  
        System.out.println(idlistJson);  
        
        List<String> jsonStrlist = Arrays.asList(idlistJson.split("&"));
        ShoppingMallClient client = new ShoppingMallClient();
//        for(String jsonStr: jsonStrlist) {
//        	if((jsonStr.substring(0, jsonStr.indexOf("=")).equals("name") )){
//        		try {
//					client.setName(URLDecoder.decode(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()), "UTF-8"));
//				} catch (UnsupportedEncodingException e) {
//					// TODO Auto-generated catch block
//					e.printStackTrace();
//				}
//        	}else if((jsonStr.substring(0, jsonStr.indexOf("=")).equals("telephone") )){
//        		client.setTelephone(URLDecoder.decode(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()), "UTF-8"));
//        	}else if((jsonStr.substring(0, jsonStr.indexOf("=")).equals("address") )){
//        		client.setAddress(URLDecoder.decode(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()), "UTF-8"));
//        	}else if((jsonStr.substring(0, jsonStr.indexOf("=")).equals("weixin") )){
//        		client.setWeixin(URLDecoder.decode(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()), "UTF-8"));
//        	}else if((jsonStr.substring(0, jsonStr.indexOf("=")).equals("qq") )){
//        		client.setQq(URLDecoder.decode(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()), "UTF-8"));
//        	}else if((jsonStr.substring(0, jsonStr.indexOf("=")).equals("remarks") )){
//        		client.setRemarks(URLDecoder.decode(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()), "UTF-8"));
//        	}
//        	
//        }
        
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

