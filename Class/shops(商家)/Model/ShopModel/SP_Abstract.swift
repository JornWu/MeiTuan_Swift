//
//	SP_Abstract.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct SP_Abstract{

	var coupon : String!
	var group : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		coupon = dictionary["coupon"] as? String
		group = dictionary["group"] as? String
	}

}