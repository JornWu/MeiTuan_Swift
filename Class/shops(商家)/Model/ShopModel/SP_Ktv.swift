//
//	SP_Ktv.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct SP_Ktv{

	var ktvAbstracts : [AnyObject]!
	var ktvAppointStatus : Int!
	var ktvIUrl : String!
	var ktvIconURL : String!
	var ktvLowestPrice : Int!
	var ktvPromotionMsg : String!
	var tips : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		ktvAbstracts = dictionary["ktvAbstracts"] as? [AnyObject]
		ktvAppointStatus = dictionary["ktvAppointStatus"] as? Int
		ktvIUrl = dictionary["ktvIUrl"] as? String
		ktvIconURL = dictionary["ktvIconURL"] as? String
		ktvLowestPrice = dictionary["ktvLowestPrice"] as? Int
		ktvPromotionMsg = dictionary["ktvPromotionMsg"] as? String
		tips = dictionary["tips"] as? String
	}

}