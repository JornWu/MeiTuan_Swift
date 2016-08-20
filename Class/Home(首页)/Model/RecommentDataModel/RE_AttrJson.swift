//
//	RE_AttrJson.swift
//
//	Create by JornWu on 18/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct RE_AttrJson{

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

}