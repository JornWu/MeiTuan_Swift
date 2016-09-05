//
//	AGP_Pricecalendar.swift
//
//	Create by JornWu on 5/9/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct AGP_Pricecalendar{

	var buyprice : Int!
	var dealid : Int!
	var desc : String!
	var endtime : Int!
	var id : Int!
	var price : Int!
	var range : [AnyObject]!
	var starttime : Int!
	var type : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		buyprice = dictionary["buyprice"] as? Int
		dealid = dictionary["dealid"] as? Int
		desc = dictionary["desc"] as? String
		endtime = dictionary["endtime"] as? Int
		id = dictionary["id"] as? Int
		price = dictionary["price"] as? Int
		range = dictionary["range"] as? [AnyObject]
		starttime = dictionary["starttime"] as? Int
		type = dictionary["type"] as? Int
	}

}