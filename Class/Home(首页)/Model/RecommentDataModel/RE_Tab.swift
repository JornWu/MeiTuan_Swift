//
//	RE_Tab.swift
//
//	Create by JornWu on 18/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct RE_Tab{

	var normalTitle : String!
	var tabTitle : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		normalTitle = dictionary["normalTitle"] as? String
		tabTitle = dictionary["tabTitle"] as? String
	}

}