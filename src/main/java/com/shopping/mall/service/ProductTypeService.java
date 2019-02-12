package com.shopping.mall.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shopping.mall.model.ProductType;

public interface ProductTypeService {

	boolean addProductType(ProductType productType);

	boolean updateProductType(ProductType productType);
	
	boolean deleteProductType(int id);
	
	ProductType findProductTypeById(int id);

	List<ProductType> findProductTypeListByCategoryId(int id);
	
	List<ProductType> findProductTypeListByName(String name);
	
	List<ProductType> findAll();
	
	List<ProductType> findProductTypeListByCategoryName(String name);
	
	boolean deleteProductTypes(List<String> idList);
}
