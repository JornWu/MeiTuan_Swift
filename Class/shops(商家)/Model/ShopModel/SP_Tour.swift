//
//	SP_Tour.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct SP_Tour{

	var tourDetailDesc : String!
	var tourInfo : String!
	var tourMarketPrice : Int!
	var tourOpenTime : String!
	var tourPlaceName : String!
	var tourPlaceStar : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		tourDetailDesc = dictionary["tourDetailDesc"] as? String
		tourInfo = dictionary["tourInfo"] as? String
		tourMarketPrice = dictionary["tourMarketPrice"] as? Int
		tourOpenTime = dictionary["tourOpenTime"] as? String
		tourPlaceName = dictionary["tourPlaceName"] as? String
		tourPlaceStar = dictionary["tourPlaceStar"] as? String
	}

}