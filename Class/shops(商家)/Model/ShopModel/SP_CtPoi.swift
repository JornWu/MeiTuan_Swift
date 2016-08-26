//
//	SP_CtPoi.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct SP_CtPoi{

	var ctPoi : String!
	var poiid : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		ctPoi = dictionary["ct_poi"] as? String
		poiid = dictionary["poiid"] as? Int
	}

}