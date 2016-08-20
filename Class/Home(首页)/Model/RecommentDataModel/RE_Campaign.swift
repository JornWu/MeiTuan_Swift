//
//	RE_Campaign.swift
//
//	Create by JornWu on 18/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct RE_Campaign{

	var buystatus : Int!
	var campaignid : Int!
	var color : String!
	var festival : String!
	var infourl : String!
	var logo : String!
	var longtitle : String!
	var shorttag : String!
	var tag : String!
	var type : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		buystatus = dictionary["buystatus"] as? Int
		campaignid = dictionary["campaignid"] as? Int
		color = dictionary["color"] as? String
		festival = dictionary["festival"] as? String
		infourl = dictionary["infourl"] as? String
		logo = dictionary["logo"] as? String
		longtitle = dictionary["longtitle"] as? String
		shorttag = dictionary["shorttag"] as? String
		tag = dictionary["tag"] as? String
		type = dictionary["type"] as? Int
	}

}