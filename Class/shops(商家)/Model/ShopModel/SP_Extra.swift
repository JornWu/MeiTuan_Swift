//
//	SP_Extra.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct SP_Extra{

	var icons : [AnyObject]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		icons = dictionary["icons"] as? [AnyObject]
	}

}