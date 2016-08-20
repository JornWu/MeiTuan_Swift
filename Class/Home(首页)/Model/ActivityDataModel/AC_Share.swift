//
//	AC_Share.swift
//
//	Create by JornWu on 18/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct AC_Share{

	var message : String!
	var url : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		message = dictionary["message"] as? String
		url = String.URLStringHttpToHttps(dictionary["url"] as! String)
	}

}