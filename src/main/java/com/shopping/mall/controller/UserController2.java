package com.shopping.mall.controller;


import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
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

import com.shopping.mall.model.ShoppingMallOrder;
import com.shopping.mall.model.User;
import com.shopping.mall.service.UserService;

@Controller
public class UserController2 {
	//private static Logger logger = Logger.getLogger(UserController.class);
	private static Logger logger = Logger.getLogger(UserController2.class);
	
	@Autowired
	private UserService userService;
	
	@RequestMapping("/")
	public String index() {
	    return "/login/login";
	}
	
	@RequestMapping("/user/login")  
	@ResponseBody
    public String login(HttpServletRequest request, @RequestParam String username, @RequestParam String password) throws UnsupportedEncodingException {    
         User user  = userService.findOneByName(username);
         if((user!= null) && user.getPassword().equals(password)) {
        	 HttpSession session = request.getSession();
 			 session.setAttribute("loginUser", user);
 			 logger.info("登录成功====================================");
			 return "OK";
		 }
		 return "FAIL";
    }
	
	@RequestMapping("/user/hello")
    public String hello(Model model) {
        return "redirect:/user/list2";
    }
	
//    @RequestMapping("/user/list2")
//    public String list(Model model) {
//    	System.out.println("Thymeleaf查询所有");
//        List<User> users=userService.findAll();
//        model.addAttribute("users", users);
//        return "user/list2";
//    }
    @RequestMapping("/user/list2")
    public String list(Model model) {
    	System.out.println("Thymeleaf查询所有");
        List<User> users=userService.findAll();
        model.addAttribute("users", users);
        return "user/list2";
    }


    @RequestMapping(value = "/user/deleteUsers", method = { RequestMethod.POST })
    public String deleteUsers(HttpServletRequest request, @RequestBody String idlistJson) throws Exception{  
        System.out.println(idlistJson);  
        List<String> jsonStrlist = Arrays.asList(idlistJson.split("&"));
        List<String>  idlist = new ArrayList<String>();
        for(String jsonStr: jsonStrlist) {
        	
        	Integer.valueOf(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()));
        	idlist.add(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()));
        	
        }
        System.out.println(idlist);
        userService.deleteUsers(idlist);
        return "redirect:/user/list2";
    }  
    
    @RequestMapping("/user/toAdd2")
    public String toAdd() {
    	System.out.println("开始添加1");
        return "user/Add2";
    }
        
    
    @RequestMapping(value ="/user/add2", method = { RequestMethod.POST })
    public String add(HttpServletRequest request, @RequestBody String idlistJson) throws Exception{  
        System.out.println(idlistJson);  
        
        List<String> jsonStrlist = Arrays.asList(idlistJson.split("&"));
        User user = new User();
        for(String jsonStr: jsonStrlist) {

        	
        }
        System.out.println(user);
        userService.addUser(user);
        return "redirect:/user/list2";
    }      

    @RequestMapping("/user/toEdit2")
    public String toEdit(Model model,int id) {
    	System.out.println("开始编辑");
        
        User  user = userService.findUserById(id);
        model.addAttribute("user", user);
        return "user/Edit2";
    }

    @RequestMapping("/user/edit2")
    public String edit(HttpServletRequest request, @RequestBody String idlistJson) throws UnsupportedEncodingException {
    	List<String> jsonStrlist = Arrays.asList(idlistJson.split("&"));
        User user = new User();
        for(String jsonStr: jsonStrlist) {

        	
        }
        System.out.println(user);
        userService.updateUser(user);
        return "redirect:/user/list2";
    }

    @RequestMapping("/user/toDelete2")
    public String delete(int id) {
        userService.deleteUser(id);
        return "redirect:/user/list2";
    }
}

