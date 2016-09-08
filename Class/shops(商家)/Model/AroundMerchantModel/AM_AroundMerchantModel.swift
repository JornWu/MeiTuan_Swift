//
//	AM_AroundMerchantModel.swift
//
//	Create by JornWu on 8/9/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct AM_AroundMerchantModel{

	var data : [AM_Data]!
	var paging : AM_Paging!
	var server : AM_Server!
	var stid : String!
	var stids : [AM_Stid]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		data = [AM_Data]()
		if let dataArray = dictionary["data"] as? [NSDictionary]{
			for dic in dataArray{
				let value = AM_Data(fromDictionary: dic)
				data.append(value)
			}
		}
		if let pagingData = dictionary["paging"] as? NSDictionary{
				paging = AM_Paging(fromDictionary: pagingData)
			}
		if let serverData = dictionary["server"] as? NSDictionary{
				server = AM_Server(fromDictionary: serverData)
			}
		stid = dictionary["stid"] as? String
		stids = [AM_Stid]()
		if let stidsArray = dictionary["stids"] as? [NSDictionary]{
			for dic in stidsArray{
				let value = AM_Stid(fromDictionary: dic)
				stids.append(value)
			}
		}
	}

}