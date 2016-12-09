//
//	CA_Data.swift
//
//	Create by JornWu on 27/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct CA_Data{

    var area : Int!
    var city : String!
    var detail : String!
    var district : String!
    var id : Int!
    var isForeign : Bool!
    var lat : Float!
    var lng : Float!
    var parentArea : Int!
    var province : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		area = dictionary["area"] as? Int
		city = dictionary["city"] as? String
		detail = dictionary["detail"] as? String
		district = dictionary["district"] as? String
		id = dictionary["id"] as? Int
		isForeign = dictionary["isForeign"] as? Bool
		lat = dictionary["lat"] as? Float
		lng = dictionary["lng"] as? Float
		parentArea = dictionary["parentArea"] as? Int
		province = dictionary["province"] as? String
	}

}
