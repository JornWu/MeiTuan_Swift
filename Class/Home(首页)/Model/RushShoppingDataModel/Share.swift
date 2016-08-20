//
//	Share.swift
//
//	Create by JornWu on 16/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Share{

	var imgurl : String!
	var message : String!
	var url : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		imgurl = dictionary["imgurl"] as? String
		message = dictionary["message"] as? String
		url = dictionary["url"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if imgurl != nil{
			dictionary["imgurl"] = imgurl
		}
		if message != nil{
			dictionary["message"] = message
		}
		if url != nil{
			dictionary["url"] = url
		}
		return dictionary
	}

}