//
//	AGP_Deal.swift
//
//	Create by JornWu on 5/9/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct AGP_Deal{

	var applelottery : Int!
	var attrJson : [AGP_AttrJson]!
	var bookinginfo : String!
	var brandname : String!
	var campaignprice : Int!
	var campaigns : [AGP_Campaign]!
	var canbuyprice : Int!
	var cate : String!
	var channel : String!
	var couponbegintime : Int!
	var couponendtime : Int!
	var ctype : Int!
	var deposit : Int!
	var digestion : String!
	var dt : Int!
	var dtype : Int!
	var end : Int!
	var festcanuse : Int!
	var frontPoiCates : String!
	var id : Int!
	var imgurl : String!
	var isAvailableToday : Bool!
	var mealcount : String!
	var mlls : String!
	var mname : String!
	var mtitle : String!
	var nobooking : Int!
	var optionalattrs : AGP_Optionalattr!
	var price : Int!
	var pricecalendar : [AGP_Pricecalendar]!
	var range : String!
	var ratecount : Int!
	var rating : Int!
	var satisfaction : Int!
	var showtype : String!
	var slug : String!
	var smstitle : String!
	var solds : Int!
	var squareimgurl : String!
	var start : Int!
	var state : Int!
	var status : Int!
	var strategyStid : String!
	var subcate : String!
	var tag : AGP_Tag!
	var title : String!
	var value : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		applelottery = dictionary["applelottery"] as? Int
		attrJson = [AGP_AttrJson]()
		if let attrJsonArray = dictionary["attrJson"] as? [NSDictionary]{
			for dic in attrJsonArray{
				let value = AGP_AttrJson(fromDictionary: dic)
				attrJson.append(value)
			}
		}
		bookinginfo = dictionary["bookinginfo"] as? String
		brandname = dictionary["brandname"] as? String
		campaignprice = dictionary["campaignprice"] as? Int
		campaigns = [AGP_Campaign]()
		if let campaignsArray = dictionary["campaigns"] as? [NSDictionary]{
			for dic in campaignsArray{
				let value = AGP_Campaign(fromDictionary: dic)
				campaigns.append(value)
			}
		}
		canbuyprice = dictionary["canbuyprice"] as? Int
		cate = dictionary["cate"] as? String
		channel = dictionary["channel"] as? String
		couponbegintime = dictionary["couponbegintime"] as? Int
		couponendtime = dictionary["couponendtime"] as? Int
		ctype = dictionary["ctype"] as? Int
		deposit = dictionary["deposit"] as? Int
		digestion = dictionary["digestion"] as? String
		dt = dictionary["dt"] as? Int
		dtype = dictionary["dtype"] as? Int
		end = dictionary["end"] as? Int
		festcanuse = dictionary["festcanuse"] as? Int
		frontPoiCates = dictionary["frontPoiCates"] as? String
		id = dictionary["id"] as? Int
		imgurl = dictionary["imgurl"] as? String
		isAvailableToday = dictionary["isAvailableToday"] as? Bool
		mealcount = dictionary["mealcount"] as? String
		mlls = dictionary["mlls"] as? String
		mname = dictionary["mname"] as? String
		mtitle = dictionary["mtitle"] as? String
		nobooking = dictionary["nobooking"] as? Int
		if let optionalattrsData = dictionary["optionalattrs"] as? NSDictionary{
				optionalattrs = AGP_Optionalattr(fromDictionary: optionalattrsData)
			}
		price = dictionary["price"] as? Int
		pricecalendar = [AGP_Pricecalendar]()
		if let pricecalendarArray = dictionary["pricecalendar"] as? [NSDictionary]{
			for dic in pricecalendarArray{
				let value = AGP_Pricecalendar(fromDictionary: dic)
				pricecalendar.append(value)
			}
		}
		range = dictionary["range"] as? String
		ratecount = dictionary["rate-count"] as? Int
		rating = dictionary["rating"] as? Int
		satisfaction = dictionary["satisfaction"] as? Int
		showtype = dictionary["showtype"] as? String
		slug = dictionary["slug"] as? String
		smstitle = dictionary["smstitle"] as? String
		solds = dictionary["solds"] as? Int
		squareimgurl = dictionary["squareimgurl"] as? String
		start = dictionary["start"] as? Int
		state = dictionary["state"] as? Int
		status = dictionary["status"] as? Int
		strategyStid = dictionary["strategyStid"] as? String
		subcate = dictionary["subcate"] as? String
		if let tagData = dictionary["tag"] as? NSDictionary{
				tag = AGP_Tag(fromDictionary: tagData)
			}
		title = dictionary["title"] as? String
		value = dictionary["value"] as? Int
	}

}