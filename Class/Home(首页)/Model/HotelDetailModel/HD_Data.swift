//
//	HD_Data.swift
//
//	Create by JornWu on 20/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct HD_Data{

	var deals : [HD_Deal]!
	var strategy : String!
	var title : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		deals = [HD_Deal]()
		if let dealsArray = dictionary["deals"] as? [NSDictionary]{
			for dic in dealsArray{
				let value = HD_Deal(fromDictionary: dic)
				deals.append(value)
			}
		}
		strategy = dictionary["strategy"] as? String
		title = dictionary["title"] as? String
	}

}