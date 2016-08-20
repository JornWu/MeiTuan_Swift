//
//	RE_Optionalattr.swift
//
//	Create by JornWu on 18/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct RE_Optionalattr{

	var m11 : String!
	var m13 : String!
    var m81 : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		m11 = dictionary["11"] as? String
		m13 = dictionary["13"] as? String
        m81 = dictionary["81"] as? String
	}

}