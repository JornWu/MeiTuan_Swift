//
//	RushShoppingDataModel.swift
//
//	Create by JornWu on 16/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct RushShoppingDataModel{

	var data : Data!
	var paging : Paging!
	var server : Server!
	var stid : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		if let dataData = dictionary["data"] as? NSDictionary{
				data = Data(fromDictionary: dataData)
			}
		if let pagingData = dictionary["paging"] as? NSDictionary{
				paging = Paging(fromDictionary: pagingData)
			}
		if let serverData = dictionary["server"] as? NSDictionary{
				server = Server(fromDictionary: serverData)
			}
		stid = dictionary["stid"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if data != nil{
			dictionary["data"] = data.toDictionary()
		}
		if paging != nil{
			dictionary["paging"] = paging.toDictionary()
		}
		if server != nil{
			dictionary["server"] = server.toDictionary()
		}
		if stid != nil{
			dictionary["stid"] = stid
		}
		return dictionary
	}

}