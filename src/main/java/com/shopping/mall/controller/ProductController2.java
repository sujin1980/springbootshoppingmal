package com.shopping.mall.controller;


import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shopping.mall.model.Product;
import com.shopping.mall.model.ProductType;
import com.shopping.mall.service.ProductService;
import com.shopping.mall.service.ProductTypeService;



@Controller
public class ProductController2 {
	private static Logger LOGGER = LoggerFactory.getLogger(ProductController2.class);
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private ProductTypeService productTypeService;
	
	@RequestMapping("/product/hello")
    public String hello(Model model) {
        return "redirect:/product/list2";
    }
	
    @RequestMapping("/product/list2")
    @ResponseBody
    public List<Product> list(HttpServletRequest request, Model model) {
        try {
	    	List<Product> products = productService.findAll();
	    	return products;
        }catch(Exception e) {
        	LOGGER.error(e.toString());
        	return null;
        }
    }

    @RequestMapping(value = "/product/deleteProducts", method = { RequestMethod.POST })
    @ResponseBody
    public String deleteProducts(HttpServletRequest request, @RequestParam String idlist) throws Exception{  
        System.out.println(idlist);  
        List<String> jsonStrlist = Arrays.asList(idlist.split("&"));
        List<String>  idlistjson = new ArrayList<String>();
        for(String jsonStr: jsonStrlist) {
        	Integer.valueOf(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()));
        	idlistjson.add(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()));
        }
        System.out.println("idlist = " + idlist);
        productService.deleteProducts(idlistjson);
        return "OK";
    }  
    
    @RequestMapping(value = "/product/getproductbyname", method = { RequestMethod.POST })
    @ResponseBody
    public List<Product> getproductbyname(HttpServletRequest request, @RequestParam String name){  
        String productName;
       
		try {
			productName = URLDecoder.decode(name, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
        

        List<Product> productList = new ArrayList<>();
		if(productName.length() == 0) {
			productList = productService.findAll();
		}else {
	        System.out.println(productName);
	        productList.add(productService.findOneByName(productName));
		}
        //model.addAttribute("products", productList);
        return productList;
    } 
    
    @RequestMapping("/product/toAdd2")
    public String toAdd() {
    	System.out.println("开始添加1");
        return "product/Add2";
    }
        
//    @RequestMapping(value ="/product/add2", method = { RequestMethod.POST })
//    public String add(HttpServletRequest request, @RequestBody String idlistJson) throws Exception{  
//        System.out.println(idlistJson);  
//        
//        List<String> jsonStrlist = Arrays.asList(idlistJson.split("&"));
//        Product product = new Product();
//        for(String jsonStr: jsonStrlist) {
//        	if((jsonStr.substring(0, jsonStr.indexOf("=")).equals("name") )){
//        		product.setName(URLDecoder.decode(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()), "UTF-8"));
//        	}else if((jsonStr.substring(0, jsonStr.indexOf("=")).equals("price") )){
//        		product.setPrice(new BigDecimal(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length())));
//        	}else if((jsonStr.substring(0, jsonStr.indexOf("=")).equals("remarks") )){
//        		product.setRemarks(URLDecoder.decode(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()), "UTF-8"));
//        	}else if((jsonStr.substring(0, jsonStr.indexOf("=")).equals("icon") )){
//        		product.setIcon(URLDecoder.decode(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length()), "UTF-8"));
//        	}else if((jsonStr.substring(0, jsonStr.indexOf("=")).equals("typeid") )){
//        		ProductType productType = productTypeService.findProductTypeById(Integer.valueOf(jsonStr.substring(jsonStr.indexOf("=") + 1, jsonStr.length())));
//        		product.setProductType(productType);
//        		product.setTypeid(productType.getId());
//        	}
//        	
//        }
//        System.out.println(product);
//        productService.addProduct(product);
//        return "redirect:/product/list2";
//    } 
    
  
	@RequestMapping(value ="/product/add2", method = { RequestMethod.POST })
    @ResponseBody
	public String add(HttpServletRequest request, @RequestParam String name, 
    		@RequestParam String typeid, @RequestParam String price,
    		@RequestParam String icon, @RequestParam String remarks){  
        //System.out.println(idlistJson);  
        
		try {
	        Product product = new Product();
	        
	        product.setName(name);
	        product.setPrice(new BigDecimal(price));
	        product.setIcon(icon);
	        product.setRemarks(remarks);
	        ProductType productType = productTypeService.findProductTypeById(Integer.valueOf(typeid));
	        product.setProductType(productType);
			product.setTypeid(productType.getId());
			
	        System.out.println(product);
	        productService.addProduct(product);
	        return "OK";
        }catch(Exception e) {
        	return "FAIL";
        }
    } 
	
	@RequestMapping("/product/show")
    public String show(Model model,int id) {
    	System.out.println("开始编辑");
    	Product  product = productService.findProductById(id);
        model.addAttribute("product", product);
        return "product/show";
    }
	
    @RequestMapping("/product/toEdit2")
    public String toEdit(Model model,int id) {
    	System.out.println("开始编辑");
        
        Product  product = productService.findProductById(id);
        model.addAttribute("product", product);
        //model.addAttribute("categoryid", product.getProductType().getProductCategory().getId());
        //System.out.println("categoryid = " + product.getProductType().getProductCategory().getId() + "=================");
        return "product/Edit2";
    }

    @RequestMapping(value ="/product/edit2", method = { RequestMethod.POST })
    @ResponseBody
	public String edit(HttpServletRequest request, @RequestParam String id,
			@RequestParam String name, @RequestParam String typeid, 
			@RequestParam String price, @RequestParam String icon, 
			@RequestParam String remarks){  
        //System.out.println(idlistJson);  
        
		try {
	        Product product = new Product();
	        product.setId(Integer.valueOf(id));
	        product.setName(name);
	        product.setPrice(new BigDecimal(price));
	        product.setIcon(icon);
	        product.setRemarks(remarks);
	        ProductType productType = productTypeService.findProductTypeById(Integer.valueOf(typeid));
	        product.setProductType(productType);
			product.setTypeid(productType.getId());
			
	        System.out.println(product);
	        productService.updateProduct(product);
	        return "OK";
        }catch(Exception e) {
        	return "FAIL";
        }
    }
    

    @RequestMapping("/product/toDelete2")
    public String delete(int id) {
        productService.deleteProduct(id);
        return "redirect:/product/list2";
    }
}

