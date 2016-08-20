//
//	RE_RecommentDataModel.swift
//
//	Create by JornWu on 18/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct RE_RecommentDataModel{

	var data : [RE_Data]!
	var paging : RE_Paging!
	var server : RE_Server!
	var stid : String!
	var stids : [RE_Stid]!
	var tab : RE_Tab!
	var topics : RE_Tag!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		data = [RE_Data]()
		if let dataArray = dictionary["data"] as? [NSDictionary]{
			for dic in dataArray{
				let value = RE_Data(fromDictionary: dic)
				data.append(value)
			}
		}
		if let pagingData = dictionary["paging"] as? NSDictionary{
				paging = RE_Paging(fromDictionary: pagingData)
			}
		if let serverData = dictionary["server"] as? NSDictionary{
				server = RE_Server(fromDictionary: serverData)
			}
		stid = dictionary["stid"] as? String
		stids = [RE_Stid]()
		if let stidsArray = dictionary["stids"] as? [NSDictionary]{
			for dic in stidsArray{
				let value = RE_Stid(fromDictionary: dic)
				stids.append(value)
			}
		}
		if let tabData = dictionary["tab"] as? NSDictionary{
				tab = RE_Tab(fromDictionary: tabData)
			}
		if let topicsData = dictionary["topics"] as? NSDictionary{
				topics = RE_Tag(fromDictionary: topicsData)
			}
	}

}