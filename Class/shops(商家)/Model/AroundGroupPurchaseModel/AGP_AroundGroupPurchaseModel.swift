//
//	AGP_AroundGroupPurchase.swift
//
//	Create by JornWu on 5/9/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct AGP_AroundGroupPurchaseModel{

	var data : AGP_Data!
	var stid : String!
	var stids : [AGP_Stid]!
	var title : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		if let dataData = dictionary["data"] as? NSDictionary{
				data = AGP_Data(fromDictionary: dataData)
			}
		stid = dictionary["stid"] as? String
		stids = [AGP_Stid]()
		if let stidsArray = dictionary["stids"] as? [NSDictionary]{
			for dic in stidsArray{
				let value = AGP_Stid(fromDictionary: dic)
				stids.append(value)
			}
		}
		title = dictionary["title"] as? String
	}

}