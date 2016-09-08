//
//	AM_Rdploc.swift
//
//	Create by JornWu on 8/9/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct AM_Rdploc{

	var addr : String!
	var areaName : String!
	var areaid : Int!
	var avgScore : Float!
	var bizloginid : Int!
	var city : Int!
	var cityId : Int!
	var districtid : Int!
	var districtname : String!
	var frontimg : String!
	var lat : Float!
	var lng : Float!
	var markNumbers : Int!
	var multiType : String!
	var name : String!
	var phone : String!
	var poiid : Int!
	var showType : String!
	var traffic : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		addr = dictionary["addr"] as? String
		areaName = dictionary["areaName"] as? String
		areaid = dictionary["areaid"] as? Int
		avgScore = dictionary["avgScore"] as? Float
		bizloginid = dictionary["bizloginid"] as? Int
		city = dictionary["city"] as? Int
		cityId = dictionary["cityId"] as? Int
		districtid = dictionary["districtid"] as? Int
		districtname = dictionary["districtname"] as? String
		frontimg = dictionary["frontimg"] as? String
		lat = dictionary["lat"] as? Float
		lng = dictionary["lng"] as? Float
		markNumbers = dictionary["markNumbers"] as? Int
		multiType = dictionary["multiType"] as? String
		name = dictionary["name"] as? String
		phone = dictionary["phone"] as? String
		poiid = dictionary["poiid"] as? Int
		showType = dictionary["showType"] as? String
		traffic = dictionary["traffic"] as? String
	}

}