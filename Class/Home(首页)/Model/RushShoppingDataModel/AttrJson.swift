//
//	AttrJson.swift
//
//	Create by JornWu on 16/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct AttrJson{

	var iconname : String!
	var key : Int!
	var status : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		iconname = dictionary["iconname"] as? String
		key = dictionary["key"] as? Int
		status = dictionary["status"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if iconname != nil{
			dictionary["iconname"] = iconname
		}
		if key != nil{
			dictionary["key"] = key
		}
		if status != nil{
			dictionary["status"] = status
		}
		return dictionary
	}

}