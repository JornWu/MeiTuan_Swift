//
//	Campaign.swift
//
//	Create by JornWu on 16/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Campaign{

	var buystatus : Int!
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
		color = dictionary["color"] as? String
		festival = dictionary["festival"] as? String
		infourl = dictionary["infourl"] as? String
		logo = dictionary["logo"] as? String
		longtitle = dictionary["longtitle"] as? String
		shorttag = dictionary["shorttag"] as? String
		tag = dictionary["tag"] as? String
		type = dictionary["type"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if buystatus != nil{
			dictionary["buystatus"] = buystatus
		}
		if color != nil{
			dictionary["color"] = color
		}
		if festival != nil{
			dictionary["festival"] = festival
		}
		if infourl != nil{
			dictionary["infourl"] = infourl
		}
		if logo != nil{
			dictionary["logo"] = logo
		}
		if longtitle != nil{
			dictionary["longtitle"] = longtitle
		}
		if shorttag != nil{
			dictionary["shorttag"] = shorttag
		}
		if tag != nil{
			dictionary["tag"] = tag
		}
		if type != nil{
			dictionary["type"] = type
		}
		return dictionary
	}

}