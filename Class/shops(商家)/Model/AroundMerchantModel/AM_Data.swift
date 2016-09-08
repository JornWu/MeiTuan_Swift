//
//	AM_Data.swift
//
//	Create by JornWu on 8/9/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct AM_Data{

	var applelottery : Int!
	var attrJson : [AM_AttrJson]!
	var brandname : String!
	var cate : String!
	var channel : String!
	var ctype : Int!
	var dt : Int!
	var festcanuse : Int!
	var id : Int!
	var imgurl : String!
	var mealcount : String!
	var mname : String!
	var nobooking : Int!
	var price : Float!
	var range : String!
	var ratecount : Int!
	var rating : Int!
	var rdplocs : [AM_Rdploc]!
	var slug : String!
	var smstitle : String!
	var subcate : String!
	var title : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		applelottery = dictionary["applelottery"] as? Int
		attrJson = [AM_AttrJson]()
		if let attrJsonArray = dictionary["attrJson"] as? [NSDictionary]{
			for dic in attrJsonArray{
				let value = AM_AttrJson(fromDictionary: dic)
				attrJson.append(value)
			}
		}
		brandname = dictionary["brandname"] as? String
		cate = dictionary["cate"] as? String
		channel = dictionary["channel"] as? String
		ctype = dictionary["ctype"] as? Int
		dt = dictionary["dt"] as? Int
		festcanuse = dictionary["festcanuse"] as? Int
		id = dictionary["id"] as? Int
		imgurl = dictionary["imgurl"] as? String
		mealcount = dictionary["mealcount"] as? String
		mname = dictionary["mname"] as? String
		nobooking = dictionary["nobooking"] as? Int
		price = dictionary["price"] as? Float
		range = dictionary["range"] as? String
		ratecount = dictionary["rate-count"] as? Int
		rating = dictionary["rating"] as? Int
		rdplocs = [AM_Rdploc]()
		if let rdplocsArray = dictionary["rdplocs"] as? [NSDictionary]{
			for dic in rdplocsArray{
				let value = AM_Rdploc(fromDictionary: dic)
				rdplocs.append(value)
			}
		}
		slug = dictionary["slug"] as? String
		smstitle = dictionary["smstitle"] as? String
		subcate = dictionary["subcate"] as? String
		title = dictionary["title"] as? String
	}

}