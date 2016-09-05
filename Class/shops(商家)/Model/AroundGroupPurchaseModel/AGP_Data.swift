//
//	AGP_Data.swift
//
//	Create by JornWu on 5/9/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct AGP_Data{

	var catetab : [AGP_Catetab]!
	var deals : [AGP_Deal]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		catetab = [AGP_Catetab]()
		if let catetabArray = dictionary["catetab"] as? [NSDictionary]{
			for dic in catetabArray{
				let value = AGP_Catetab(fromDictionary: dic)
				catetab.append(value)
			}
		}
		deals = [AGP_Deal]()
		if let dealsArray = dictionary["deals"] as? [NSDictionary]{
			for dic in dealsArray{
				let value = AGP_Deal(fromDictionary: dic)
				deals.append(value)
			}
		}
	}

}