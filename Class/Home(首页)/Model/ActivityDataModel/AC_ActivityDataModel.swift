//
//	AC_ActivityDataModel.swift
//
//	Create by JornWu on 18/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct AC_ActivityDataModel{

	var data : [AC_Data]!
	var paging : AC_Paging!
	var server : AC_Server!
	var stid : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		data = [AC_Data]()
		if let dataArray = dictionary["data"] as? [NSDictionary]{
			for dic in dataArray{
				let value = AC_Data(fromDictionary: dic)
				data.append(value)
			}
		}
		if let pagingData = dictionary["paging"] as? NSDictionary{
				paging = AC_Paging(fromDictionary: pagingData)
			}
		if let serverData = dictionary["server"] as? NSDictionary{
				server = AC_Server(fromDictionary: serverData)
			}
		stid = dictionary["stid"] as? String
	}

}