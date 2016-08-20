//
//	HD_Stid.swift
//
//	Create by JornWu on 20/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct HD_Stid{

	var dealid : Int!
	var stid : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		dealid = dictionary["dealid"] as? Int
		stid = dictionary["stid"] as? String
	}

}