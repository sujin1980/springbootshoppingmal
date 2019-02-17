package com.shopping.mall.controller;


import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.shopping.mall.model.Product;
import com.shopping.mall.model.ProductCategory;
import com.shopping.mall.model.ProductType;
import com.shopping.mall.service.ProductTypeService;
import com.shopping.mall.util.StringUtil;

@Controller
public class ProductTypeController2 {
	//private static Logger logger = Logger.getLogger(ProductTypeController.class);
	
	@Autowired
	private ProductTypeService productTypeService;
	
    @RequestMapping("/producttype/list2")
    public String list(Model model) {
    	System.out.println("Thymeleaf查询所有");
        List<ProductType> productTypes=productTypeService.findAll();
        model.addAttribute("producttypes", productTypes);	
        return "jsp/producttype/list2";
    }


    @RequestMapping("/producttype/toAdd2")
    public String toAdd() {
    	System.out.println("开始添加1");
        return "jsp/producttype/Add2";
    }

    @RequestMapping(value ="/producttype/add2", method = { RequestMethod.POST })
    @ResponseBody
	public String add(HttpServletRequest request, @RequestParam String id, @RequestParam String name, 
    		@RequestParam String categoryid, @RequestParam String picture, @RequestParam String remarks){  
        //System.out.println(idlistJson);  
        
		try {
	        ProductType productType = new ProductType();
	        
	        productType.setName(name);
	        productType.setRemarks(remarks);
	        productType.setPicture(picture + "");
	       
	        ProductCategory productCategory = new ProductCategory();
	        productCategory.setId(Integer.valueOf(categoryid));
	        productType.setProductCategory(productCategory);
	        productTypeService.addProductType(productType);
	        return "OK";
        }catch(Exception e) {
        	return "FAIL";
        }
    } 
    
    @RequestMapping("/producttype/show")
    public String show(Model model,int id) {
    	System.out.println("开始编辑");
        ProductType producttype=productTypeService.findProductTypeById(id);
        model.addAttribute("producttype", producttype);
        return "producttype/show";
    }
    
    @RequestMapping("/producttype/toEdit2")
    public String toEdit(Model model,int id) {
    	System.out.println("开始编辑");
        ProductType producttype=productTypeService.findProductTypeById(id);
        model.addAttribute("producttype", producttype);
        model.addAttribute("categoryid", producttype.getProductCategory().getId());
        return "producttype/Edit2";
    }

    @RequestMapping(value ="/producttype/edit2", method = { RequestMethod.POST })
    @ResponseBody
	public String edit(HttpServletRequest request, @RequestParam String id, @RequestParam String name, 
    		@RequestParam String categoryid, @RequestParam String picture, @RequestParam String remarks){  
        //System.out.println(idlistJson);  
        
		try {
	        ProductType productType = new ProductType();
	        productType.setId(Integer.valueOf(id));
	        productType.setName(name);
	        productType.setRemarks(remarks);
	        productType.setPicture(picture + "");
	       
	        ProductCategory productCategory = new ProductCategory();
	        productCategory.setId(Integer.valueOf(categoryid));
	        productType.setProductCategory(productCategory);
	        //productTypeService.addProductType(productType);
	        productTypeService.updateProductType(productType);
	        return "OK";
        }catch(Exception e) {
        	return "FAIL";
        }
    } 

    @RequestMapping("/producttype/toDelete2")
    public String delete(int id) {
        productTypeService.deleteProductType(id);
        return "redirect:/producttype/list2";
    }
    
    @RequestMapping(value = "/producttype/getTypeListByCategoryId", method = { RequestMethod.POST })
    @ResponseBody
    public List<ProductType>  getTypeListByCategoryId(HttpServletRequest request, @RequestParam String categoryid){
    	
    	List<ProductType> productTypeList = productTypeService.findProductTypeListByCategoryId(Integer.valueOf(categoryid));  
    	//request.get
    	return  productTypeList;
    }     
    
    @RequestMapping(value = "/producttype/deleteProductTypes", method = { RequestMethod.POST })
    @ResponseBody
    public String deleteProducts(HttpServletRequest request, @RequestBody String idlistJson) throws Exception{  
        System.out.println(idlistJson);  
        List<String> jsonStrlist = Arrays.asList(idlistJson.split("&"));
        List<String>  idlist = new ArrayList<String>();
        for(String jsonStr: jsonStrlist) {
        	
        	Integer.valueOf(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()));
        	idlist.add(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()));
        	
        }
        System.out.println(idlist);
        productTypeService.deleteProductTypes(idlist);
        return "OK";
    }  
    
    @RequestMapping(value = "/producttype/getTypeByName", method = { RequestMethod.POST })
    @ResponseBody
    public List<ProductType>  getTypeByName(HttpServletRequest request, @RequestParam String name){
    	String clientName = StringUtil.cutTabReturn(name);
    	if(clientName.length() == 0) {
        	return productTypeService.findAll();
        }
    	
    	List<ProductType> productTypeList = productTypeService.findProductTypeListByName(clientName);  
    	return  productTypeList;
    } 
    
    
    @RequestMapping(value = "/producttype/getTypeListByCategoryStrId", method = { RequestMethod.POST })
    @ResponseBody
    public List<ProductType>  getTypeListByCategoryStrId(HttpServletRequest request, @RequestBody String str){
    	String strid = str.substring(str.indexOf("=") + 1, str.length());
    	int id = Integer.valueOf(strid);
 
    	List<ProductType> productTypeList = productTypeService.findProductTypeListByCategoryId(id);    	
    	return  productTypeList;
    }  
    
}

