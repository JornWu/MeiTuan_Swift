//
//	RE_Data.swift
//
//	Create by JornWu on 18/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct RE_Data{

	var applelottery : Int!
	var attrJson : [RE_AttrJson]!
	var bookinginfo : String!
	var brandname : String!
	var campaignprice : Float!
	var campaigns : [RE_Campaign]!
	var canbuyprice : Float!
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
	var mId : Int!
	var imgurl : String!
	var isAvailableToday : Bool!
	var mealcount : String!
	var mlls : String!
	var mname : String!
	var mtitle : String!
	var nobooking : Int!
	var optionalattrs : RE_Optionalattr!
	var price : Int!
	var pricecalendar : [RE_Pricecalendar]!
	var range : String!
	var ratecount : Int!
	var rating : Float!
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
	var tag : RE_Tag!
	var title : String!
	var value : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		applelottery = dictionary["applelottery"] as? Int
		attrJson = [RE_AttrJson]()
		if let attrJsonArray = dictionary["attrJson"] as? [NSDictionary]{
			for dic in attrJsonArray{
				let value = RE_AttrJson(fromDictionary: dic)
				attrJson.append(value)
			}
		}
		bookinginfo = dictionary["bookinginfo"] as? String
		brandname = dictionary["brandname"] as? String
		campaignprice = dictionary["campaignprice"] as? Float
		campaigns = [RE_Campaign]()
		if let campaignsArray = dictionary["campaigns"] as? [NSDictionary]{
			for dic in campaignsArray{
				let value = RE_Campaign(fromDictionary: dic)
				campaigns.append(value)
			}
		}
		canbuyprice = dictionary["canbuyprice"] as? Float
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
		mId = dictionary["id"] as? Int
        
        //imgurl = dictionary["imgurl"] as? String
		//imgurl = String.URLStringHttpToHttps(dictionary["imgurl"] as! String)
        if dictionary["imgurl"] != nil && dictionary["imgurl"] as! String != "" {
            imgurl = String.URLStringHttpToHttps(dictionary["imgurl"] as! String)
            imgurl = String.URLStringW_HTo200_120(imgurl)
        }else {
            imgurl = dictionary["imgurl"] as? String
        }
        
		isAvailableToday = dictionary["isAvailableToday"] as? Bool
		mealcount = dictionary["mealcount"] as? String
		mlls = dictionary["mlls"] as? String
		mname = dictionary["mname"] as? String
		mtitle = dictionary["mtitle"] as? String
		nobooking = dictionary["nobooking"] as? Int
		if let optionalattrsData = dictionary["optionalattrs"] as? NSDictionary{
				optionalattrs = RE_Optionalattr(fromDictionary: optionalattrsData)
			}
		price = dictionary["price"] as? Int
		pricecalendar = [RE_Pricecalendar]()
		if let pricecalendarArray = dictionary["pricecalendar"] as? [NSDictionary]{
			for dic in pricecalendarArray{
				let value = RE_Pricecalendar(fromDictionary: dic)
				pricecalendar.append(value)
			}
		}
		range = dictionary["range"] as? String
		ratecount = dictionary["rate-count"] as? Int
		rating = dictionary["rating"] as? Float
		satisfaction = dictionary["satisfaction"] as? Int
		showtype = dictionary["showtype"] as? String
		slug = dictionary["slug"] as? String
		smstitle = dictionary["smstitle"] as? String
		solds = dictionary["solds"] as? Int
        
        if let squareimgurlString = dictionary["squareimgurl"] as? String {
            squareimgurl = String.URLStringHttpToHttps(squareimgurlString)
        }
            
		start = dictionary["start"] as? Int
		state = dictionary["state"] as? Int
		status = dictionary["status"] as? Int
		strategyStid = dictionary["strategyStid"] as? String
		subcate = dictionary["subcate"] as? String
		if let tagData = dictionary["tag"] as? NSDictionary{
				tag = RE_Tag(fromDictionary: tagData)
			}
		title = dictionary["title"] as? String
		value = dictionary["value"] as? Int
	}
    

}