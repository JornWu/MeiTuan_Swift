//
//	SP_PayAbstract.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct SP_PayAbstract{

	var abstractField : String!
	var iconUrl : String!
	var type : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		abstractField = dictionary["abstract"] as? String
		iconUrl = dictionary["icon_url"] as? String
		type = dictionary["type"] as? String
	}

}