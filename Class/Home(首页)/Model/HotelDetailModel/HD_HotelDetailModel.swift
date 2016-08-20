//
//	HD_HotelDetailModel.swift
//
//	Create by JornWu on 20/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct HD_HotelDetailModel{

	var data : HD_Data!
	var stid : String!
	var stids : [HD_Stid]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		if let dataData = dictionary["data"] as? NSDictionary{
				data = HD_Data(fromDictionary: dataData)
			}
		stid = dictionary["stid"] as? String
		stids = [HD_Stid]()
		if let stidsArray = dictionary["stids"] as? [NSDictionary]{
			for dic in stidsArray{
				let value = HD_Stid(fromDictionary: dic)
				stids.append(value)
			}
		}
	}

}